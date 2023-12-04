/// This will display a Post
/// Will look different depending if user is creator of post or just a viewer

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poutine_time/controller/state_manager.dart';
import 'package:poutine_time/model/post_model.dart';
import 'components/post_widget.dart';

class PostPageScreen extends StatefulWidget {
  final PostModel postModel;

  const PostPageScreen({Key? key, required this.postModel}) : super(key: key);

  @override
  _PostPageScreenState createState() => _PostPageScreenState();
}

class _PostPageScreenState extends State<PostPageScreen> {
  List<PostModel> commentPosts = [];
  final Color maroonColor = const Color(0xFF8C1D40);

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  Future<void> _fetchComments() async {
    List<PostModel> comments = await StateManager.postController
        .fetchComments(widget.postModel.comments);

    setState(() {
      commentPosts = comments;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isCreator = StateManager.userController.getUserID() == widget.postModel.userID;

    return Scaffold(
      appBar: AppBar(
        title: Text('Post Page', style: GoogleFonts.lato(color: Colors.white)),
        backgroundColor: maroonColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the original post
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: PostWidget(
                postModel: widget.postModel,
                isTappable: false,
                displayPostOption: isCreator, // Show post options only if the user is the creator
              ),
            ),
            Divider(color: maroonColor),
            // Display comments
            ...commentPosts.map(
                  (comment) => Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: PostWidget(
                  postModel: comment,
                  displayUsername: true,
                  displayInteractions: true,
                  displayPostOption: StateManager.userController.getUserID() == comment.userID,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

