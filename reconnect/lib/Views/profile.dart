import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1E4D4) ,
      appBar: AppBar(title: const Text('Profile',style:
       TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFE9D6BF)),
       ),
      backgroundColor:  const Color(0xFF233F41) ,
       ),
    );
  }
}