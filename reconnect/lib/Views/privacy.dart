import 'package:flutter/material.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:  const Color(0xFFF1E4D4) ,
      appBar: AppBar(title: const Text('Privacy',style:
       TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFE9D6BF)),
       ),
       backgroundColor:  const Color(0xFF233F41),
    ),);
  }
}