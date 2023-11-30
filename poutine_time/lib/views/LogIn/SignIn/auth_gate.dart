///This will be the screen for the Authentication Gate
///
///

import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:poutine_time/controller/user_controller.dart';
import 'package:poutine_time/model/user_model.dart';
import 'package:poutine_time/views/Home/home_page.dart';
import 'package:poutine_time/views/LogIn/SignIn/login_page.dart';
import 'package:poutine_time/views/loading_page.dart';
import 'package:poutine_time/views/LogIn/SignIn/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPage createState() => _AuthPage();
}

class _AuthPage extends State<AuthPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  Widget prevWidget(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              //Log In Button
              onPressed: () {
                // Navigate to the Log In screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Log In'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              //Sign Up Button
              onPressed: () {
                // Navigate to the Sign Up screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text('Sign Up'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              //Debugger: Log In as JohnDoe@gmail.com
              onPressed: () async {
                try {
                  UserCredential userCredential =
                      await auth.signInWithEmailAndPassword(
                    email: 'johndoe@gmail.com',
                    password: 'poopoo',
                  );

                  User? user = userCredential.user;
                  // print('User logged in: ${user?.uid}');

                  // Navigate to the Sign Up screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoadingScreen()),
                  );
                } catch (e) {
                  print('Error during login: $e');
                }
              },
              child: Text('Sign Up as John Doe'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
              GoogleProvider(
                  clientId:
                      '1005533365455-0qhc3jkaum9kh4d6f8g174so5oudctef.apps.googleusercontent.com')
            ],
            headerBuilder: null,
          );
        }

        return LoadingScreen();
      },
    );
  }
}
