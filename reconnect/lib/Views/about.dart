import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reconnect/Views/color.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:AppColors.primaryColor ,
      appBar: AppBar(title: const Text('About',style:
       TextStyle(fontWeight: FontWeight.bold,color:AppColors.primaryColor ,),
       ),
       leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.keyboard_arrow_left,
              color: AppColors.primaryColor),
          ),
       backgroundColor: AppColors.secondaryColor,
    ),);
  }
}