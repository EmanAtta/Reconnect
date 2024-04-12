import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _tagsController = TextEditingController();
  TextEditingController _newTextFieldController = TextEditingController();

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
    String title = _titleController.text;
    String description = _descriptionController.text;
    String tags = _tagsController.text;
    String newTextFieldValue = _newTextFieldController.text;

    if (title.isEmpty ||
        description.isEmpty ||
        tags.isEmpty ||
        _selectedImage == null ||
        newTextFieldValue.isEmpty) {
      return;
    }

    PostModel post = PostModel(
      title: title,
      description: description,
      tags: tags,
      newTextFieldValue: newTextFieldValue,
      image: _selectedImage!,
    );
    allPosts.add(post);

    setState(() {
      _selectedImage = null;
      _titleController.clear();
      _descriptionController.clear();
      _tagsController.clear();
      _newTextFieldController.clear();
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
                                  height: 200,
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
                        controller: _titleController,
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
                        controller: _descriptionController,
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
                      ),
                      const SizedBox(height: 2),
                      TextField(
                        controller: _tagsController,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText: '  Phone:',
                          labelStyle: TextStyle(
                              color: AppColors.textolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      TextField(
                        controller: _newTextFieldController,
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
