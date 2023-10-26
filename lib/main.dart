import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anonymous posting board',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFF2C2C2C),
        appBarTheme: AppBarTheme(
          color: Color(0xFF2C2C2C),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.blue),
        ),
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return PostListPage();
          }
          if (snapshot.hasError) {
            return Center(child: Text('Firebase reset error'));
          }
          return LoadingScreen();
        },
      ),
    );
  }
}
// Loading screen with random sentence pop up with image
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late Timer _timer;
  final List<String> quotes = [
    'Random Sentence 1',
    'Random Sentence 2',
    'Random Sentence 3',
  ];
  String currentQuote = '';

  @override
  void initState() {
    super.initState();
    _changeQuote();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      _changeQuote();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  _changeQuote() {
    setState(() {
      currentQuote = quotes[Random().nextInt(quotes.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset('assets/loading_image.jpg'),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                currentQuote,
                style: TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PostListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Poutine Time'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreatePostPage()),
              );
            },
          )
        ],
      ),
      body: Consumer<PostModel>(
        builder: (context, postModel, child) {
          return ListView.builder(
            itemCount: postModel.posts.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(postModel.posts[index].title),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetailPage(post: postModel.posts[index]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  File? _imageFile;

  Future<void> _showWarningDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Future Posting Warning Title'),
          content: Text('Our Future posing warning message'),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _showWarningDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write a Post'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Contents'),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('사진 업로드'),
              onPressed: () async {
                final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    _imageFile = File(pickedFile.path);
                  });
                }
              },
            ),
            ElevatedButton(
              child: Text('게시하기'),
              onPressed: () async {
                if (_imageFile != null) {
                  String? imageUrl = await Provider.of<PostModel>(context, listen: false).uploadImage(_imageFile!);
                  Provider.of<PostModel>(context, listen: false).addPost(
                    titleController.text,
                    contentController.text,
                    imageUrl,
                  );
                } else {
                  Provider.of<PostModel>(context, listen: false).addPost(
                    titleController.text,
                    contentController.text,
                  );
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PostDetailPage extends StatelessWidget {
  final Post post;

  PostDetailPage({required this.post});

  @override
  Widget build(BuildContext context) {
    String? currentUid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(post.content),
            if (currentUid == post.uid) // show edit delete button for post owner
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text('Edit'),
                    onPressed: () {
                      // edit logic
                    },
                  ),
                  TextButton(
                    child: Text('Delete'),
                    onPressed: () async {
                      await FirebaseFirestore.instance.collection('posts').doc(post.uid).delete();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

