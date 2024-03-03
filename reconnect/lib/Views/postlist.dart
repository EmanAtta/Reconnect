import 'dart:io';
import 'package:flutter/material.dart';
import 'package:reconnect/Views/color.dart';

class PostModel {
  late String title;
  late String description;
  late String tags;
  late File image;

  PostModel({
    required this.title,
    required this.description,
    required this.tags,
    required this.image,
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
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 12.0),
                        RichText(
                          text: TextSpan(
                            text: 'Name: ',
                            style: TextStyle(
                              color: AppColors
                                  .secondaryColor, // specify the color for the "Name" text
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: '${posts[index].title}',
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
                                text: '${posts[index].description}',
                                style: TextStyle(
                                  color: AppColors
                                      .textolor, // specify the color for the "Date Of Lost" text
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
                                  .secondaryColor, // specify the color for the "Phone" text
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: '${posts[index].tags}',
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
          // Back arrow
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Back To Add New Post',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: AppColors.secondaryColor,
                  size: 30,
                ),
                onPressed: () {
                  // Navigate back to the previous page
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
