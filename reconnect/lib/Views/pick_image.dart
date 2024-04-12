import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reconnect/Views/color.dart';


import 'package:dotted_border/dotted_border.dart';

class ImagePage extends StatefulWidget {
  
  ImagePage({super.key});

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
      
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Color(0xFF4A563E),
              child: Center(
                  child: _pickedImage != null
                      ? Container(
                        width: 300,
                        height: 250,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white70, // Set border color
                              width: 3, // Set border width
                            ),
                          ),
                          child: Image.file(
                            File(_pickedImage!.path),
                            height: 250,
                          ),
                        )
                      : DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(10),
                          padding: EdgeInsets.all(20),
                        color:Color(0xFFFFE8D6),
  strokeWidth: 2,
  dashPattern: [
    5,
    5,],
                        child: Container(
                            
                              
                            child:  SvgPicture.asset("assets/bro.svg")
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
                    height: 10,
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
class BottomDiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

