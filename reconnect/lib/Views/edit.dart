import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reconnect/Views/authentications/profile_controller.dart';
import 'package:reconnect/Views/authentications/usermodle.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/imageprofile.dart';
import 'package:reconnect/Views/profile.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  StorageService storage = StorageService();
  Uint8List? _image;
  void selectimage() async {
    String filename = DateTime.now().microsecondsSinceEpoch.toString();
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imagebytes = await image.readAsBytes();

    setState(() => _image = imagebytes);
    await storage.uploadfle(filename, image);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Profilecontroller());
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.primaryColor),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.keyboard_arrow_left,
              color: AppColors.primaryColor),
        ),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: FutureBuilder(
        future: controller.getuserdata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              UserModel user = snapshot.data as UserModel;
              final firstname = TextEditingController(text: user.firstname);
              final lastname = TextEditingController(text: user.lastname);
              final email = TextEditingController(text: user.email);
              final password = TextEditingController(text: user.password);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 75,
                                  backgroundImage: MemoryImage(_image!),
                                )
                              : CircleAvatar(
                                  child: Image.asset(
                                    "assets/profile.jpg",
                                    width: 180,
                                  ),
                                  backgroundColor: AppColors.primaryColor,
                                  minRadius: 75,
                                ),
                          Positioned(
                            child: IconButton(
                                icon: Icon(
                                  Icons.add_a_photo,
                                ),
                                onPressed: selectimage),
                            left: 80,
                          )
                        ])),
                    const Text("First name",
                        style: TextStyle(
                            color: AppColors.secondaryColor, fontSize: 20),
                        textAlign: TextAlign.left),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        controller: firstname,
                        cursorColor: AppColors.textolor,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.secondaryColor),
                                borderRadius: BorderRadius.circular(25)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.secondaryColor),
                                borderRadius: BorderRadius.circular(25))),
                      ),
                    ),
                    SizedBox(height: 20),
                    const Text("last name",
                        style: TextStyle(
                            color: AppColors.secondaryColor, fontSize: 20),
                        textAlign: TextAlign.left),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        controller: lastname,
                        cursorColor: AppColors.textolor,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.secondaryColor),
                                borderRadius: BorderRadius.circular(25)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.secondaryColor),
                                borderRadius: BorderRadius.circular(25))),
                      ),
                    ),
                    SizedBox(height: 20),
                    const Text("Email",
                        style: TextStyle(
                            color: AppColors.secondaryColor, fontSize: 20),
                        textAlign: TextAlign.left),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        readOnly:true,
                        controller: email,
                        cursorColor: AppColors.textolor,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.secondaryColor),
                                borderRadius: BorderRadius.circular(25)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.secondaryColor),
                                borderRadius: BorderRadius.circular(25))),
                      ),
                    ),
                    SizedBox(height: 20),
                    
                    SizedBox(height: 40),
                    ElevatedButton(
                        onPressed: () async {
                          final userData = UserModel(
                              firstname: firstname.text.trim(),
                              lastname: lastname.text.trim(),
                              email: email.text.trim(),
                              password: password.text.trim());
                          try {
                            // Update the document
                            await controller.updateRecord(userData);
                            Get.offAll(() => profile());
                          } catch (e) {
                            print('Error updating document: $e');
                            // Handle the error, such as showing a dialog or logging it.
                          }
                        },
                        child: Text("save changes"))
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return Center(child: Text("Something went wrong"));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
