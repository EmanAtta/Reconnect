import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(33),
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
            padding: const EdgeInsets.only(bottom:20),
            //child: Icon(Icons.password_outlined,color:AppColors.secondaryColor,size:110,),
            child:SvgPicture.asset("assets/verify.svg",color: AppColors.secondaryColor,height:120,width:110,),
          ),
        const Center(child: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text('Verification',style: TextStyle(color: AppColors.secondaryColor,fontSize: 22,fontWeight: FontWeight.bold),),
        )),
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
          child: TextFormField(cursorColor: AppColors.primaryColor,decoration: InputDecoration(hintText: 'enter code',hintStyle: const TextStyle(color: AppColors.labelStyle,fontSize: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppColors.textolor),borderRadius: BorderRadius.circular(25),
          ),enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.secondaryColor),
                  borderRadius: BorderRadius.circular(25),
                ),
          ),
          ),
        ),
         Padding(
            padding: const EdgeInsets.only(top: 10),
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "resetPassword");
                },
                child: const button(button_text: "verify")),
          ),
       // Center(child: GestureDetector(onTap: (){Navigator.pushNamed(context,"resetPassword");},child: button(button_text: '')))
      ]),

    );
  }
}