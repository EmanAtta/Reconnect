import 'package:flutter/material.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/widgets/Button.dart';

class resetPassword extends StatefulWidget {
  const resetPassword({super.key});

  @override
  State<resetPassword> createState() => _resetPasswordState();
}

class _resetPasswordState extends State<resetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        const Center(child: Text('Reset password',style: TextStyle(color: AppColors.secondaryColor,fontSize: 20,fontWeight: FontWeight.bold))),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
          child: TextFormField(cursorColor: AppColors.primaryColor,decoration: InputDecoration(hintText: 'new password',hintStyle: TextStyle(color: Color(0xFFA7A4A4),fontSize: 12),border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.secondaryColor),borderRadius: BorderRadius.circular(25))
          ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
          child: TextFormField(cursorColor: AppColors.primaryColor,decoration: InputDecoration(hintText: 'confirm password',hintStyle: TextStyle(color: Color(0xFFA7A4A4),fontSize: 12),border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.secondaryColor),borderRadius: BorderRadius.circular(25))
          ),
          ),
        ),
        button(button_text: "send")
      ],),
    );
  }
}