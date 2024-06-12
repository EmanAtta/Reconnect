


import 'package:flutter/material.dart';

class Text_field extends StatelessWidget {
  final TextEditingController controller ;
  final bool obscureText;
  final String hintText ;
  const Text_field({
    super.key,
    required this.controller ,
    required this.obscureText,
    required this.hintText

  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:  controller,
      obscureText: obscureText,

      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide:  BorderSide(color: Colors.grey.shade400)
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
        ),
        fillColor: Colors.grey[400],
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.black38
        )
      )


    );
  }
}
