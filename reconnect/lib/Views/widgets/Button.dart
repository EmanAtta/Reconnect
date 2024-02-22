import 'package:flutter/material.dart';
import 'package:reconnect/Views/color.dart';

class button extends StatefulWidget {
  final String button_text;
  const button({super.key, required this.button_text});

  @override
  State<button> createState() => _buttonState();
}

class _buttonState extends State<button> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppColors.textolor),
            boxShadow: [BoxShadow(blurRadius: 2, spreadRadius: 1)]),
            child: Center(child: Text(widget.button_text,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: AppColors.textolor),),
      ),
      )
    );
  }
}
