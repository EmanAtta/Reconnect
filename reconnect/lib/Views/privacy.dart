import 'package:flutter/material.dart';
import 'package:reconnect/Views/color.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: AppColors.primaryColor ,
      appBar: AppBar(title: const Text('Privacy',style:
       TextStyle(fontWeight: FontWeight.bold,color: AppColors.textolor),
       ),
       backgroundColor:AppColors.secondaryColor,
    ),);
  }
}