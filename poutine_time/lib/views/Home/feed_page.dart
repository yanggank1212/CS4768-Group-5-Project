import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poutine_time/controller/post_controller.dart';
import 'package:poutine_time/controller/state_manager.dart';
import 'package:poutine_time/controller/user_controller.dart';
import 'package:poutine_time/model/Templates/channels.dart';
import 'package:poutine_time/model/Templates/model_templates.dart';
import 'package:poutine_time/model/post_model.dart';
import 'package:poutine_time/model/user_model.dart';
import 'package:poutine_time/views/components/chanel_sidebar_widget.dart';
import '../components/post_widget.dart';

class FeedPageScreen extends StatefulWidget {
  FeedPageScreen({Key? key}) : super(key: key);

  @override
  State<FeedPageScreen> createState() => _FeedpageScreen();
}

class _FeedpageScreen extends State<FeedPageScreen> {
  bool _isLoading = false; // Add a variable to track loading state
  String selectedChannel = '1';

  final Color primaryColor = Color(0xFF8C1D40); // Maroon-like color
  final Color accentColor = Color(0xFFB1A7A6); // Accent grey

  @override
  void initState() {
    super.initState();
    _fetchPosts();

    StateManager.postController.addListener(_onPostsChange);
  }

  void _onPostsChange() {
    // Trigger a rebuild when posts change
    setState(() {});
  }

  Future<void> _fetchPosts() async {
    setState(() {
      _isLoading = true; // Set loading to true when starting the fetch
    });

    try {
      // Fetch the latest posts from the server
      List<PostModel> latestPosts = await StateManager.postController
          .getPosts(selectedChannel: selectedChannel);

      // Update the postList in the PostController
      StateManager.postController.setPostList(latestPosts);

      // Force a rebuild of the widget tree
      setState(() {});
    } catch (e) {
      // Handle error
      print("Error fetching posts: $e");
    } finally {
      setState(() {
        _isLoading = false; // Set loading to false when fetch is completed
      });
    }
  }

  PreferredSizeWidget _feedAppBar(String? username) {
    return AppBar(
      title: Text(
        'Poutines',
        style: GoogleFonts.tangerine(
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 30, // Adjust the size to your preference
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: primaryColor,
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            username ?? "No Name",
            style: GoogleFonts.jetBrainsMono(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }


  Widget _bodyWidget(List<PostModel> postLists) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (postLists.isEmpty) {
      return Center(child: Text('No posts to display', style: GoogleFonts.inter(color: accentColor)));
    }
    return RefreshIndicator(
      onRefresh: _fetchPosts,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: postLists.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: PostWidget(postModel: postLists[index]),
          );
        },
      ),
    );
  }


  @override
  void dispose() {
    // Remove the listener when the widget is disposed
    StateManager.postController.removeListener(_onPostsChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _feedAppBar(StateManager.userController.getUsername()),
      drawer: ChannelSidebar(
        channels: channels,
        onChannelSelected: (channel) {
          setState(() {
            selectedChannel = channel;
          });
          _fetchPosts();
        },
      ),
      body: _bodyWidget(StateManager.postController.getPostList()),
    );
  }
}
