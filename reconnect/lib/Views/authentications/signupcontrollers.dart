// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:reconnect/Views/autentication.dart';
// //
// // import 'package:reconnect/Views/authentications/user_repo.dart';
// // import 'package:reconnect/Views/authentications/usermodle.dart';
// //
// // class SignUpController extends GetxController {
// //   static SignUpController get instance => Get.find();
// //
// //   final email = TextEditingController();
// //   final password = TextEditingController();
// //   final confirmpasswordr = TextEditingController();
// //   final firstname = TextEditingController(); // Corrected variable name
// //   final lastname = TextEditingController();
// //   final userRepo=Get.put(User_report());
// //   void regester(String email, String password) {
// //     String? error = Authentication.instance.createUserWithEmailAndPassword(email, password) as String?;
// //     if (error != null) {
// //       Get.showSnackbar(GetSnackBar(message: error.toString()));
// //     }
// //   }
// //   void creatuser(UserModel user)async{
// //     await userRepo.creatuser(user);
// //
// //
// //     }
// //   }
// //
//
//
//
//
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reconnect/Views/autentication.dart';
import 'package:reconnect/Views/authentications/user_repo.dart';
import 'package:reconnect/Views/authentications/usermodle.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController(); // Corrected variable name
  final firstName = TextEditingController(); // Corrected variable name
  final lastName = TextEditingController();
  final userRepo = Get.put(User_report());

  void register(String email, String password) async {
    try {
      await Authentication.instance.createUserWithEmailAndPassword(email, password);
      Get.snackbar("Success", "User registered successfully", snackPosition: SnackPosition.BOTTOM);
    } catch (error) {
      Get.snackbar("Error", error.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void createUser(UserModel user) async {
    try {
      await userRepo.createUser(user);
      Get.snackbar("Success", "User created successfully", snackPosition: SnackPosition.BOTTOM);
    } catch (error) {
      Get.snackbar("Error", error.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:reconnect/Views/autentication.dart';
// import 'package:reconnect/Views/authentications/user_repo.dart';
// import 'package:reconnect/Views/authentications/usermodle.dart';
//
// class SignUpController extends GetxController {
//   static SignUpController get instance => Get.find();
//
//   final email = TextEditingController();
//   final password = TextEditingController();
//   final confirmPassword = TextEditingController(); // Corrected variable name
//   final firstName = TextEditingController(); // Corrected variable name
//   final lastName = TextEditingController();
//   final userRepo = Get.put(User_report());
//
//   void register(String email, String password) async {
//     try {
//       await Authentication.instance.createUserWithEmailAndPassword(email, password);
//       Get.snackbar("Success", "User registered successfully", snackPosition: SnackPosition.BOTTOM);
//     } catch (error) {
//       Get.snackbar("Error", error.toString(), snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//   void createUser(UserModel user) async {
//     try {
//       await userRepo.createUser(user);
//       Get.snackbar("Success", "User created successfully", snackPosition: SnackPosition.BOTTOM);
//     } catch (error) {
//       Get.snackbar("Error", error.toString(), snackPosition: SnackPosition.BOTTOM);
//     }
//   }
// }
