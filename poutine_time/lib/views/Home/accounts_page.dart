//import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poutine_time/controller/state_manager.dart';
import 'package:poutine_time/controller/user_controller.dart';
import 'package:poutine_time/model/user_model.dart';
import 'package:poutine_time/views/LogIn/SignIn/auth_gate.dart';
import 'package:provider/provider.dart';

import '../../theme_provider.dart';

class AccountsPage extends StatelessWidget {
  AccountsPage({super.key});


  Color maroonColor = const Color(0xFF8C1D40);
  Color darkTextColor = const Color(0xFF212121);

  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      print('User signed out');

      // After the sign out, remove all routes and navigate to the sign-in page
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => AuthPage()),
            (Route<dynamic> route) => false,
      );
    } catch (e) {

      print('Error signing out: ${e.toString()}');
    }
  }

  // Future<void> changePassword() async {
  //   try {
  //     User? user = FirebaseAuth.instance.currentUser;

  //     // First, re-authenticate the user with their current password
  //     AuthCredential credential = EmailAuthProvider.credential(
  //       email: user!.email!,
  //       password: _currentPasswordController.text,
  //     );
  //     await user.reauthenticateWithCredential(credential);

  //     // Second, update the user's password to the new password
  //     await user.updatePassword(_newPasswordController.text);

  //     print('Password changed successfully');
  //   } catch (e) {
  //     print('Error changing password: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account', style: TextStyle(color: Colors.white)),
        backgroundColor: maroonColor, // Use the maroon color for AppBar
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            profileDetails(context),
            UserGuide(context),
            ThemeCustomization(context),
            SignOut(context),
          ],
        ),
      ),
    );
  }

  Widget profileDetails(BuildContext context) {
    var username = StateManager.userController.userModel.username;

    // Deciding text color based on theme
    Color textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : darkTextColor;

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                username,
                style: GoogleFonts.roboto(
                  color: textColor, // Using text color that contrasts with the background
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.verified, color: Colors.blue), // Verified icon
            ],
          ),
        ],
      ),
    );
  }


  /*Widget ChangeEmailPassword(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.lock),
          title: const Text('Change Password'),
          onTap: () {
            //  change password code
          },
        ),
      ],
    );
  }*/

  Widget UserGuide(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.help_outline),
      title: const Text('User Guide'),
      onTap: () {
        // Guide text
      },
    );
  }

  Widget ThemeCustomization(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return SwitchListTile(
          title: const Text('Dark Theme'),
          value: themeProvider.isDarkTheme,
          onChanged: (bool value) {
            themeProvider.isDarkTheme = value;
          },
        );
      },
    );
  }

  Widget SignOut(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.exit_to_app),
      title: const Text('Sign Out'),
      onTap: () async {
        await signOut(context);
      },
    );
  }
}
