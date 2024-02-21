import 'package:flutter/material.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:  Color(0xFFE9D6BF) ,
      appBar: AppBar(title: Text('Privacy',style:
       TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFE9D6BF)),
       ),
       backgroundColor:  Color(0xFF233F41),
    ),);
  }
}