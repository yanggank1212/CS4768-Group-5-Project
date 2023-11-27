import 'package:flutter/material.dart';
import 'package:poutine_time/controller/post_controller.dart';
import 'package:poutine_time/controller/state_manager.dart';
import 'package:poutine_time/controller/user_controller.dart';
import 'package:poutine_time/model/Templates/model_templates.dart';
import 'package:poutine_time/model/post_model.dart';
import 'package:poutine_time/model/user_model.dart';
import '../components/post_widget.dart';

class FeedPageScreen extends StatefulWidget {
  FeedPageScreen({Key? key}) : super(key: key);

  @override
  State<FeedPageScreen> createState() => _FeedpageScreen();
}

class _FeedpageScreen extends State<FeedPageScreen> {
  bool _isLoading = false; // Add a variable to track loading state

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    setState(() {
      _isLoading = true; // Set loading to true when starting the fetch
    });

    try {
      // Fetch the latest posts from the server
      List<PostModel> latestPosts =
          await StateManager.postController.getPosts();

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

  Future<void> _refresh() async {
    // Simulate loading new data
    await Future.delayed(const Duration(seconds: 2));

    // Add 5 more PostModel instances on top of the existing list
    setState(() {
      // posts.addAll(
      //     List.generate(5, (index) => PostModelTemplate().postModelTemplate()));
    });
    print("Refresh");
  }

  PreferredSizeWidget feedAppBar(String username) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //Feed Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'FEED',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: 1.2125,
                //color: Color(0xff000000),
              ),
            ),
          ),
          //Username
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              username,
              style: const TextStyle(
                fontFamily: 'JetBrains Mono',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 1.1,
                //color: Color(0xff000000),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bodyWidget(List<PostModel> postLists) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(), // Show loading indicator
      );
    }

    if (postLists.isEmpty) {
      // Display a message when the list is empty
      return Center(
        child: Text('Empty List'),
      );
    }

    // Display the posts
    return RefreshIndicator(
      onRefresh: _fetchPosts,
      child: ListView.builder(
        itemCount: postLists.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: PostWidget(
              postModel: postLists[index],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: feedAppBar(StateManager.userController.getUsername()),
        body: bodyWidget(StateManager.postController.getPostList()));
  }
}
