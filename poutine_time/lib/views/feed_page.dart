/// This page will display Feeds
/// Right now it just displays 10 default posts in a ScrollView

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'components/post_widget.dart';

class FeedpageScreen extends StatefulWidget {
  const FeedpageScreen({super.key});

  @override
  State<FeedpageScreen> createState() => _FeedpageScreen();
}

class _FeedpageScreen extends State<FeedpageScreen> {
  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey<String>('bottom-silver-list');

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
                  //color: Color(0xff000000),
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
                  //color: Color(0xff000000),
                ),
              ),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        center: centerKey,
        slivers: <Widget>[
          SliverList(
            key: centerKey,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: PostWidget(),
                );
              },
              childCount: 10,
            ),
          ),
        ],
      ),
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
