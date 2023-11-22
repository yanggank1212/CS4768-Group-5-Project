import 'package:flutter/material.dart';
import 'package:poutine_time/controller/user_controller.dart';
import 'package:poutine_time/model/user_model.dart';
import 'package:poutine_time/views/Home/home_page.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  UserController userController = UserController();
  late Future<UserModel> userModelFuture;

  @override
  void initState() {
    super.initState();
    userModelFuture = initializeData();
  }

  Future<UserModel> initializeData() async {
    try {
      // Simulate a delay or fetch the userModel from an API
      await Future.delayed(Duration(seconds: 2));

      // Fetch the userModel
      return userController.getUserModelData();
    } catch (e) {
      // Handle error
      print('Error fetching userModel: $e');
      rethrow; // Rethrow the exception to mark it as handled
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<UserModel>(
          future: userModelFuture,
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
                UserModel userModel = snapshot.data!;
                userController.setUserModel(userModel);
                //Pass userController (it contains userModel) to the HomePageScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomePageScreen(userController: userController),
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
