import 'package:flutter/material.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/widgets/Button.dart';

class verfiyCode extends StatefulWidget {
  const verfiyCode({super.key});

  @override
  State<verfiyCode> createState() => _verfiyCodeState();
}

class _verfiyCodeState extends State<verfiyCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        const Center(child: Text('Verification',style: TextStyle(color: AppColors.secondaryColor,fontSize: 20,fontWeight: FontWeight.bold),)),
        const Center(child: Text('enter verification code ',style: TextStyle(color: AppColors.textolor,fontSize: 18))),
        const Center(child: Text("we have just send to your email address ",style:TextStyle(color: AppColors.textolor,fontSize: 18))),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
          Padding(
            padding: EdgeInsets.only(left:20,top:20),
            child: Icon(
              (Icons.switch_access_shortcut),size: 50,color: AppColors.secondaryColor,),
          ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('Resend code ?',style:TextStyle(color: AppColors.secondaryColor,fontSize: 18)),
            ),
        ],),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
          child: TextFormField(cursorColor: AppColors.primaryColor,decoration: InputDecoration(hintText: 'enter code',hintStyle: TextStyle(color: Color(0xFFA7A4A4),fontSize: 12),border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.secondaryColor),borderRadius: BorderRadius.circular(25))
          ),
          ),
        ),
        Center(child: GestureDetector(onTap: (){Navigator.pushNamed(context,"resetPassword");},child: button(button_text: 'verify')))
      ]),

    );
  }
}