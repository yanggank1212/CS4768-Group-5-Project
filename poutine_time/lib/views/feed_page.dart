/// This page will display Feeds

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'components/post_widget.dart';

class FeedpageWidget extends StatelessWidget {
  const FeedpageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //Feed Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'FEED',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  height: 1.2125,
                  color: Color(0xff000000),
                ),
              ),
            ),
            //Username
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Username',
                style: TextStyle(
                  fontFamily: 'JetBrains Mono',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                  color: Color(0xff000000),
                ),
              ),
            ),
          ],
        ),
      ),
      body: PostWidget(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          // Home Button
          BottomNavigationBarItem(
            icon: Container(
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
            icon: Container(
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
            icon: Container(
              width: 32,
              height: 32,
              child: Image.asset(
                'assets/icons/account-button.png',
              ),
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
