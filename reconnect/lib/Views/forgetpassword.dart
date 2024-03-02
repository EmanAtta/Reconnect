import 'package:flutter/material.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/widgets/Button.dart';


class forgetBassword extends StatefulWidget {
  const forgetBassword({super.key});

  @override
  State<forgetBassword> createState() => _forgetBasswordState();
}

class _forgetBasswordState extends State<forgetBassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
              child: Text(
            "Forgot password ?",
            style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )),
          const Center(
            child: Text(
              "enter email  address",
              style: TextStyle(color: AppColors.textolor, fontSize: 18),
            ),
          ),
          const Center(
            child: Text("associate with your account",
                style: TextStyle(color: AppColors.textolor, fontSize: 18)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 15, 25, 10),
            child: TextFormField(
              cursorColor: AppColors.primaryColor,
              decoration: InputDecoration(
                hintText: 'enter email',
                hintStyle: TextStyle(color: Color(0xFFA7A4A4), fontSize: 12),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.secondaryColor),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "verfiyCode");
                },
                child: button(button_text: "send code")),
          )
        ],
      ),
    );
  }
}
