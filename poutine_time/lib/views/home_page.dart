import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poutine_time/model/user_model.dart';
import 'package:poutine_time/views/createPost_page.dart';
import 'package:poutine_time/views/accounts_page.dart';
import 'package:poutine_time/controller/user_controller.dart';

import 'feed_page.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key? key}) : super(key: key);
  @override
  State<HomePageScreen> createState() => _HomePageScreen();
}

class _HomePageScreen extends State<HomePageScreen> {
  int _selectedIndex = 0; //For Bottom Bar Navigation
  UserController userController = UserController();
  //late UserModel userModel;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    // Wait for the completion of the asynchronous call
    userController.userModel = await userController.getUserModelData();

    setState(() {});
  }

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      FeedPageScreen(userModel: userController.userModel),
      CreatePostPageScreen(userModel: userController.userModel),
      AccountsPage(userModel: userController.userModel),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          // Home Button
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 32,
              height: 32,
              child: Image.asset(
                'assets/icons/home-button.png',
              ),
            ),
            label: 'Feed',
          ),
          // New Post Button
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 32,
              height: 32,
              child: Image.asset(
                'assets/icons/edit-button.png',
              ),
            ),
            label: 'Create Post',
          ),
          // Account Button
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 32,
              height: 32,
              child: Image.asset(
                'assets/icons/account-button.png',
              ),
            ),
            label: 'Account',
          ),
        ],
        onTap: _navigateBottomBar,
      ),
    );
  }
}
