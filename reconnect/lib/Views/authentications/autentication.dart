import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:reconnect/Views/authentications/signupcontrollers.dart';
import 'package:reconnect/Views/authentications/user_repo.dart';
import 'package:reconnect/Views/authentications/usermodle.dart';
import 'package:reconnect/Views/home.dart';
import 'package:reconnect/Views/login.dart';
import 'package:reconnect/Views/pick_image.dart';
import 'package:reconnect/Views/welcom_page.dart';


class Authentication extends GetxController {
  static Authentication get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseuser;
  final controller = Get.put(SignUpController()); 

  @override
  void onReady() {
    firebaseuser = Rx<User?>(_auth.currentUser);
    firebaseuser.bindStream(_auth.userChanges());
    ever(firebaseuser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const WelcomPage())
        : Get.offAll(() => const login());
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseuser.value != null
          ? Get.offAll(() => const Home())
          : Get.offAll(() => const WelcomPage());

      
      final user = UserModel(
                        firstname: controller.firstname.text.trim(),
                        lastname: controller.lastname.text.trim(),
                        email: controller.email.text.trim(),
                        password: controller.password.text.trim(),
                      );
                      
                        
                      
                      SignUpController.instance.creatuser(user);
                      

    } on FirebaseAuthException catch (e) {
      final errorMessage = _getFirebaseErrorMessage(e);
      print("error: $errorMessage");
      // Display error in snackbar
      Get.snackbar('Error', errorMessage,
          snackPosition: SnackPosition.BOTTOM);
      throw Exception(errorMessage);
    } catch (_) {
      const errorMessage = "An error occurred";
      print("error: $errorMessage");
      // Display error in snackbar
      Get.snackbar('Error', errorMessage,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> logInWithEmailandPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseuser.value != null
          ? Get.offAll(() => const ImagePage())
          : Get.offAll(() => const WelcomPage());
    } on FirebaseAuthException catch (e) {
      final errorMessage = _getFirebaseErrorMessage(e);
      print('firebase exception - $errorMessage');
      // Display error in snackbar
      Get.snackbar('Error', errorMessage,
          snackPosition: SnackPosition.BOTTOM);
    } catch (_) {
      const errorMessage = "An error occurred";
      print("error: $errorMessage");
      // Display error in snackbar
      Get.snackbar('Error', errorMessage,
          snackPosition: SnackPosition.BOTTOM);
      throw Exception(errorMessage);
    }
  }

  String _getFirebaseErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'user-disabled':
        return 'The user account has been disabled by an administrator.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Wrong password provided for this user.';
      default:
        return 'An error occurred while processing your request.';
    }
  }

  Future<void> logout() async => await _auth.signOut();
}
