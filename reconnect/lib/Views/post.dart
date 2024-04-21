
 import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:image_picker/image_picker.dart';
import 'package:reconnect/Views/color.dart';

import 'postlist.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  List<PostModel> allPosts = [];
  File? _selectedImage;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dateoflostController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  List<Map<String, String>> _countryCodes = [
    {"name": " Select Country Code", "code": ""},
    {"name": "+1 (US)", "code": "+1"},
    {"name": "+44 (UK)", "code": "+44"},
    {"name": "+49 (Germany)", "code": "+49"},
    {"name": "+61 (Australia)", "code": "+61"},
    {"name": "+86 (China)", "code": "+86"},
    {"name": "+91 (India)", "code": "+91"},
    {"name": "+81 (Japan)", "code": "+81"},
    {"name": "+7 (Russia)", "code": "+7"},
    {"name": "+971 (UAE)", "code": "+971"},
    {"name": "+90 (Turkey)", "code": "+90"},
    {"name": "+92 (Pakistan)", "code": "+92"},
    {"name": "+234 (Nigeria)", "code": "+234"},
    {"name": "+254 (Kenya)", "code": "+254"},
    {"name": "+20 (Egypt)", "code": "+20"},
  ];

  String _selectedCountryCode = "";

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _submitPost() {
    String name = _nameController.text;
    String dateoflost = _dateoflostController.text;
    String phone = _phoneController.text;
    String description = _descriptionController.text;

    if (name.isEmpty ||
        dateoflost.isEmpty ||
        phone.isEmpty ||
        _selectedImage == null ||
        description.isEmpty) {
      return;
    }

    PostModel post = PostModel(
      name: name,
      dateoflost: dateoflost,
      phone: phone,
      description: description,
      image: _selectedImage!,
    );
    allPosts.add(post);

    setState(() {
      _selectedImage = null;
      _nameController.clear();
      _dateoflostController.text = '/ / /';
      _phoneController.clear();
      _descriptionController.clear();
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostListPage(
          posts: allPosts,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 34, left: 20, right: 20),
          child: Column(
            children: [
              Card(
                elevation: 30,
                shadowColor: AppColors.textolor,
                color: AppColors.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InkWell(
                        onTap: _getImage,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: _selectedImage != null
                              ? Container(
                                  color: AppColors.primaryColor,
                                  child: Image.file(
                                    _selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  color: Colors.grey[300],
                                  height: 180,
                                  child: const Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_photo_alternate,
                                          size: 50,
                                          color: AppColors.textolor,
                                        ),
                                        SizedBox(height: 5.0),
                                        Text(
                                          'Add Image',
                                          style: TextStyle(
                                              color: AppColors.textolor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: 1.0),
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: '  Name:',
                          labelStyle: TextStyle(
                              color: AppColors.textolor,
                              fontWeight: FontWeight.bold),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                      SizedBox(height: 1.0),
                      TextField(
                        controller: _dateoflostController,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText: '  Date Of Lost:',
                          labelStyle: TextStyle(
                              color: AppColors.textolor,
                              fontWeight: FontWeight.bold),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                        inputFormatters: [
                          DateTextFormatter(),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(1),
                            margin: EdgeInsets.only(right: 5, top: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                iconSize: 10,
                                value: _selectedCountryCode,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCountryCode = value!;
                                  });
                                },
                                dropdownColor:
                                    Color.fromRGBO(255, 255, 255, 0.7),
                                items: _countryCodes
                                    .map((country) => DropdownMenuItem(
                                          value: country['code'],
                                          child: Text(
                                            country['name']!,
                                            style: TextStyle(fontSize: 7.0),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _phoneController,
                              decoration: InputDecoration(
                                labelText: 'Phone:',
                                labelStyle: TextStyle(
                                  color: AppColors.textolor,
                                  fontWeight: FontWeight.bold,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      TextField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Description: ',
                          labelStyle: TextStyle(
                            color: AppColors.textolor,
                            fontWeight: FontWeight.bold,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submitPost,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    fixedSize: const Size(130, 40)),
                child: const Text(
                  'Post',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;

    if (newText.length == 2 || newText.length == 5) {
      final text = '$newText/';
      return newValue.copyWith(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }

    return newValue;
  }
}

