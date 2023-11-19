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
}
