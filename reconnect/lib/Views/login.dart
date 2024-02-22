import 'package:flutter/material.dart';

class login extends StatelessWidget {
  const login({super.key});

 //bool _obscureText = true;
 // final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        backgroundColor:const Color(0xFFF1E4D4),
        body: Form(
          //key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Container(margin: const EdgeInsets.only(top: 40),child:const Image(image: AssetImage("assets/logo.png")))),
                const Text("Welcom",style:TextStyle(fontSize: 35, fontWeight: FontWeight.bold,color: Color(0xFF233F41)),),
                const Text("Sign in your account",style:TextStyle(fontSize: 20,color:Color(0xFFB8874F)),),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35,20,35,10),
                  child: TextFormField(
                    cursorColor:const Color(0xFF233F41),
                    decoration: InputDecoration(labelText: "user name",
                  labelStyle:const TextStyle(fontSize: 15,color: Color(0xFFB8874F)),
                  focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color:Color(0xFF233F41),width: 1,),
                  borderRadius: BorderRadius.circular(30)
                  ),
                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35,10,35,10),
                  child: TextFormField(
                    decoration: InputDecoration(
                     
                    labelText: "password",
                  labelStyle:const TextStyle(fontSize: 15,color: Color(0xFFB8874F)),
                  focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color:Color(0xFF233F41),width: 1,),
                  borderRadius: BorderRadius.circular(30)
                  ),
                  ),
                  ),
                ),     
              ],
            ),
          ),
        ),
      )
    
    );
  }
}