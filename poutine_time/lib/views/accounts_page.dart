import 'package:flutter/material.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            profileDetails(),
            ChangeEmailPassword(),
            UserGuide(),
            ThemeCustomization(),
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
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Username', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(width: 4),
              Icon(Icons.verified, color: Colors.blue) // Verified icon
            ],
          ),

        ],
      ),
    );
  }
  Widget ChangeEmailPassword(){
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

  Widget UserGuide(){
    return ListTile(
      leading: Icon(Icons.help_outline),
      title: Text('User Guide'),
      onTap: () {
        // Guide text
      },
    );


  }

  Widget ThemeCustomization(){
    bool isDarkTheme = false; // Need to replace this

    return SwitchListTile(
      title: Text('Dark Theme'),
      value: isDarkTheme,
      onChanged: (bool value) {
        // theme change
      },
    );

  }

  Widget LogOut(BuildContext context){

    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Log Out'),
      onTap: () {
        // Handle log out
        Navigator.pop(context);
      },
    );


  }



}