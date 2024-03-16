import 'package:flutter/material.dart';
import 'package:reconnect/Views/color.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:AppColors.primaryColor ,
      appBar: AppBar(title: Text('About',style:
       TextStyle(fontWeight: FontWeight.bold,color:AppColors.primaryColor ,),
       ),
       backgroundColor: AppColors.secondaryColor,
    ),);
  }
}