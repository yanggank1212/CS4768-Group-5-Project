import 'package:flutter/material.dart';
import 'package:poutine_time/firebase_options.dart';
import 'package:poutine_time/views/Home/home_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:poutine_time/theme_provider.dart';
import 'package:provider/provider.dart';
import 'views/LogIn/SignIn/auth_gate.dart';
import 'views/LogIn/SignIn/signin_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap MaterialApp with ChangeNotifierProvider
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          // Listen to the theme changes
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeProvider.isDarkTheme
                ? ThemeData.dark()
                : ThemeData
                    .light(), // Apply the theme based on the current theme state
            home: AuthPage(),
          );
        },
      ),
    );
  }
}
