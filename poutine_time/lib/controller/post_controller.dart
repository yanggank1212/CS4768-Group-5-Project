///  This will handle the interactions related to Post entities
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:poutine_time/model/post_model.dart';

class PostControllerService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //late PostModel postModel;
  late List<PostModel> postList;
  final CollectionReference postCollection;

  PostControllerService()
      : postCollection = FirebaseFirestore.instance
            .collection('postCollection')
            .doc('postList')
            .collection('posts');

  Future<DocumentReference<Object?>> addPost(PostModel post) async {
    try {
      //Save Post to Firestore
      return await postCollection
          .add(post.toMap()); //Add Post Map to List of Posts
    } on FirebaseAuthException catch (authError) {
      // Handling errors
      print("Authentication Error: ${authError.message}");
      rethrow;
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

  Future<List<PostModel>> getPosts() async {
    try {
      var querySnapshot = await _firestore
          .collection('postCollection')
          .doc('postList')
          .collection('posts')
          .orderBy('release_date', descending: true)
          .get();

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

  void setPostList(List<PostModel> _postsList) {
    this.postList = _postsList;
  }

  List<PostModel> getPostList() {
    return postList;
  }

// Method to get the username by ID
}
