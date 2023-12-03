///  This will handle the interactions related to Post entities
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:poutine_time/model/post_model.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PostControllerService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  //late PostModel postModel;
  late List<PostModel> postList;
  late CollectionReference postCollection;


  PostControllerService() {
    postCollection = _firestore.collection('postCollection');
  }

  Future<XFile?> pickImageFromGallery() async {
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  Future<XFile?> pickImageFromCamera() async {
    return await _picker.pickImage(source: ImageSource.camera);
  }

  Future<List<String>> uploadImages(List<File> images) async {
    List<String> imageUrls = [];
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) throw Exception('No user signed in.');

    for (File image in images) {
      // Define the file path on Firebase Storage with user-specific directory
      String filePath = 'images/${currentUser.uid}/${DateTime.now()}_${image.path.split('/').last}';

      // Upload image
      var firebaseStorageRef = FirebaseStorage.instance.ref().child(filePath);
      var uploadTask = await firebaseStorageRef.putFile(image);

      // Check if upload is successful
      if (uploadTask.state != TaskState.success) {
        throw Exception('Failed to upload image');
      }

      // Get image URL and add to the list
      String downloadURL = await firebaseStorageRef.getDownloadURL();
      imageUrls.add(downloadURL);
    }

    return imageUrls;
  }


  Future<DocumentReference<Object?>> addPost(PostModel post, [List<File>? images]) async {
    try {
      List<String> imageUrls = [];

      // Check if images are provided and not empty
      if (images != null && images.isNotEmpty) {
        // Upload images and get their URLs
        imageUrls = await uploadImages(images);
        // Add the image URLs to the post model
        post.imageUrls = imageUrls;
      }

      // Save the Post to Firestore (with or without image URLs)
      return await postCollection.add(post.toMap());
    } on FirebaseAuthException catch (authError) {
      print("Authentication Error: ${authError.message}");
      rethrow;
    } on FirebaseException catch (dbError) {
      print("Database Error: ${dbError.message}");
      rethrow;
    } catch (e) {
      print("Error: ${e.toString()}");
      rethrow;
    }
  }


  Future<List<PostModel>> getPosts() async {
    try {
      var querySnapshot = await _firestore
          .collection('postCollection')
          .orderBy('release_date', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => PostModel.fromMap(doc.data(), doc.id))
          .where((post) => post.threadFather == "")
          .toList();
    } on FirebaseException catch (dbError) {
      // Handling Firestore database errors
      print("Database Error: ${dbError.message}");
      return [];
    } catch (e) {
      print("Error: ${e.toString()}");
      return [];
    }
  }

  Future<void> addComment(String? fatherID, PostModel comment) async {
    try {
      //Add the comment to the post collection
      // DocumentReference commentDocRef =
      //     await postCollection.add(comment.toMap());

      DocumentReference<Object?> commentRef = await addPost(comment);

      print("Hello");
      // Update the father's comments list with the comment ID
      await postCollection.doc(fatherID).update({
        'comments': FieldValue.arrayUnion([commentRef.id]),
      });
    } on FirebaseException catch (dbError) {
      // Handle Firestore database errors
      print("Database Error: ${dbError.message}");
      rethrow;
    } catch (e) {
      // Handle any other errors
      print("Error: ${e.toString()}");
      rethrow;
    }
  }

  Future<PostModel> fetchComment(String commentID) async {
    try {
      DocumentSnapshot<Object?> postSnapshot =
          await postCollection.doc(commentID).get();

      if (postSnapshot.exists) {
        return PostModel.fromMap(
            postSnapshot.data() as Map<String, dynamic>, postSnapshot.id);
      } else {
        // Post with the specified ID not found
        throw Exception('Post not found');
      }
    } on FirebaseException catch (e) {
      // Handle Firestore database errors
      print("Database Error: ${e.message}");
      rethrow;
    } catch (e) {
      // Handle any other errors
      print("Error: ${e.toString()}");
      rethrow;
    }
  }

  Future<List<PostModel>> fetchComments(List<String> comments) async {
    List<PostModel> commentsList = [];

    try {
      // Assuming you have a method to fetch a post by its ID
      for (String commentId in comments) {
        PostModel commentPost = await fetchComment(commentId);
        commentsList.add(commentPost);
      }
      return commentsList;
    } catch (e) {
      print("Error: ${e.toString()}");
      rethrow;
    }
  }

  void setPostList(List<PostModel> _postsList) {
    this.postList = _postsList;
  }

  List<PostModel> getPostList() {
    return postList;
  }

// Method to get the username by ID
}
