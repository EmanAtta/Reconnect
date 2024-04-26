import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:reconnect/Views/color.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: AppColors.primaryColor ,
      appBar: AppBar(title: const Text('Privacy',style:
       TextStyle(fontWeight: FontWeight.bold,color: AppColors.primaryColor),
       ),
       leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.keyboard_arrow_left,
              color: AppColors.primaryColor),
          ),
       backgroundColor:AppColors.secondaryColor,
    ),);
  }
}