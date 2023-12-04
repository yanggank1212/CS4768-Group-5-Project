import 'package:flutter/material.dart';
import 'package:poutine_time/controller/state_manager.dart';
import 'package:poutine_time/model/post_model.dart';
import 'package:poutine_time/model/user_model.dart';
import 'package:poutine_time/views/Home/home_page.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // UserController userController = UserController();
  // PostControllerService postControllerService = PostControllerService();

  late Future<Map<String, dynamic>> initDataFuture;

  @override
  void initState() {
    super.initState();
    initDataFuture = initializeData();
  }

  Future<Map<String, dynamic>> initializeData() async {
    try {
      // Simulate a delay or fetch the userModel from an API
      await Future.delayed(Duration(seconds: 2));

      StateManager.userController.setUser();

      // Fetch both the Post List and the userModel concurrently
      var futures = <Future>[
        StateManager.postController.getPosts(),
        StateManager.userController
            .getUserModelData(StateManager.userController.getUserID()),
      ];

      var results = await Future.wait(futures);

      return {
        'postsList': results[0] as List<PostModel>,
        'userModel': results[1] as UserModel,
      };
    } catch (e) {
      // Handle error
      print('Error fetching data: $e');
      rethrow; // Rethrow the exception to mark it as handled
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: initDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading indicator while waiting for the data
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/graphics/loading_image.jpg',
                    height: 300,
                    width: 300,
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: LinearProgressIndicator(),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              // Handle error
              return Text('Error loading data');
            } else {
              // Data has been loaded, navigate to HomePageScreen
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Map<String, dynamic> data = snapshot.data!;
                List<PostModel> postsList = data['postsList'];
                UserModel userModel = data['userModel'];
                StateManager.userController.setUserModel(userModel);
                StateManager.postController.setPostList(postsList);
                //Pass userController (it contains userModel) to the HomePageScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePageScreen(),
                  ),
                );
              });

              return Container(); // Placeholder, not actually used
            }
          },
        ),
      ),
    );
  }
}
