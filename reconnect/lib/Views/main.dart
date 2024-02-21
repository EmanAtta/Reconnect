import 'package:flutter/material.dart';
import 'package:reconnect/Views/about.dart';
import 'package:reconnect/Views/home.dart';
import 'package:reconnect/Views/privacy.dart';
import 'package:reconnect/Views/profile.dart';
import 'package:reconnect/Views/settings.dart';

// import 'package:reconnect/Views/login.dart';
// import 'package:reconnect/Views/signup.dart';
import 'package:reconnect/Views/welcom_page.dart';

void main() {
  runApp(const Reconnect());
}

class Reconnect extends StatelessWidget {
  const Reconnect({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomPage(),
      routes: {
        // "login": (context) => login(),
        // "signup":(context) => signup(),
        "home": (context) => const Home(),
        "profile": (context) => const Profile(),
        "settings": (context) => const Settings(),
        "privacy": (context) => const Privacy(),
        'about': (context) => const About(),
      },
    );
  }
}
