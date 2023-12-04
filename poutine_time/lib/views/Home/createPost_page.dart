import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poutine_time/controller/state_manager.dart';
import 'package:poutine_time/model/post_model.dart';
import 'package:poutine_time/views/Home/home_page.dart';
import 'package:poutine_time/model/channel_model.dart';
import 'package:poutine_time/model/Templates/channels.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

class CreatePostPageScreen extends StatefulWidget {
  const CreatePostPageScreen({Key? key}) : super(key: key);

  @override
  _CreatePostPageScreenState createState() => _CreatePostPageScreenState();
}

class _CreatePostPageScreenState extends State<CreatePostPageScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  ChannelModel _selectedChannel = channels[0];

  // For images

  List<XFile> _selectedImages = [];

  // Pick image from gallery
  Future<void> _pickImageFromGallery() async {
    XFile? selectedImage =
        await StateManager.postController.pickImageFromGallery();
    if (selectedImage != null) {
      setState(() {
        _selectedImages.add(selectedImage);
      });
    }
  }

  // Pick image from camera
  Future<void> _pickImageFromCamera() async {
    XFile? selectedImage =
        await StateManager.postController.pickImageFromCamera();
    if (selectedImage != null) {
      setState(() {
        _selectedImages.add(selectedImage);
      });
    }
  }

  Future<void> _createPost() async {
    if (_descriptionController.text.isEmpty) {
      print("Fill Description");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Convert XFile to File
      List<File> imageFiles =
          _selectedImages.map((xFile) => File(xFile.path)).toList();

      // Create a new PostModel instance with the necessary data
      PostModel newPost = PostModel(
        userID: StateManager.userController.getUserID(),
        username: StateManager.userController.getUsername(),
        description: _descriptionController.text,
        release_date: DateTime.now(), // Use current date and time
        likes: [], // Initializing likes as empty
        dislikes: [],
        channel: _selectedChannel.id, // Initializing dislikes as an empty list
      );

      DocumentReference<Object?> documentReference =
          await StateManager.postController.addPost(newPost, imageFiles);

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
    // Define the colors from the logo
    const Color maroonColor = Color(0xFF8C1D40);
    const Color backgroundColor = Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create a poutine!',
          style: GoogleFonts.lato(), // Applying Lato font from Google Fonts
        ),
        backgroundColor: maroonColor, // Use the maroon color for the app bar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What’s on your mind?',
              style: GoogleFonts.lato(
                // Applying Lato font from Google Fonts
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: maroonColor, // Use the maroon color for text
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Share your thoughts...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  borderSide: BorderSide(color: maroonColor), // Maroon border
                ),
                fillColor: backgroundColor,
                filled: true,
              ),
              maxLines: 5,
              minLines: 3,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            //Category
            Text(
              'Channel',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: maroonColor,
              ),
            ),
            SizedBox(height: 8),
            DropdownButton<ChannelModel>(
              value: _selectedChannel,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: maroonColor,
              ),
              onChanged: (ChannelModel? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedChannel = newValue;
                  });
                }
              },
              items: channels
                  .map<DropdownMenuItem<ChannelModel>>((ChannelModel channel) {
                return DropdownMenuItem<ChannelModel>(
                  value: channel,
                  child: Text(channel.name),
                );
              }).toList(), // Added toList() to fix the type issue
            ),

            SizedBox(height: 20),

            // Image Upload Section
            Text(
              'Add Images',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: maroonColor, // Use the maroon color for text
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageButton(
                  icon: Icons.image,
                  label: 'Gallery',
                  onPressed: _pickImageFromGallery,
                  iconColor: maroonColor, // Use the maroon color for icons
                  textColor: maroonColor, // Use the maroon color for text
                ),
                _buildImageButton(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onPressed: _pickImageFromCamera,
                  iconColor: maroonColor, // Use the maroon color for icons
                  textColor: maroonColor, // Use the maroon color for text
                ),
              ],
            ),
            SizedBox(height: 12),

            // Display selected images
            _buildSelectedImagesSection(),

            // Submit Button
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createPost,
              child: Text(
                'Submit Post',
                style: GoogleFonts.lato(
                  color: Colors.white, // Text color
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(maroonColor),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded button
                  ),
                ),
                elevation:
                    MaterialStateProperty.all<double>(5.0), // Add elevation
                shadowColor: MaterialStateProperty.all<Color>(
                    Colors.black.withOpacity(0.5)), // Shadow color
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

  // Helper method to build image selection buttons
  Widget _buildImageButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color iconColor,
    required Color textColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, size: 30),
          color: iconColor,
          onPressed: onPressed,
        ),
        Text(label, style: TextStyle(color: textColor)),
      ],
    );
  }

// Helper method to display selected images
  Widget _buildSelectedImagesSection() {
    return GridView.builder(
      shrinkWrap: true, // Use it inside a Scrollable widget
      physics: NeverScrollableScrollPhysics(), // Disable scroll inside the grid
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of images per row
        crossAxisSpacing: 4, // Spacing between images
        mainAxisSpacing: 4,
      ),
      itemCount: _selectedImages.length,
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurple), // Border color
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              margin: EdgeInsets.all(4), // Margin around each image
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8), // Rounded corners
                child: Image.file(
                  File(_selectedImages[index].path),
                  fit: BoxFit.cover, // Cover the entire space of the box
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.cancel, size: 20, color: Colors.red),
              onPressed: () {
                setState(() {
                  _selectedImages.removeAt(index);
                });
              },
            ),
          ],
        );
      },
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
