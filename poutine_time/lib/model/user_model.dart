import 'package:cloud_firestore/cloud_firestore.dart';

/// This is the user model 1.0
/// String username
///

class UserModel {
  final String username;

  UserModel({required this.username});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
    };
  }

  static UserModel fromMap(DocumentSnapshot doc, String userID) {
    Map<String, dynamic>? userDataMap = doc.data() as Map<String, dynamic>?;
    Map<String, dynamic> userData = userDataMap?[userID];
    return UserModel(username: userData['username']);
  }
}
