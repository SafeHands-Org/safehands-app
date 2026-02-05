import 'package:flutter/material.dart';
import 'package:frontend/features/auth/pages/signup_page.dart';
import 'package:frontend/features/auth/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeHands',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginScreen(),
      //home: const SignUpPage(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const SignUpPage(),
      },

    );
  }
}