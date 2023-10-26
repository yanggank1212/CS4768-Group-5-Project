import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Post {
  final String title;
  final String content;
  final String uid; // Post Owner's UID

  Post({required this.title, required this.content, required this.uid});
}

class PostModel with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference postsRef = FirebaseFirestore.instance.collection('posts');

  List<Post> _posts = [];

  List<Post> get posts => _posts;

  PostModel() {
    fetchPosts();
  }

  fetchPosts() async {
    var result = await postsRef.get();
    _posts = result.docs.map((doc) => Post(title: doc['title'], content: doc['content'], uid: doc['uid'])).toList();
    notifyListeners();
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = reference.putFile(imageFile);
      TaskSnapshot storageTaskSnapshot = await uploadTask.whenComplete(() => {});
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }

  addPost(String title, String content, [String? imageUrl]) async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      if (imageUrl != null) {
        await postsRef.add({
          'title': title,
          'content': content,
          'imageUrl': imageUrl,
          'uid': uid,
        });
      } else {
        await postsRef.add({
          'title': title,
          'content': content,
          'uid': uid,
        });
      }
      fetchPosts();
    }
  }
}
