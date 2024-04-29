import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reconnect/Views/authentications/usermodle.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Import the home screen

class User_report extends GetxController {
  static User_report get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

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

  Future<UserModel> getuserdata(String email) async {
    final snapshot =
        await _db.collection('users').where('email', isEqualTo: email).get();
    final userdata = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userdata;
  }

  Future<void> updateRecord(UserModel user) async {
    // Get the current user's email
    final email = FirebaseAuth.instance.currentUser!.email;

    // Query Firestore to find the user document with the provided email
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    // Check if any documents match the query
    if (querySnapshot.docs.isNotEmpty) {
      // Get the user document
      QueryDocumentSnapshot<Object?> userDoc = querySnapshot.docs.first;

      // Get the user ID
      String userId = userDoc.id;

      try {
        // Update the user document in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update(user.toJson());

        // Navigate to the desired screen after successful update
        // You need to implement the navigation logic here
      } catch (e) {
        print('Error updating user data: $e');
        // Handle error appropriately
      }
    } else {
      print('No user found with email: $email');
      // Handle the case where no user is found with the provided email
    }
  }


  Future<void> updateImageUrl(String newImageUrl) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final email = user.email;

    // Query Firestore to find the user document with the provided email
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    // Check if any documents match the query
    if (querySnapshot.docs.isNotEmpty) {
      try {
        QueryDocumentSnapshot<Object?> userDoc = querySnapshot.docs.first;

        // Get the user ID
        String userId = userDoc.id;

        // Update the 'imageUrl' field in the Firestore document
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({'imageUrl': newImageUrl});

        // Update the state with the new imageUrl
        
      } catch (e) {
        print('Error updating image URL: $e');
      }
    } else {
      // No user found with the provided email
      print('Error: No user found with email: $email');
    }
  } else {
    // User is not logged in
    print('Error: User is not logged in');
  }
}

  }













  

  

