///  This will handle the interactions related to Post entities
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:poutine_time/model/post_model.dart';

class PostControllerService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late PostModel postModel;

  Future<void> addPost(PostModel post) async {
    try {
      var user = _auth.currentUser;
      if (user == null) {
        throw Exception("User not logged in");
      }

      // Creating a map with only the necessary fields for creating the post
      // Date is not added for now

      Map<String, dynamic> postData = {

        'userID': post.userID,
        'username': post.username,
        'description': post.description,

      };

      await _firestore.collection('posts').add(postData);

    } on FirebaseAuthException catch (authError) {
      // Handling errors
      print("Authentication Error: ${authError.message}");
    } on FirebaseException catch (dbError) {
      // Handle Firestore database errors
      print("Database Error: ${dbError.message}");
    } catch (e) {
      // Handle any other errors
      print("Error: ${e.toString()}");
    }
  }


  Future<List<PostModel>> getPosts() async {
    try {
      var querySnapshot = await _firestore.collection('posts').get();

      return querySnapshot.docs
          .map((doc) => PostModel.fromMap(doc.data(), doc.id))
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








// Method to get the username by ID


}