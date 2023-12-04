import 'package:firebase_auth/firebase_auth.dart';
import 'package:poutine_time/controller/post_controller.dart';
import 'package:poutine_time/controller/user_controller.dart';

/// So That we dont have to keep passing UserController and PostController as parameters all the time
///

class StateManager {
  // static late User user;
  static late PostControllerService postController;
  static late UserController userController;
  FirebaseAuth auth = FirebaseAuth.instance;

  static void initialize() {
    postController = PostControllerService();
    userController = UserController();
  }
}
