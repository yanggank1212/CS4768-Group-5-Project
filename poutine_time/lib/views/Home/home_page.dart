import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:poutine_time/controller/post_controller.dart';
import 'package:poutine_time/model/post_model.dart';
import 'package:poutine_time/model/user_model.dart';
import 'package:poutine_time/views/Home/createPost_page.dart';
import 'package:poutine_time/views/Home/accounts_page.dart';
import 'package:poutine_time/controller/user_controller.dart';

import 'feed_page.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreen();
}

class _HomePageScreen extends State<HomePageScreen> {
  int _selectedIndex = 0; //For Bottom Bar Navigation

  // Defining color scheme
  final Color maroonColor = Color(0xFF8C1D40);
  final Color lightTextColor = Colors.white;
  final Color darkTextColor = Colors.black;

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
    // Determine the text color based on the theme brightness
    Color textColor = Theme.of(context).brightness == Brightness.dark
        ? lightTextColor
        : darkTextColor;

    final List<Widget> _pages = [
      FeedPageScreen(),
      CreatePostPageScreen(),
      AccountsPage(),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: maroonColor,
        selectedItemColor: textColor, // Item color changes with theme
        unselectedItemColor: textColor.withOpacity(0.6), // Unselected item is less opaque
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Create Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }

}
