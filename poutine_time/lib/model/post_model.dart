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
  List<String> imageUrls;
  List<String> comments;
  String threadFather; // To know if a post is the child of another post
  String channel;

  // UserController userController = UserController();

  // Likes and dislikes are added here as default values.
  PostModel({
    required this.userID,
    this.id,
    this.username = '',
    required this.description,
    required this.release_date,
    List<String>? likes,
    List<String>? dislikes,
    List<String>? comments,
    List<String>? imageUrls,
    String? threadFather,
    required this.channel, //General, Education, Clubs & Society, Sprots Arts & Culture
  })  : this.likes = likes ?? [],
        this.dislikes = dislikes ?? [],
        this.comments = comments ?? [],
        this.imageUrls = imageUrls ?? [],
        this.threadFather = threadFather ?? "";

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'username': username,
      'description': description,
      'release_date': Timestamp.fromDate(release_date),
      'likes': likes,
      'dislikes': dislikes,
      'comments': comments,
      'imageUrls': imageUrls,
      'threadFather': threadFather,
      'channel': channel,
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
        comments: List<String>.from(map['comments'] ?? []),
        imageUrls: List<String>.from(map['imageUrls'] ?? []),
        threadFather: map['threadFather'] ?? '',
        channel: map['channel'] ?? '1');
  }

  void printDetails() {
    print('Post Details:');
    print('ID: $id');
    print('User ID: $userID');
    print('Username: $username');
    print('Description: $description');
    print('Likes: $likes');
    print('Dislikes: $dislikes');
    print('Release Date: $release_date');
    print('Comments (IDs): $comments');
  }

  void addComment(String commentId) {
    if (!comments.contains(commentId)) {
      comments.add(commentId);
    } else {
      print('Comment ID $commentId is already in the list.');
    }
  }
}
