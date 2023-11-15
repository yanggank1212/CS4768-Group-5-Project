/// This will display a Post
/// Will look different depending if user is creator of post or just a viewer

import 'package:flutter/material.dart';
import 'package:poutine_time/model/post_model.dart';

class PostPageScreen extends StatefulWidget {
  final PostModel postModel;

  const PostPageScreen({Key? key, required this.postModel}) : super(key: key);

  @override
  _PostPageScreenState createState() => _PostPageScreenState();
}

class _PostPageScreenState extends State<PostPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: Container(), // Completely blank container
    );
  }
}
