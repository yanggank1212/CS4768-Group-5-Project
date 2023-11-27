import 'package:poutine_time/controller/post_controller.dart';
import 'package:poutine_time/controller/user_controller.dart';
import 'package:poutine_time/model/user_model.dart';

/// So That we dont have to keep passing UserController and PostController as parameters all the time
///

class StateManager {
  static late UserController userController;
  static late PostControllerService postController;

  static void initialize() {
    userController = UserController();
    postController = PostControllerService();
  }
}
