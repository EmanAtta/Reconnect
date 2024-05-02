import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reconnect/Views/autentication.dart';
import 'package:reconnect/Views/forgetpassword.dart';
import 'package:reconnect/Views/login.dart';
import 'package:reconnect/Views/post.dart';
import 'package:reconnect/Views/resetpassword.dart';
import 'package:reconnect/Views/signup.dart';
import 'package:reconnect/Views/home_page.dart';
import 'package:reconnect/Views/welcom_page.dart';
import 'package:reconnect/delete1.dart';
import 'package:reconnect/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform )
      .then((value) {
        return Get.put(Authentication());
      });

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
      
      //home: WelcomPage(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page:()=>WelcomPage()),
        GetPage(name: '/login', page: () => const login()),
        GetPage(name: '/signup', page: () => const signup()),
        GetPage(name: '/myhomepage', page: () => const MyHomePage()),
        GetPage(name: '/post', page: () =>  Post()),
        GetPage(name: '/delete1', page: () => const Delete1()),

        GetPage(name: '/forgetpassword', page: () => const forgetBassword()),
        GetPage(name: '/resetpassword', page: () => const resetPassword()),
      ],
      
    );
  }
}
