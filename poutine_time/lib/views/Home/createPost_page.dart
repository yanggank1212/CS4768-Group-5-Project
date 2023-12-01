import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poutine_time/controller/state_manager.dart';
import 'package:poutine_time/controller/user_controller.dart';
import 'package:poutine_time/model/post_model.dart';
import 'package:poutine_time/controller/post_controller.dart';
import 'package:poutine_time/model/user_model.dart';
import 'package:poutine_time/views/Home/home_page.dart';

class CreatePostPageScreen extends StatefulWidget {
  const CreatePostPageScreen({Key? key}) : super(key: key);

  @override
  _CreatePostPageScreenState createState() => _CreatePostPageScreenState();
}

class _CreatePostPageScreenState extends State<CreatePostPageScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  Future<void> _createPost() async {
    if (_descriptionController.text.isEmpty) {
      print("Fill Description");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Create a new PostModel instance with the necessary data
      PostModel newPost = PostModel(
        userID: StateManager.user.uid,
        username: StateManager.user.displayName!,
        description: _descriptionController.text,
        release_date: DateTime.now(), // Use current date and time
        likes: [], // Initializing likes as empty
        dislikes: [], // Initializing dislikes as an empty list
      );

      DocumentReference<Object?> documentReference =
          await StateManager.postController.addPost(newPost);

      _message();

      // Navigate back after the post is submitted
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePageScreen(),
        ),
      );

      // Handle post creation success
    } catch (e) {
      print("Error creating post: $e");
      // Display an error message to the user if needed.
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: SingleChildScrollView(
        // Use SingleChildScrollView to avoid overflow
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Enter your post description here...',
                border: OutlineInputBorder(),
                fillColor: Colors
                    .grey[200], // Light background color for the TextField
                filled: true,
              ),
              maxLines: 5, // Increased max lines
              minLines: 3, // Minimum lines
              style: TextStyle(fontSize: 16), // Text style
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createPost,
              child: const Text('Submit Post'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor, // Text color
                padding: EdgeInsets.symmetric(
                    horizontal: 50, vertical: 15), // Button padding
              ),
            ),
            if (_isLoading) ...[
              SizedBox(height: 20),
              const Center(child: CircularProgressIndicator()),
            ],
          ],
        ),
      ),
    );
  }

  // Message to display after the post is submitted
  void _message() {
    final snackBar = SnackBar(
      content: const Text('Post submitted!'),
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
    _descriptionController.dispose();
    super.dispose();
  }
}
