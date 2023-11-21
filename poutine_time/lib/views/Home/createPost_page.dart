/// This page will display the Posting Page where a Post is created
///

import 'package:flutter/material.dart';
import 'package:poutine_time/controller/user_controller.dart';
import 'package:poutine_time/model/user_model.dart';

class CreatePostPageScreen extends StatefulWidget {
  final UserController userController;
  CreatePostPageScreen({Key? key, required this.userController})
      : super(key: key);

  @override
  _CreatePostPageScreenState createState() => _CreatePostPageScreenState();
}

class _CreatePostPageScreenState extends State<CreatePostPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: Container(), // Completely blank container
    );
  }
}
