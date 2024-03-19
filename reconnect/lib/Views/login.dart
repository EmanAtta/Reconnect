import 'package:flutter/material.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/widgets/Button.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool _obscureText = true;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

String? _emailValidator(String? value) {
   
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\\.,;:\s@\"]+\.)+[^<>()[\]\\.,;:\s@\"]{2,})$';
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }
 String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty || value.length <= 7) {
      return 'Password must be at least 8 characters long';
    }
  
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Form(
             autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formstate,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 Container(
                     margin: const EdgeInsets.only(top:70),
                     child: const Image(
                         image: AssetImage("assets/logo.png")
                         )
                         ),
                  const Text(
                    "Welcome",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor),
                  ),
                  const Text(
                    "Sign in your account",
                    style: TextStyle(fontSize: 20, color: AppColors.textolor),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: TextFormField(
                      cursorColor: AppColors.textolor,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: const TextStyle(
                          fontSize: 15, color: AppColors.labelStyle),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.secondaryColor),borderRadius: BorderRadius.circular(30)),
                         focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.textolor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      validator:_emailValidator,    
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: TextFormField(
                      cursorColor: AppColors.textolor,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: "password",
                        labelStyle: const TextStyle(
                            fontSize: 15, color: AppColors.labelStyle),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.secondaryColor),borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.textolor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(30)),
                        suffixIcon: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: 50,
                            maxHeight: 60,
                          ),
                          child: IconButton(
                            icon: _obscureText
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: AppColors.secondaryColor,size: 20,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: AppColors.secondaryColor,size: 22,
                                  ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                      ),
                      validator: _passwordValidator
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "forgetBassword");
                          },
                          child: const Text(
                            "Forget password ?",
                            style: TextStyle(
                                color: AppColors.secondaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "home");
                      var formdata = formstate.currentState;
                      if (formdata!.validate()) {
                        print("Vaild");
                      } else {
                        print("Not Vaild");
                      }
                    },
                    child: const button(
                      button_text: "Login",
                    ),
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 25, top: 30),
                        child: Text(
                          "Don't have account ?",
                          style: TextStyle(
                              color: AppColors.secondaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "signup");
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                color: AppColors.textolor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
