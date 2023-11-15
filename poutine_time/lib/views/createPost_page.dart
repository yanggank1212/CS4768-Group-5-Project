/// This page will display the Posting Page where a Post is created
///

import 'package:flutter/material.dart';

class CreatePostPageScreen extends StatefulWidget {
  const CreatePostPageScreen({Key? key}) : super(key: key);

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
