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
  int likes;
  int dislikes;
  final DateTime release_date;
  List<String> comments = <String>[];

  PostModel({
    this.id,
    required this.username,
    required this.description,
    required this.release_date,
    this.likes = 0,
    this.dislikes = 0,
  });

  // void setLikes(int _likes) {
  //   likes = _likes;
  // }

  // void setDislikes(int _dislikes) {
  //   dislikes = _dislikes;
  // }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'description': description,
      'release_date': release_date,
      'likes': likes,
      'dislikes': dislikes,
      'comments': comments,
    };
  }

  // static PostModel fromMap(DocumentSnapshot Doc) {
  //   Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
  //   PostModel _postModel = PostModel(
  //       id: doc.id,
  //       username: map['username'] ?? '',
  //       description: map['description'] ?? '',
  //       release_date: map['release_date'] ?? DateTime.now(),
  //       likes: map['likes'] ?? 0,
  //       dislikes: map['dislikes'] ?? 0);
  // }
}
