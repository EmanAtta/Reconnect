import 'package:flutter/material.dart';
import 'package:reconnect/Views/login.dart';
import 'package:reconnect/Views/signup.dart';
import 'package:reconnect/Views/welcom_page.dart';

void main() {
  runApp(const Reconnect());
}

class Reconnect extends StatelessWidget {
  const Reconnect({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomPage(),
      routes: {
       // "login": (context) => login(),
       // "signup":(context) => signup(),
      },
    );
  }
}
