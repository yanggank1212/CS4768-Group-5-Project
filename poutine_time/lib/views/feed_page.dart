/// This page will display Feeds

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'components/post_widget.dart';

class FeedpageWidget extends StatelessWidget {
  const FeedpageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Will need to change these
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              //Feed Title
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
            Padding(
              //Username
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
