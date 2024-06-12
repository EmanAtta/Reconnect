
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reconnect/Views/autentication.dart';


class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  void regester(String email, String password) {
    String? error = Authentication.instance
        .logInWithEmailAndPassword(email, password) as String?;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString()));
    }
  }
}
