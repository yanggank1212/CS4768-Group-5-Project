
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
  final String username;
  final String description;
  List<String> likes;
  List<String> dislikes;
  final DateTime release_date;
  //List<String> comments = <String>[];

  PostModel({
    this.id,
    required this.username,
    required this.description,
    required this.release_date,
    required this.likes,
    required this.dislikes,
    //this.comments
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'description': description,
      'release_date': release_date,
      'likes': likes,
      'dislikes': dislikes,
      //'comments': comments ?? <String>[],
    };
  }

  // static PostModel fromMap(DocumentSnapshot doc) {
  //   Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
  //   return PostModel(
  //     id: doc.id,
  //     username: map['username'] ?? '',
  //     description: map['description'] ?? '',
  //     release_date: (map['release_date'] as Timestamp).toDate() ?? DateTime.now(),
  //     likes: map['likes'] ?? 0,
  //     dislikes: map['dislikes'] ?? 0,
  //   );
  // }
}
