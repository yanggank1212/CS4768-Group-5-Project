//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:poutine_time/controller/user_controller.dart';
import 'package:poutine_time/model/user_model.dart';
import 'package:provider/provider.dart';

import '../../theme_provider.dart';

class AccountsPage extends StatelessWidget {
  final UserController userController;
  AccountsPage({super.key, required this.userController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            profileDetails(),
            ChangeEmailPassword(),
            UserGuide(),
            ThemeCustomization(context),
            LogOut(context),
          ],
        ),
      ),
    );
  }

  Widget profileDetails() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            //backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Username',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(width: 4),
              Icon(Icons.verified, color: Colors.blue) // Verified icon
            ],
          ),
        ],
      ),
    );
  }

  Widget ChangeEmailPassword() {
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
  }

  Widget UserGuide() {
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

  Widget LogOut(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.exit_to_app),
      title: const Text('Log Out'),
      onTap: () {
        // Handle log out
        Navigator.pop(context);
      },
    );
  }
}
