import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reconnect/Views/about.dart';
import 'package:reconnect/Views/authentications/autentication.dart';
import 'package:reconnect/Views/change_password.dart';
import 'package:reconnect/Views/donation.dart';
import 'package:reconnect/Views/edit.dart';
import 'package:reconnect/Views/forgetpassword.dart';
import 'package:reconnect/Views/home.dart';
import 'package:reconnect/Views/login.dart';
import 'package:reconnect/Views/pick_image.dart';
import 'package:reconnect/Views/post.dart';
import 'package:reconnect/Views/privacy.dart';
import 'package:reconnect/Views/profile.dart';
import 'package:reconnect/Views/resetpassword.dart';
import 'package:reconnect/Views/settings.dart';
import 'package:reconnect/Views/signup.dart';
import 'package:reconnect/Views/verfication.dart';
import 'package:reconnect/Views/welcom_page.dart';
import 'package:reconnect/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pay.dart';
import 'package:get/get_core/get_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(Authentication()));

  runApp(
    const Reconnect(),
  );
}

class Reconnect extends StatelessWidget {
  const Reconnect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const WelcomPage()),
        GetPage(name: '/login', page: () => const login()),
        GetPage(name: '/signup', page: () => const signup()),
        GetPage(name: '/forget', page: () => const forgetBassword()),
        GetPage(name: '/reset', page: () => const resetPassword()),
        //GetPage(name: '/verification', page: () => const Verification()),
        GetPage(name: '/home', page: () => const Home()),
        GetPage(name: '/post', page: ()=>Post()),
        GetPage(name: '/donation', page: () => const Donation()),

        GetPage(name: '/profile', page: () => const profile()),
        GetPage(name: '/settings', page: () => Settings()),
        GetPage(name: '/privacy', page: () => const Privacy()),
        GetPage(name: '/about', page: () => const About()),
        GetPage(name: '/pay', page: () => const Pay()),
        GetPage(name: '/edit', page: () => const Edit()),
        //GetPage(name: '/change_password', page: () => const Change_Password()),
      ],
    );
  }
}


