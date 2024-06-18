

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:reconnect/Views/authentications/profile_controller.dart';
import 'package:reconnect/Views/authentications/routes/navigation.dart';
import 'package:reconnect/Views/authentications/usermodle.dart';

import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/edit.dart';

import 'package:reconnect/Views/widgets/Button.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  final user = FirebaseAuth.instance.currentUser;
  String? imageUrl;
  @override
  void initState() {
    super.initState();
    
    getImageUrl();
  }

  Future<void> getImageUrl() async {
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

          DocumentSnapshot<Map<String, dynamic>> imageUrlSnapshot =
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .get();

          // Check if the document exists
          if (imageUrlSnapshot.exists) {
            // Get the data from the document
            Map<String, dynamic>? data = imageUrlSnapshot.data();

            if (data != null) {
              // Check if the 'imageUrl' field is present
              if (data.containsKey('imageUrl')) {
                // Retrieve the imageUrl from the document data
                setState(() {
                  imageUrl = data['imageUrl'] as String?;
                });
              } else {
                // 'imageUrl' field not found
                setState(() {
                  imageUrl = null; // Reset imageUrl to null
                });
                print('Error: Image URL not found in Firestore');
              }
            } else {
              // Document data is null
              setState(() {
                imageUrl = null; // Reset imageUrl to null
              });
              print('Error: Document data is null in Firestore');
            }
          } else {
            // Document doesn't exist
            setState(() {
              imageUrl = null; // Reset imageUrl to null
            });
            print('Error: Document not found in Firestore');
          }
        } catch (e) {
          print('Error fetching image URL: $e');
        }
      } else {
        // No documents found
        print('Error: No documents found for the user in Firestore');
      }
    } else {
      // User is not logged in
      print('Error: User is not logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Profilecontroller());
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.primaryColor),
        ),
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => const Navigationpage());
          },
          icon: const Icon(Icons.keyboard_arrow_left,
              color: AppColors.primaryColor),
        ),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: FutureBuilder(
        future: controller.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              UserModel userData = snapshot.data as UserModel;
              return SingleChildScrollView(
                child:Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 300, top: 20),
                    ),
                    Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 70,
                            backgroundImage: imageUrl != null
                                ? NetworkImage(imageUrl!)
                                : null,
                            child: imageUrl == null
                                ? Image.asset("assets/profile.jpg")
                                : null,
                          )
                        ])),
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: userData.firstname,
                        cursorColor: AppColors.textolor,
                        decoration: InputDecoration(
                          labelText: "firstName",
                          labelStyle: const TextStyle(
                              fontSize: 15, color: AppColors.labelStyle),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.secondaryColor),
                              borderRadius: BorderRadius.circular(30)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.textolor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          readOnly: true,
                          initialValue: userData.lastname,
                          cursorColor: AppColors.textolor,
                          decoration: InputDecoration(
                            labelText: "lastName",
                            labelStyle: const TextStyle(
                                fontSize: 15, color: AppColors.labelStyle),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.secondaryColor),
                                borderRadius: BorderRadius.circular(30)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.textolor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        )),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: userData.email,
                        cursorColor: AppColors.textolor,
                        decoration: InputDecoration(
                          labelText: "email",
                          labelStyle: const TextStyle(
                              fontSize: 15, color: AppColors.labelStyle),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.secondaryColor),
                              borderRadius: BorderRadius.circular(30)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.textolor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    InkWell(
                        onTap: () {
                          Get.to(() => Edit());
                        },
                        child: button(button_text: "Edit profile"))
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return const Center(child: Text("Something went wrong"));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
