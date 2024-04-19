import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:reconnect/Views/autentication.dart';

import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/login.dart';
import 'package:reconnect/Views/resetpassword.dart';
import 'package:reconnect/Views/widgets/Button.dart';

class forgetBassword extends StatefulWidget {
  const forgetBassword({super.key});

  @override
  State<forgetBassword> createState() => _forgetBasswordState();
}

class _forgetBasswordState extends State<forgetBassword> {
  final _emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: //PreferredSize(
        //preferredSize: Size.fromHeight(33),
        AppBar(
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(200),
                    bottomRight: Radius.circular(200))),
             backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Color.fromARGB(221, 44, 39, 39),
          onPressed: () {
            Get.back(
                  closeOverlays: true,
                  result: true,
                  
            );
          },
              icon: const Icon(
                Icons.keyboard_arrow_left,
                color: AppColors.textolor,
                size: 30,
              ),
            )),
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: SvgPicture.asset(
              "assets/password.svg",
              color: AppColors.secondaryColor,
              height: 120,
              width: 100,
            ),
          ),
          const Center(
              child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              "Forgot password ?",
              style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          )),
          const Center(
            child: Text(
              "enter email  address",
              style: TextStyle(color: AppColors.textolor, fontSize: 18),
            ),
          ),
          const Center(
            child: Text("associate with your account",
                style: TextStyle(color: AppColors.textolor, fontSize: 18)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 15, 25, 10),
            child: TextFormField(
              controller: _emailcontroller,
              cursorColor: AppColors.primaryColor,
              decoration: InputDecoration(
                hintText: 'enter email',
                hintStyle: TextStyle(color: AppColors.labelStyle, fontSize: 12),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textolor),
                  borderRadius: BorderRadius.circular(25),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.secondaryColor),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: InkWell(
                onTap: () {
                  Authentication.instance.resetPasswordAndUpdateFirestore(_emailcontroller.text.trim());
                 // Get.to(()=>resetPassword());
                },
                child: button(
                  button_text: "send email",
                )),
          )
        ],
      ),
    );
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
      return 'check email and try again.';
  }
}
