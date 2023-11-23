
import 'package:cloud_firestore/cloud_firestore.dart';

/// This is the post model 1.0
/// String id
/// String username
/// String description
/// int likes
/// int dislikes
/// DateTime release_date
/// List<String> comments

class PostModel {
  final String? id;
  final String userID;
  final String username;
  final String description;
  List<String> likes;
  List<String> dislikes;
  final DateTime release_date;
  //List<String> comments = <String>[];

  // Likes and dislikes are added here as default values.
  PostModel({
    required this.userID,
    this.id,
    this.username = '',
    required this.description,
    required this.release_date,
    List<String>? likes,
    List<String>? dislikes,
    // List<String>? comments
  }) : this.likes = likes ?? [],
        this.dislikes = dislikes ?? [];
  // this.comments = comments ?? [];

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'description': description,
      'release_date': Timestamp.fromDate(release_date),
      'likes': likes,
      'dislikes': dislikes,
      //'comments': comments ?? <String>[],
    };
  }

  static PostModel fromMap(Map<String, dynamic> map, String documentId) {
    return PostModel(
      id: documentId,
      userID: map['userID'] ?? '',
      username: map['username'] ?? '',
      description: map['description'] ?? '',
      release_date: (map['release_date'] as Timestamp).toDate(),
      likes: List<String>.from(map['likes'] ?? []),
      dislikes: List<String>.from(map['dislikes'] ?? []),
      //comments: List<String>.from(map['comments'] ?? []),
    );
  }
}
