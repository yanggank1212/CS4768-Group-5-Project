/// This will display the commenting page
/// it will display the post to be commented and the comment post to be made
///
import 'package:flutter/material.dart';
import 'package:poutine_time/model/post_model.dart'; // Import your PostModel class

class CommentPageScreen extends StatefulWidget {
  final PostModel postModel;

  const CommentPageScreen({Key? key, required this.postModel}) : super(key: key);

  @override
  _CommentPageScreenState createState() => _CommentPageScreenState();
}

class _CommentPageScreenState extends State<CommentPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commenting Post'),
      ),
      body: Container(), // Completely blank container
    );
  }
}
