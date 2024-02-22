import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:    const Color(0xFFE9D6BF)  ,
      appBar: AppBar(title: const Center(
        child: Text('About',style:
         TextStyle(fontWeight: FontWeight.bold,color:Color(0xFFE9D6BF) ,),
         ),
      ),
       backgroundColor:  const Color(0xFF233F41),
    ),);
  }
}