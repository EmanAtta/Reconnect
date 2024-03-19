import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33),
        child: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_left,
                color: AppColors.textolor,
                size: 30,
                ),
                   
          )
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 40),
            child:SvgPicture.asset("assets/password.svg",color: AppColors.secondaryColor,height:120,width:100,),
          ),
          const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom:20),
                child: Text(
                            "Forgot password ?",
                            style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
                          ),
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
                hintStyle: TextStyle(color: AppColors.labelStyle, fontSize: 12),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textolor),
                  borderRadius: BorderRadius.circular(25),
                ),
                enabledBorder: OutlineInputBorder(
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
