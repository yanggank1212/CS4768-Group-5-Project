import 'package:flutter/material.dart';
import 'package:poutine_time/model/Templates/post_model_template.dart';
import 'package:poutine_time/model/post_model.dart';
import 'components/post_widget.dart';

class FeedPageScreen extends StatefulWidget {
  const FeedPageScreen({Key? key}) : super(key: key);

  @override
  State<FeedPageScreen> createState() => _FeedpageScreen();
}

class _FeedpageScreen extends State<FeedPageScreen> {
  late List<PostModel> posts = []; //List to store PostModel instances

  @override
  void initState() {
    super.initState();
    //Populate the initial list with 10 default PostModel instances
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

  PreferredSizeWidget feedAppBar() {
    return AppBar(
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
      appBar: feedAppBar(),
      body: bodyWidget(),
    );
  }
}
