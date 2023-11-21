import 'package:flutter/material.dart';
import 'package:poutine_time/controller/user_controller.dart';
import 'package:poutine_time/model/Templates/model_templates.dart';
import 'package:poutine_time/model/post_model.dart';
import 'package:poutine_time/model/user_model.dart';
import '../components/post_widget.dart';

class FeedPageScreen extends StatefulWidget {
  final UserController userController;
  FeedPageScreen({Key? key, required this.userController}) : super(key: key);

  @override
  State<FeedPageScreen> createState() => _FeedpageScreen();
}

class _FeedpageScreen extends State<FeedPageScreen> {
  late List<PostModel> posts = []; //List to store PostModel instances
  //UserController userController = UserController();

  @override
  void initState() {
    super.initState();
    posts =
        List.generate(10, (index) => PostModelTemplate().postModelTemplate())
            .toList();
  }

  Future<void> _refresh() async {
    // Simulate loading new data
    await Future.delayed(const Duration(seconds: 2));

    // Add 5 more PostModel instances on top of the existing list
    setState(() {
      posts.addAll(
          List.generate(5, (index) => PostModelTemplate().postModelTemplate()));
    });
    //print("Refresh");
  }

  PreferredSizeWidget feedAppBar(String username) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //Feed Title
          const Padding(
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
              username,
              style: const TextStyle(
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
    );
  }

  Widget bodyWidget() {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: PostWidget(postModel: posts[index]),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: feedAppBar(widget.userController.getUsername() ?? "default"),
      body: bodyWidget(),
    );
  }
}
