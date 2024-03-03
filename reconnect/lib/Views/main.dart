import 'package:flutter/material.dart';
import 'package:reconnect/Views/about.dart';
import 'package:reconnect/Views/change_password.dart';
import 'package:reconnect/Views/edit.dart';
import 'package:reconnect/Views/forgetpassword.dart';
import 'package:reconnect/Views/home.dart';
import 'package:reconnect/Views/login.dart';
import 'package:reconnect/Views/privacy.dart';
import 'package:reconnect/Views/profile.dart';
import 'package:reconnect/Views/resetpassword.dart';
import 'package:reconnect/Views/settings.dart';
import 'package:reconnect/Views/signup.dart';
import 'package:reconnect/Views/verfication.dart';
import 'package:reconnect/Views/welcom_page.dart';
import 'pay.dart';

void main() {
  runApp(
    const Reconnect(),
  );
}

class Reconnect extends StatelessWidget {
  const Reconnect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomPage(),
      routes: {
        "login": (context) => const login(),
        "signup": (context) => const signup(),
        "forgetBassword": (context) => const forgetBassword(),
        'resetPassword': (context) => const resetPassword(),
        "verfiyCode": (context) => const verfiyCode(),
        "home": (context) => const Home(),
        "profile": (context) => const Profile(),
        "settings": (context) => Settings(),
        "privacy": (context) => const Privacy(),
        'about': (context) => const About(),
        "pay": (context) => const Pay(),
        "EditProfile": (context) => const Edit(),
        "change password": (context) => const Change_Password(),
        'welcome': (context) => const WelcomPage(),
      },
    );
  }
}
