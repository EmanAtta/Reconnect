import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/edit.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  String? firstname = '';
  String? email = '';
  String? image = '';
  File? imagmxfile;

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          firstname = snapshot.data()!["firstname"];
          email = snapshot.data()!["email"];
          //image = snapshot.data()!["image"];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
            Get.back();
          },
          icon: const Icon(Icons.keyboard_arrow_left,
              color: AppColors.primaryColor),
          ),
          backgroundColor: AppColors.secondaryColor,
      ),
      body: Column(
        children: [
           Padding(
             padding: const EdgeInsets.only(left: 300,top:30),
             child: IconButton(onPressed:() {
                            Get.to(() => Edit ());
                          } , icon: Icon(Icons.edit,color: AppColors.secondaryColor,size:40,)),
           ),
    
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height:30),
                GestureDetector(
                  onTap: () {
                    //for show imagee
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.secondaryColor,
                    minRadius:75,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: imagmxfile == null
                          ? NetworkImage(image!)
                          : Image.file(imagmxfile!).image,
                    ),
                  ),
                ),
                const SizedBox(
                  height:20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'First name : ' + firstname!,
                        style: const TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textolor),
                      ),
                      
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        'Last name : ',
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textolor),
                      ),
                    ],
                  ),
                ),
                    const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        'Email : ' + email!,
                        style: const TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textolor),
                      ),
                    ],
                  ),
                ),
                 const SizedBox(
                  height: 10.0,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        'Password : ',
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textolor),
                      ),
                    ],
                  ),
                ),   
              ],
            ),
          ),
        ],
      ),
    );
  }
}
