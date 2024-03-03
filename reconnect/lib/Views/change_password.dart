import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/settings.dart';
import 'package:reconnect/Views/widgets/Button.dart';

class Change_Password extends StatefulWidget {
  const Change_Password({super.key});

  @override
  State<Change_Password> createState() => _Change_PasswordState();
}

class _Change_PasswordState extends State<Change_Password> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: Text(
          'Change Password',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.primaryColor),
        ),
        elevation: 40,
        shadowColor: Colors.black,
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
              cursorColor: AppColors.secondaryColor,
              decoration: InputDecoration(
                  hintText: 'old password',
                  hintStyle: TextStyle(color: Color(0xFFA7A4A4), fontSize: 12),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondaryColor),
                      borderRadius: BorderRadius.circular(25))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 15, 25, 5),
            child: TextFormField(
              cursorColor: AppColors.secondaryColor,
              decoration: InputDecoration(
                  hintText: 'new password',
                  hintStyle: TextStyle(color: Color(0xFFA7A4A4), fontSize: 12),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondaryColor),
                      borderRadius: BorderRadius.circular(25))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 15, 25, 5),
            child: TextFormField(
              cursorColor: AppColors.secondaryColor,
              decoration: InputDecoration(
                  hintText: 'confirm password',
                  hintStyle: TextStyle(color: Color(0xFFA7A4A4), fontSize: 12),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondaryColor),
                      borderRadius: BorderRadius.circular(25))),
            ),
          ),
       const button(button_text: "Update Password")
        ],
      ),
    );
  }
}