
import 'package:flutter/material.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/widgets/Button.dart';
class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.primaryColor),
        ),
       
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left,
              color: AppColors.primaryColor),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      body:SingleChildScrollView(
        child: Column(
            children: [
              SizedBox(height:70),
            const Text("First name",style: TextStyle(color: AppColors.secondaryColor,fontSize: 20),textAlign: TextAlign.left),
               Padding(
                 padding: const EdgeInsets.only(left:10,right: 10),
                 child: TextFormField(
                    cursorColor: AppColors.textolor,
                      decoration: InputDecoration(
                 
                            border: OutlineInputBorder(borderSide: const BorderSide(color: AppColors.secondaryColor),borderRadius: BorderRadius.circular(25)),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppColors.secondaryColor),borderRadius: BorderRadius.circular(25))
                          ),
                 ),
               ),
               SizedBox(height: 20),
               const Text("last name",style: TextStyle(color: AppColors.secondaryColor,fontSize: 20),textAlign: TextAlign.left),
               Padding(
                 padding: const EdgeInsets.only(left:10,right: 10),
                 child: TextFormField(
                    cursorColor: AppColors.textolor,
                      decoration: InputDecoration(
                 
                            border: OutlineInputBorder(borderSide: const BorderSide(color: AppColors.secondaryColor),borderRadius: BorderRadius.circular(25)),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppColors.secondaryColor),borderRadius: BorderRadius.circular(25))
                          ),
                 ),
               ),
               SizedBox(height: 20),
               const Text("Email",style: TextStyle(color: AppColors.secondaryColor,fontSize: 20),textAlign: TextAlign.left),
               Padding(
                 padding: const EdgeInsets.only(left:10,right: 10),
                 child: TextFormField(
                    cursorColor: AppColors.textolor,
                      decoration: InputDecoration(
                 
                            border: OutlineInputBorder(borderSide: const BorderSide(color: AppColors.secondaryColor),borderRadius: BorderRadius.circular(25)),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppColors.secondaryColor),borderRadius: BorderRadius.circular(25))
                          ),
                 ),
               ),
               SizedBox(height: 20),
               const Text("Password",style: TextStyle(color: AppColors.secondaryColor,fontSize: 20),textAlign: TextAlign.left),
               Padding(
                 padding: const EdgeInsets.only(left:10,right: 10),
                 child: TextFormField(
                    cursorColor: AppColors.textolor,
                      decoration: InputDecoration(
                 
                            border: OutlineInputBorder(borderSide: const BorderSide(color: AppColors.secondaryColor),borderRadius: BorderRadius.circular(25)),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppColors.secondaryColor),borderRadius: BorderRadius.circular(25))
                          ),
                 ),
               ),
        
               SizedBox(height:40),
               button(button_text: "Save changes")
        
          
            ],
          ),
      ),
      
    );
  }
}
