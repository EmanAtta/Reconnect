import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/login.dart';

class Change_Password extends StatefulWidget {
  const Change_Password({super.key});

  @override
  State<Change_Password> createState() => _Change_PasswordState();
}

class _Change_PasswordState extends State<Change_Password> {
  late TextEditingController oldpassword;
  late TextEditingController newpassword;
  late TextEditingController confirmpassword;
  late FirebaseAuth auth;
  late User? currentuser;

  @override
  void initState() {
    super.initState();
    oldpassword = TextEditingController();
    newpassword = TextEditingController();
    confirmpassword = TextEditingController();
    auth = FirebaseAuth.instance;
    currentuser = auth.currentUser;
  }

  Future<void> changepassword({
    required String email,
    required String oldpassword,
    required String newpassword,
  }) async {
    var cred =
        EmailAuthProvider.credential(email: email, password: oldpassword);
    try {
      await currentuser!.reauthenticateWithCredential(cred);
      print('Reauthentication successful');
      if (newpassword == oldpassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('New password must be different from old password'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        await currentuser!.updatePassword(newpassword);

         Get.snackbar('success', 'Password updated successfully',
            snackPosition: SnackPosition.BOTTOM);
      }
       await Future.delayed(const Duration(seconds: 2));
        Get.off(() => const login());
    } catch (error) {
      print('Error during password change: $error');
      if (error is FirebaseAuthException) {
        if (error.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Wrong password. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('An error occurred: ${error.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: const Text(
          'Change Password',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.primaryColor),
        ),
       
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left,
              color: AppColors.primaryColor),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Change password',
              style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 15, 25, 5),
            child: TextFormField(
              controller: oldpassword,
              cursorColor: AppColors.secondaryColor,
              decoration: InputDecoration(
                  hintText: 'old password',
                  hintStyle: const TextStyle(color: Color(0xFFA7A4A4), fontSize: 12),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.secondaryColor),
                      borderRadius: BorderRadius.circular(25))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 15, 25, 5),
            child: TextFormField(
              controller: newpassword,
              cursorColor: AppColors.secondaryColor,
              decoration: InputDecoration(
                  hintText: 'new password',
                  hintStyle: const TextStyle(color: Color(0xFFA7A4A4), fontSize: 12),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.secondaryColor),
                      borderRadius: BorderRadius.circular(25))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 15, 25, 5),
            child: TextFormField(
              controller: confirmpassword,
              cursorColor: AppColors.secondaryColor,
              decoration: InputDecoration(
                  hintText: 'confirm password',
                  hintStyle: const TextStyle(color: Color(0xFFA7A4A4), fontSize: 12),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.secondaryColor),
                      borderRadius: BorderRadius.circular(25))),
            ),
          ),
          IconButton(
            onPressed: () {
              if (newpassword.text == confirmpassword.text) {
                changepassword(
                  email: currentuser!.email!,
                  oldpassword: oldpassword.text,
                  newpassword: newpassword.text,
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Passwords do not match'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            icon: const Icon(Icons.check),
          )
        ],
      ),
    );
  }
}
