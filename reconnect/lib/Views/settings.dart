import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFE9D6BF) ,
      appBar: AppBar(title: Text('Settings',style:
       TextStyle(fontWeight: FontWeight.bold,color:  Color(0xFFE9D6BF) ),
       ),
       backgroundColor:  Color(0xFF233F41),
    ),)
    ;
  }
}