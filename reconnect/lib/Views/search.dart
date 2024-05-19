import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/user_profile_screen.dart';
import 'authentications/routes/navigation.dart';

class PostModel {
  late String? postTime;
  late String? postDate;
  late String? name;
  late String? dateoflost;
  late String? phone;
  late String? image_url;
  late String? description;
  late String? firstN;
  late String? lastN;
  late String? userP;
  late String? userEmail;
  late String? id; // Add id field to the model

  PostModel({
    this.postTime,
    this.postDate,
    this.name,
    this.dateoflost,
    this.phone,
    this.image_url,
    this.description,
    this.firstN,
    this.lastN,
    this.userP,
    this.userEmail,
    this.id, // Include id in the constructor
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    postTime: json['timestamp'] ?? '',
    postDate: json['datestamp'] ?? '',
    name: json['name'] ?? '',
    dateoflost: json['dateoflost'] ?? '',
    phone: json['phone'] ?? '',
    image_url: json['image_url'] ?? '',
    description: json['description'] ?? '',
    firstN: json['first_name'] ?? '',
    lastN: json['last_name'] ?? '',
    userP: json['user_photo'] ?? '',
    userEmail: json['user_email'] ?? '',
    id: json['id'] ?? '', // Include id in the factory
  );

  Map<String, dynamic> toJson() => {
    'datestamp': postDate,
    'timestamp': postTime,
    'name': name,
    'dateoflost': dateoflost,
    'phone': phone,
    'image_url': image_url,
    'description': description,
    'first_name': firstN,
    'last_name': lastN,
    'user_photo': userP,
    'user_email': userEmail,
    'id': id, // Include id in the toJson method
  };
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  File? _image;
  List<String> _postIds = [];
  List<PostModel> _posts = [];
  bool _isLoading = false;
  bool _noResultsFound = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _noResultsFound = false;
      });
      _isLoading = true;
      setState(() {});
      _uploadImage(_image!);
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    // اللينك بيتغير حسب السيرفر
    final url = Uri.parse('https://6d12-156-197-201-166.ngrok-free.app/search'); // Replace with your actual API endpoint
    final request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        if (responseData.isNotEmpty) {
          setState(() {
            _postIds = responseData.split(',').map((id) => id.trim()).toList();
            _isLoading = false;
            _searchPosts();
            print(_postIds);
          });
        } else {
          _isLoading = false;
          setState(() {
            _noResultsFound = true;
          });
        }
      } else {
        _isLoading = false;
        setState(() {});
        print('Image upload failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      _isLoading = false;
      setState(() {});
      print('Error during image upload: $error');
      _noResultsFound = true;
    }
  }

  Future<void> _searchPosts() async {
    _posts.clear();

    if (_postIds.isNotEmpty) {
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('posts')
            .where('id', whereIn: _postIds) // Use whereIn for multiple IDs
            .get();

        if (snapshot.docs.isNotEmpty) {
          setState(() {
            _posts = snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList();
            _noResultsFound = false; // Results found
          });
        } else {
          setState(() {
            _noResultsFound = true; // No results
          });
        }
      } catch (error) {
        print('Error fetching posts: $error');
        setState(() {
          _noResultsFound = true; // Error occurred
        });
      }
    } else {
      setState(() {
        _noResultsFound = true; // No IDs to search
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.primaryColor),
        ),
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => Navigationpage());
          },
          icon: const Icon(Icons.keyboard_arrow_left,
              color: AppColors.primaryColor),
        ),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _pickImage,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  AppColors.secondaryColor),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.image, color: AppColors.primaryColor),
                SizedBox(width: 8),
                Text('Pick Image',
                    style: TextStyle(color: AppColors.primaryColor)),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          if (_image != null)
            SizedBox(
              height: 200,
              child: Image.file(
                _image!,
                fit: BoxFit.cover,
              ),
            )
          else
            SizedBox.shrink(),

          if (_isLoading)
            Center(child: CircularProgressIndicator())
          else if (_noResultsFound)
            Center(
              child: Text(
                'No results found.',
                style: TextStyle(fontSize: 18),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  final post = _posts[index];
                  return Card(
                    elevation: 30,
                    shadowColor: AppColors.textolor,
                    color: AppColors.primaryColor,
                    margin: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(post.userP ?? ''),
                              ),
                              SizedBox(width: 8.0),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserProfileScreen(
                                        userPhotoUrl: post.userP ?? '',
                                        firstName: post.firstN ?? '',
                                        lastName: post.lastN ?? '',
                                        userEmail: post.userEmail ?? '',
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${post.firstN ?? ''} ${post.lastN ?? ''}',
                                      style: TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    RichText(
                                      text: TextSpan(
                                        text:
                                        '${post.postDate}    |    ${post.postTime}',
                                        style: TextStyle(
                                          color: AppColors.secondaryColor,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: post.image_url != null &&
                                post.image_url!.isNotEmpty
                                ? Image.network(
                              post.image_url!,
                              fit: BoxFit.contain,
                            )
                                : Center(
                              child: Text('No image'),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          RichText(
                            text: TextSpan(
                              text: 'Name: ',
                              style: TextStyle(
                                color: AppColors.secondaryColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: '${post.name}',
                                  style: TextStyle(
                                    color: AppColors.textolor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.0),
                          RichText(
                            text: TextSpan(
                              text: 'Date Of Lost: ',
                              style: TextStyle(
                                color: AppColors.secondaryColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: '${post.dateoflost}',
                                  style: TextStyle(
                                    color: AppColors.textolor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.0),
                          RichText(
                            text: TextSpan(
                              text: 'Phone: ',
                              style: TextStyle(
                                color: AppColors.secondaryColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: '${post.phone}',
                                  style: TextStyle(
                                    color: AppColors.textolor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.0),
                          RichText(
                            text: TextSpan(
                              text: 'Description: ',
                              style: TextStyle(
                                color: AppColors.secondaryColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: '${post.description}',
                                  style: TextStyle(
                                    color: AppColors.textolor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}