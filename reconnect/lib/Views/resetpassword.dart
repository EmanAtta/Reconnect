import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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
      appBar: AppBar(
        toolbarHeight: 270,
  
        
        flexibleSpace: Container(
          width: 10.0,
          
          
          decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(8000, 8000),bottomRight: Radius.elliptical(8000, 8000)),gradient: LinearGradient(begin:Alignment.topRight,end: Alignment.bottomLeft,colors: [
           Color(0xff546642),
           Color(0xffA8CC84),
            Color(0xff546642),
            
          ])),
        child:Center(
          child: Padding(
            padding: const EdgeInsets.only(top:5),
            child: SvgPicture.asset("assets/22.svg",height:170,width:170,)
          ),
        )
        ),
        
        //shape: RoundedRectangleBorder(
         // borderRadius: BorderRadius.vertical(
        //bottom: Radius.circular(3500),)
       // ),
        
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Color.fromARGB(221, 255, 255, 255),
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.keyboard_arrow_left,
              color: AppColors.textolor,
              size: 30,
              ),  
        ),
      
        
      ),
      body:  Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Padding(
            padding: EdgeInsets.only(top:10),
            child:Text("verivication ",style: TextStyle(color: Color.fromRGBO(2, 56, 7, 1),fontSize: 35,fontWeight: FontWeight.bold,fontFamily: 'Poppins'),),
          ),
        Padding(
          padding: EdgeInsets.only(top: 20,right: 4,left:30),
          child: Text('we have just send email verification link in your email. please check email and click on link to verify your emai if not auto redirected after verification,click on continue button',
          style: TextStyle(color: Color.fromARGB(255, 7, 63, 19),fontSize: 22,fontWeight: FontWeight.bold,)),
        ),
        
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: Container(
            
            height: 50,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)
 
              ,gradient: LinearGradient(colors: [
           Color(0xff546642),
           Color(0xffA8CC84),
            //Color(0xff546642),
            
          ])),
         child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              child: Text('continue',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      
              )),) ),
        )
      ],),
    );
  }
}