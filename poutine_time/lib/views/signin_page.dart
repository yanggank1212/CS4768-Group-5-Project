import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poutine_time/model/Templates/model_templates.dart';
import 'package:poutine_time/views/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poutine_time/model/user_model.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _signUp();
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String username = _usernameController.text.trim();

    // if (!email.endsWith('@mun.ca')) {
    //   // Show a SnackBar if the email doesn't end with '@mun.ca'
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Email must end with @mun.ca'),
    //     ),
    //   );
    //   return;
    // }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //await userCredential.user!.sendEmailVerification();

      // // Show a SnackBar for successful sign-up
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Verification email sent. Please check your email.'),
      //   ),
      // );

      // // Check if email is verified
      // if (userCredential.user!.emailVerified) {
      //   // Optionally, you can sign out the user after account creation.
      //   // _auth.signOut();
      // } else {
      //   // If email is not verified, delete the created user account.
      //   await userCredential.user!.delete();
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text('Email not verified. Account deleted.'),
      //     ),
      //   );
      // }

      String userID = userCredential.user!.uid;
      UserModel userModel = UserModelTemplate().userModelTemplate();

      //Create User Database
      //Function to create UserDatabase
      /*
        Parameters: USERID userID
                    String username
      */

      await _firestore
          .collection('Data')
          .doc("userList")
          .set({userID: userModel.toMap()});

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePageScreen(userID: userID),
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'An error occurred';
      });
    }
  }
}
