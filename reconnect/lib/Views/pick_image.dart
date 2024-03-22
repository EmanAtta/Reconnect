import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/home.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedImage;

  Future<void> _pickImageFromGallery() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = image != null ? XFile(image.path) : null;
    });
  }

  Future<void> _captureImageFromCamera() async {
    final image = await _imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _pickedImage = image != null ? XFile(image.path) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: const Text(
          'Reconnect',
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
      ),
      endDrawer: Drawer(
        child: Container(
          padding: const EdgeInsets.only(top: 0),
          color: AppColors.secondaryColor,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ClipPath(
                  clipper: DiagonalClipper(),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(4)),
                    ),
                    height: 100,
                    width: double.infinity,
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 215,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: AppColors.primaryColor,
                    ),
                    title: const Text(
                      'Profile',
                      style: TextStyle(
                          color: AppColors.primaryColor, fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'profile');
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.settings,
                      color: AppColors.primaryColor,
                    ),
                    title: const Text(
                      'Settings',
                      style: TextStyle(
                          color: AppColors.primaryColor, fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'settings');
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.privacy_tip_outlined,
                      color: AppColors.primaryColor,
                    ),
                    title: const Text(
                      'Privacy',
                      style: TextStyle(
                          color: AppColors.primaryColor, fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'privacy');
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.report_gmailerrorred_rounded,
                      color: AppColors.primaryColor,
                    ),
                    title: const Text(
                      'About',
                      style: TextStyle(
                          color: AppColors.primaryColor, fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'about');
                    },
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipPath(
                  clipper: BottomDiagonalClipper(),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                    ),
                    height: 100,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30, bottom: 15),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'welcome');
                          },
                          child: const Text(
                            'Sign Out',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondaryColor,
                              fontSize: 25,
                              
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Color(0xFF4A563E),
              child: Center(
                  child: _pickedImage != null
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white70, // Set border color
                              width: 2, // Set border width
                            ),
                          ),
                          child: Image.file(
                            File(_pickedImage!.path),
                            height: 250,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white70, // Set border color
                              width: 2, // Set border width
                            ),
                          ),
                          child: Image(
                            image: AssetImage('assets/upload.png'),
                            height: 250,
                          ),
                        )),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: Color(0xFFFFE8D6),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                    onPressed: _captureImageFromCamera,
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(const BorderSide(
                          color:
                              Color(0xFF4A563E))), // Set border color to black
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize
                          .min, // Ensure that the row takes only the minimum required space
                      children: [
                        Icon(Icons.camera_alt,
                            color: Color(0xFF4A563E)), // Icon widget
                        SizedBox(
                            width:
                                8), // Add some space between the icon and the text
                        Text(
                          'Camera',
                          style: TextStyle(color: Color(0xFF4A563E)),
                        ), // Text widget
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Stack(
                    children: [
                      // Divider
                      Center(
                        child: SizedBox(
                          width: 200,
                          child: Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                        ),
                      ),
                      // Text
                      Positioned(
                        child: Align(
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              ' OR ',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(backgroundColor: Color(0xFFFFE8D6)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextButton(
                    onPressed: _pickImageFromGallery,
                    child: const Row(
                      mainAxisSize: MainAxisSize
                          .min, // Ensure that the row takes only the minimum required space
                      children: [
                        Icon(Icons.photo,
                            color: Color(0xFF4A563E)), // Camera Icon widget
                        SizedBox(
                            width:
                                8), // Add some space between the icon and the text
                        Text('Select image from gallery',
                            style: TextStyle(
                                color: Color(0xFF4A563E))), // Text widget
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(const BorderSide(
                          color:
                              Color(0xFF4A563E))), // Set border color to black
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Next',
                            style: TextStyle(
                                color: Color(0xFF4A563E))), // Text widget
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
