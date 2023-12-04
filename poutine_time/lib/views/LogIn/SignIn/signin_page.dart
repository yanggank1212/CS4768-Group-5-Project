import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poutine_time/model/Templates/model_templates.dart';
import 'package:poutine_time/views/Home/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poutine_time/model/user_model.dart';
import 'package:poutine_time/views/loading_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
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
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _signInWithGoogle,
              child: Text('Sign in with Google'),
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

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //Awaiting Domain Verification
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

      //Create UserModel
      User? user = userCredential.user;
      String userID = user!.uid;
      UserModel userModel = UserModel(username: username);
      user.updateDisplayName(username);

      //Store User information on Data/UserList
      await _firestore
          .collection('Data')
          .doc("userList")
          .update({userID: userModel.toMap()});

      //Navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoadingScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'An error occurred';
      });
    }
  }

  Future<void> _signInWithGoogle() async {
    final String username = _usernameController.text.trim();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth == null) {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user == null) {
        throw FirebaseAuthException(
          code: 'ERROR_FAILED_TO_SIGN_IN_WITH_GOOGLE',
          message: 'Failed to sign in with Google',
        );
      }

      //Create UserModel
      String userID = user.uid;
      UserModel userModel = UserModel(username: username);
      user.updateDisplayName(username);

      //Store User information on Data/UserList
      await _firestore
          .collection('Data')
          .doc("userList")
          .update({userID: userModel.toMap()});

      //Navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoadingScreen(),
        ),
      );
    } catch (e) {}
  }

  /* Future<void> _signInWithGoogle() async {
    /*final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();*/
    final String username = _usernameController.text.trim();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth == null) {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user == null) {
        throw FirebaseAuthException(
          code: 'ERROR_FAILED_TO_SIGN_IN_WITH_GOOGLE',
          message: 'Failed to sign in with Google',
        );
      }

      //User? user = userCredential.user;
      String userID = user!.uid;
      UserModel userModel = UserModel(username: username);

      //Store User information on Data/UserList
      await _firestore
          .collection('Data')
          .doc("userList")
          .update({userID: userModel.toMap()});

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              LoadingScreen(), // Navigate to home page after sign in
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'An error occurred during Google Sign-In';
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }
  */
}
