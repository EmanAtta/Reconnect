import 'package:flutter/material.dart';
import 'package:reconnect/Views/color.dart';

class textfield extends StatefulWidget {
final String label_Text;
const textfield({super.key,required this.label_Text});

  @override
  State<textfield> createState() => _textfieldState();
}

class _textfieldState extends State<textfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 12,left:15,right:15),
        child: TextFormField(
          cursorColor: AppColors.textolor,
          decoration:InputDecoration(
            labelText: widget.label_Text,
            labelStyle: const TextStyle(
                            fontSize: 15, color: AppColors.labelStyle),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.secondaryColor),borderRadius: BorderRadius.circular(30)),
                           focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.textolor),borderRadius: BorderRadius.circular(30))
                       
          ),
        ),
      );
  }
}