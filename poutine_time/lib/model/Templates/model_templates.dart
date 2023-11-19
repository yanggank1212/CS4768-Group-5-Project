//import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:poutine_time/model/post_model.dart';
import 'package:poutine_time/model/user_model.dart';

class PostModelTemplate {
  PostModel postModelTemplate() {
    return PostModel(
      username: 'John Doe',
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer et mi elit. Fusce metus dolor, efficitur id arcu sed, dapibus hendrerit dolor. Nam fringilla iaculis dui sit amet dapibus. Aliquam iaculis lorem eget lacus congue, eu laoreet tortor tempus. Maecenas interdum nulla ligula, at sollicitudin ante volutpat quis. Nam fermentum ut nisi id fringilla. Cras venenatis id nunc ut dictum. Etiam volutpat interdum suscipit. Nulla auctor sit amet nisi facilisis pharetra. Integer leo est, feugiat eu lorem sed, elementum mattis diam. Nunc pellentesque scelerisque vulputate. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc in nisi arcu. Cras vel ipsum porttitor, malesuada sapien a, volutpat magna. Donec sit amet diam nec eros aliquam porttitor eu sed turpis. Duis sed vehicula urna, vitae semper quam. In sollicitudin pharetra ipsum sed bibendum. Sed interdum vehicula metus, in.",
      release_date: DateTime.now(),
      likes: <String>[],
      dislikes: <String>[],
    );
  }
}

class UserModelTemplate {
  UserModel userModelTemplate() {
    return UserModel(username: "johnDoe");
  }
}
