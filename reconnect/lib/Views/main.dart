import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reconnect/Views/about.dart';
import 'package:reconnect/Views/authentications/autentication.dart';
import 'package:reconnect/Views/change_password.dart';
import 'package:reconnect/Views/donation.dart';
import 'package:reconnect/Views/edit.dart';
import 'package:reconnect/Views/forgetpassword.dart';

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

void main()async {
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
       
        GetPage(name: '/forgetpassword', page: () => const forgetBassword()),
        GetPage(name: '/resetpassword', page: () => const resetPassword()),
        GetPage(name: '/image', page:()=>ImagePage())
      ],
     
     
    );
  }
}


