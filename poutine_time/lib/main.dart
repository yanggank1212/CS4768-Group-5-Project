import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoginScreen());
  }
}


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "Poutine Time",
              style:TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
          ),
          Text("Login to your account", style: TextStyle(color: Colors.black,
          fontSize: 44.0,
          fontWeight: FontWeight.bold
          ),
          ),
          SizedBox(//SizdedBox to make space between the contents
            height: 44.0,
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
            hintText: "Uesr Email",
            prefixIcon: Icon(Icons.mail, color:Colors.brown),
            ),
          ),
          SizedBox(
            height: 26.0,
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
             hintText: "User Password",
             prefixIcon: Icon(Icons.lock, color:Colors.brown),
          ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
              "Sign in",
               style: TextStyle(color: Colors.blue),
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            "Forget Id/Pass?",
                style: TextStyle(color: Colors.blue),
          ), 
          SizedBox(
            height: 25,
          ),
          Container(
            width: double.infinity,
            child: RawMaterialButton(
              fillColor: Color(0xFF0069FE),
              elevation: 0.0,
              padding: EdgeInsets.symmetric(vertical: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),

              onPressed: () {},
              child: Text("Login", style: TextStyle(color: Colors.white60, fontSize: 20),),
            ),
          )
      ]),
    );
  }
}
