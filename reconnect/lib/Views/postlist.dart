
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/post.dart';

class PostModel {
  late String name;
  late String dateoflost;
  late String phone;
  late String description;
  late File image;

  PostModel({
    required this.name,
    required this.dateoflost,
    required this.phone,
    required this.image,
    required this.description,
   
  });
}

class PostListPage extends StatelessWidget {
  final List<PostModel> posts;

  const PostListPage({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.file(
                            posts[index].image,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 12.0),
                        RichText(
                          text: TextSpan(
                            text: 'Name: ',
                            style: TextStyle(
                              color: AppColors
                                  .secondaryColor, 
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: '${posts[index].name}',
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
                                text: '${posts[index].dateoflost}',
                                style: TextStyle(
                                  color: AppColors
                                      .textolor, 
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
                              color: AppColors
                                  .secondaryColor, 
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: '${posts[index].phone}',
                                style: TextStyle(
                                  color: AppColors.textolor,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Descreption: ',
                            style: TextStyle(
                              color: AppColors.secondaryColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: '${posts[index].description}',
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
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.secondaryColor,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
               Text(
                'Add New Post',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 13),
            ],
          ),
        ],
      ),
    );
  }
}
