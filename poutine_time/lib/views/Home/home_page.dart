import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poutine_time/model/user_model.dart';
import 'package:poutine_time/views/Home/createPost_page.dart';
import 'package:poutine_time/views/Home/accounts_page.dart';
import 'package:poutine_time/controller/user_controller.dart';

import 'feed_page.dart';

class HomePageScreen extends StatefulWidget {
  final UserController userController;
  HomePageScreen({Key? key, required this.userController}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreen();
}

class _HomePageScreen extends State<HomePageScreen> {
  int _selectedIndex = 0; //For Bottom Bar Navigation

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
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
      //Pass Usercontroller to these 3 pages
      FeedPageScreen(userController: widget.userController),
      CreatePostPageScreen(userController: widget.userController),
      AccountsPage(userController: widget.userController),
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