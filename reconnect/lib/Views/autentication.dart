
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reconnect/Views/authentications/routes/navigation.dart';
import 'package:reconnect/Views/authentications/signupcontrollers.dart';
import 'package:reconnect/Views/authentications/usermodle.dart';
import 'package:reconnect/Views/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reconnect/Views/welcom_page.dart';

class Authentication extends GetxController {
  static Authentication get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseuser;
  final _db = FirebaseFirestore.instance;
  final controller = Get.put(SignUpController());
final GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  void onReady() {
    firebaseuser = Rx<User?>(_auth.currentUser);
    firebaseuser.bindStream(_auth.userChanges());
    ever(firebaseuser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const WelcomPage())
        : Get.offAll(() => Navigationpage());
  }

//SIGNIN
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseuser.value != null
          ? Get.offAll(() => Navigationpage())
          : Get.offAll(() => const WelcomPage());

      final user = UserModel(
        firstname: controller.firstname.text.trim(),
        lastname: controller.lastname.text.trim(),
        email: controller.email.text.trim(),
        password: controller.password.text.trim(),
      );

      SignUpController.instance.creatuser(user);
      Get.offAll(() => Navigationpage());
    } on FirebaseAuthException catch (e) {
      final errorMessage = _getFirebaseErrorMessage(e);
      print("error: $errorMessage");
      // Display error in snackbar
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
      throw Exception(errorMessage);
    } catch (_) {
      const errorMessage = "An error occurred";
      print("error: $errorMessage");
      // Display error in snackbar
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
    }
  }

//LOGIN AND UPDATE FIREBASE



  Future<void> logInWithEmailandPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = _auth.currentUser;
      if (user != null) {
        await _updateFirestoreEmailAndPassword(email, password);
        Get.offAll(() => Navigationpage());
       
      } else {
        Get.snackbar('Error', 'Please verify your email.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } on FirebaseAuthException catch (e) {
      final errorMessage = _getFirebaseErrorMessage(e);
      print('firebase exception - $errorMessage');

      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
    } catch (_) {
      const errorMessage = "An error occurred";
      print("error: $errorMessage");

      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
      throw Exception(errorMessage);
    }
  }
//google//////

  
//UPDATE FIREBASE
  Future<void> _updateFirestoreEmailAndPassword(
      String email, String password) async {
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        final userDoc = userSnapshot.docs.first;
        await userDoc.reference.update({
          'password': password,
        });
      }
    } catch (e) {
      print('Error updating Firestore: $e');
      throw Exception('Error updating Firestore: $e');
    }
  }

//REST PASSWORD

  Future<void> resetPasswordAndUpdateFirestore(String email) async {
    bool emailExists = await checkIfEmailExists(email);

    if (emailExists) {
      try {
        await _auth.sendPasswordResetEmail(email: email);

        Get.snackbar("Success", "Password reset email sent",
            snackPosition: SnackPosition.BOTTOM);

        Get.offAll(() => const login(), duration: const Duration(seconds: 3));
      } on FirebaseAuthException catch (e) {
        final errorMessage = _getFirebaseErrorMessage(e);
        print('Firebase exception - $errorMessage');
        // Display error in snackbar
        Get.snackbar('Error', errorMessage,
            snackPosition: SnackPosition.BOTTOM);
      } catch (_) {
        const errorMessage = "An error occurred";
        print("Error: $errorMessage");
        Get.snackbar('Error', errorMessage,
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar("Error", "Email not registered",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  //CHECK IF EMAIL EXISTS
  Future<bool> checkIfEmailExists(String email) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      print('Error checking email existence: $error');
      return false;
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
