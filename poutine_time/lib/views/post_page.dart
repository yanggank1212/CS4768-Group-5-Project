/// This will display a Post
/// Will look different depending if user is creator of post or just a viewer

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  Future<void> _fetchComments() async {
    List<PostModel> comments = [];

    // Assuming you have a method to fetch a post by its ID
    for (String commentId in widget.postModel.comments) {
      PostModel commentPost =
          await StateManager.postController.fetchPostById(commentId);
      comments.add(commentPost);
    }

    setState(() {
      commentPosts = comments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display the original post
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: PostWidget(
              postModel: widget.postModel,
            ),
          ),
          // Display comments
          if (commentPosts.isNotEmpty)
            ...commentPosts.map(
              (comment) => Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
                child: PostWidget(
                  postModel: comment,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
