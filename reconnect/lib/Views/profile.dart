import 'package:flutter/material.dart';
import 'package:reconnect/Views/color.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor ,
      appBar: AppBar(title: const Text('Profile',style:
       TextStyle(fontWeight: FontWeight.bold,color:AppColors.primaryColor),
       ),
      backgroundColor:AppColors.secondaryColor) ,
       
    );
  }
}