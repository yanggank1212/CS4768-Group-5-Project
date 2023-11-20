import 'package:flutter/material.dart';
import 'package:poutine_time/model/user_model.dart';
import 'package:poutine_time/views/createPost_page.dart';
import 'package:poutine_time/views/accounts_page.dart';
import 'package:poutine_time/controller/user_controller.dart';

import 'feed_page.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key? key}) : super(key: key);

  final UserController userController = UserController();

  @override
  State<HomePageScreen> createState() => _HomePageScreen();
}

class _HomePageScreen extends State<HomePageScreen> {
  int _selectedIndex = 0; //For Bottom Bar Navigation
  Future<UserModel> userModel = UserController().getUserModel();

  @override
  void initState() {
    super.initState();
  }

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const FeedPageScreen(),
    const CreatePostPageScreen(),
    const AccountsPage(),
  ];

  @override
  Widget build(BuildContext context) {
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
