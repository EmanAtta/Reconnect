import 'package:flutter/material.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/widgets/Button.dart';
import 'package:reconnect/Views/widgets/textformfield.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(32),
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
    
        body: SingleChildScrollView(
          child: Column(
            children: [
            Container(child: const Image(image: AssetImage("assets/logo.png"))),
            const Text(
                      "Creat account",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondaryColor),
                    ),
           textfield(label_Text: 'first name'),
          textfield(label_Text: 'last name'),
            textfield(label_Text: 'email'),
            Padding(
              padding: const EdgeInsets.only(top: 12,left: 15,right: 15),
              child: TextFormField(
                cursorColor: AppColors.textolor,obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: "password",
                  labelStyle: TextStyle(fontSize: 15,color: AppColors.labelStyle),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.secondaryColor),borderRadius: BorderRadius.circular(30)),
                  focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: AppColors.textolor),borderRadius: BorderRadius.circular(30)),
                  suffixIcon: IconButton(onPressed: (){setState(() {
                                  _obscureText = !_obscureText;
                                });}, icon: _obscureText
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: AppColors.secondaryColor,size: 20,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      color: AppColors.secondaryColor,size: 22,
                                    ),)
                  ),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12,left:15,right: 15),
              child: TextFormField(
                cursorColor: AppColors.textolor,obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: "Confirm password",
                  labelStyle: TextStyle(fontSize: 15,color: AppColors.labelStyle),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.secondaryColor),borderRadius: BorderRadius.circular(30)),
                  focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: AppColors.textolor),borderRadius: BorderRadius.circular(30)),
                  suffixIcon: IconButton(onPressed: (){setState(() {
                                  _obscureText = !_obscureText;
                                });}, icon: _obscureText
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: AppColors.secondaryColor,size: 20,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      color: AppColors.secondaryColor,size: 22,
                                    ),)
                  ),),
            ),
             Padding(
               padding: const EdgeInsets.only(top: 18),
               child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "home");
                            },
               child: const button(
                          button_text: "Sign up",
                        ),
             )),
              Row(children: [
              const Padding(
                padding: EdgeInsets.only(top:20,left: 30),
                child: Text("Already have account ?",style: TextStyle(color: AppColors.secondaryColor,fontSize: 16,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GestureDetector(onTap: (){Navigator.pushReplacementNamed(context, "login");},child: const Text("Login",style: TextStyle(color:AppColors.textolor,fontSize:18,fontWeight: FontWeight.bold))),
              ),
             ],)
          ],
          ),
        ),
      
    );
  }
}