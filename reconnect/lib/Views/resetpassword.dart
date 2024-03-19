import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/widgets/Button.dart';

class resetPassword extends StatefulWidget {
  const resetPassword({super.key});

  @override
  State<resetPassword> createState() => _resetPasswordState();
}

class _resetPasswordState extends State<resetPassword> {
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
            padding: EdgeInsets.only(bottom: 30),
            child:SvgPicture.asset("assets/Change_password.svg",color: AppColors.secondaryColor,height:100,width:90,),
          ),
        const Center(child: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text('Reset password',style: TextStyle(color: AppColors.secondaryColor,fontSize: 22,fontWeight: FontWeight.bold)),
        )),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
          child: TextFormField(cursorColor: AppColors.primaryColor,decoration: InputDecoration(hintText: 'new password',hintStyle: TextStyle(color:AppColors.labelStyle,fontSize: 12),border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.textolor),borderRadius: BorderRadius.circular(25)),
          enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.secondaryColor),
                  borderRadius: BorderRadius.circular(25),
                ),
          ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
          child: TextFormField(cursorColor: AppColors.primaryColor,decoration: InputDecoration(hintText: 'confirm password',hintStyle: TextStyle(color:AppColors.labelStyle,fontSize: 12),border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.textolor),borderRadius: BorderRadius.circular(25)),
          enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.secondaryColor),
                  borderRadius: BorderRadius.circular(25),
                ),
          ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: button(button_text: "send"),
        )
      ],),
    );
  }
}