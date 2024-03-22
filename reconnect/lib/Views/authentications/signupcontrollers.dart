import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reconnect/Views/authentications/autentication.dart';
import 'package:reconnect/Views/authentications/user_repo.dart';
import 'package:reconnect/Views/authentications/usermodle.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final confirmpasswordr = TextEditingController();
  final firstname = TextEditingController(); // Corrected variable name
  final lastname = TextEditingController();
  final userRepo=Get.put(User_report());
  void regester(String email, String password) {
    String? error = Authentication.instance.createUserWithEmailAndPassword(email, password) as String?;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString()));
    }
  }
  void creatuser(UserModel user)async{
    await userRepo.creatuser(user);
    

    }
  }

