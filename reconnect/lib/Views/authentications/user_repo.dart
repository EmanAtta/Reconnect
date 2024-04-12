import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reconnect/Views/authentications/usermodle.dart';
// Import the home screen

class User_report extends GetxController {
  static User_report get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  // Function to create user
  Future<void> creatuser(UserModel user) async {
    print("hi");
    await _db.collection("users").add(user.toJson()).then((_) {
      // Show success snackbar
      Get.snackbar(
        "Success",
        "Your account has been created",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 1),
      );
    }).catchError((error) {
      // Show error snackbar
      Get.snackbar("Error", "Something went wrong",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      print(error.toString());
    });
  }

  Future<void> updatauserrecord(UserModel user) async {
    await _db.collection('users').doc(user.id).update(user.toJson());
  }
}
