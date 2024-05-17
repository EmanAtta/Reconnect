import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/modified.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? pickedImage;
  String? rotatedImageUrl;
  int age = 10;

  Future<void> pickImage() async {
    final pickedImageFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = File(pickedImageFile!.path);
    });
  }



  Future<void> uploadAndModifyImage(File imageFile, int ages) async {
    //اللينك ده بتاع السيرفر و بيتغير لما نفتح السيرفر
    final url = Uri.parse('https://229e-156-197-238-166.ngrok-free.app/modify');
    final request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
    ));
    request.fields['age'] = ages.toString();
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(await response.stream.bytesToString());
      setState(() {
        rotatedImageUrl =
            'https://229e-156-197-238-166.ngrok-free.app' +
                responseJson['modified_image_url'];
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondPage(modifiedImageUrl: rotatedImageUrl),
        ),
      );
    } else {
      throw Exception('Failed to upload and modify image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              color: Color(0xFF4A563E),
              child:

              Center(
                child: pickedImage != null
                    ? Container(
                  width: 300,
                  height: 300,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 7.0),
                  ),
                  child: Image.file(
                    pickedImage!,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                )
                    : Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Image.asset('assets/upload.png'),
                ),
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              color: AppColors.primaryColor,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: pickImage,
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.image,color: Color(0xFF4A563E)),
                        SizedBox(width: 8),
                        Text('Pick Image',style: TextStyle(color: Color(0xFF4A563E))),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: DropdownButton<int>(
                      value: age,
                      onChanged: (value) {
                        setState(() {
                          age = value!;
                        });
                      },
                      items: [10, 20, 30, 40, 50, 60].map((int ages) {
                        return DropdownMenuItem<int>(
                          value: ages,
                          child: Text('$ages Years old'),
                        );
                      }).toList(),
                    ),
                  ),
                  TextButton(
                    onPressed: pickedImage == null
                        ? null
                        : () {
                      uploadAndModifyImage(pickedImage!, age);

                   Get.to(SecondPage());

Get.to(SecondPage(imageFile: pickedImage));

                    },
                    //     () => uploadAndModifyImage(
                    //   pickedImage!,
                    //   age,
                    // ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit,color: Color(0xFF4A563E)),
                        SizedBox(width: 8),
                        Text('Modify Image',style: TextStyle(color: Color(0xFF4A563E))),
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



