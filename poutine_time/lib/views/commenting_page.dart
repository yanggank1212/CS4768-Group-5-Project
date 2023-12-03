/// This will display the commenting page
/// it will display the post to be commented and the comment post to be made
///
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poutine_time/controller/state_manager.dart';
import 'package:poutine_time/controller/user_controller.dart';
import 'package:poutine_time/model/post_model.dart';
import 'package:poutine_time/views/Home/home_page.dart';
import 'package:poutine_time/views/components/post_widget.dart'; // Import your PostModel class

class CommentPageScreen extends StatefulWidget {
  final PostModel fatherPost;

  const CommentPageScreen({Key? key, required this.fatherPost})
      : super(key: key);

  @override
  _CommentPageScreenState createState() => _CommentPageScreenState();
}

class _CommentPageScreenState extends State<CommentPageScreen> {
  final TextEditingController _commentController = TextEditingController();

  Future<void> postComment() async {
    if (_commentController.text.isEmpty) {
      print("Fill Description");
      return;
    }

    //Create post
    try {
      // Create a new PostModel instance with the necessary data
      PostModel commentPost = PostModel(
          userID: StateManager.userController.getUserID(),
          username: StateManager.userController.getUsername(),
          description: _commentController.text,
          release_date: DateTime.now(), // Use current date and time
          threadFather: widget.fatherPost.id,
          channel: 'General');

      // DocumentReference<Object?> documentReference =
      //     await StateManager.postController.addPost(newPost);

      StateManager.postController.addComment(widget.fatherPost.id, commentPost);
      // StateManager.postController
      //     .updatePostComment(widget.postModel.id, documentReference.id);

      _message();

      // Navigate back after the post is submitted
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => HomePageScreen(),
      //   ),
      // );

      Navigator.pop(context);
    } catch (e) {
      print("Error creating post: $e");
      // Display an error message to the user if needed.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commenting'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostWidget(
            postModel: widget.fatherPost,
            displayInteractions: false,
            displayPostOption: false,
            isTappable: false,
          ),
          const SizedBox(height: 16),
          // Text field for entering a comment
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                hintText: 'Enter your comment...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ),
          // Button to submit the comment
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: postComment,
              child: const Text('Submit Comment'),
            ),
          ),
        ],
      ),
    );
  }

  // Message to display after the post is submitted
  void _message() {
    final snackBar = SnackBar(
      content: const Text('Comment submitted!'),
      backgroundColor: Colors.blueAccent,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
