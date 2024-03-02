// // // import 'package:flutter/material.dart';
// // // import 'dart:io';

// // // import 'package:reconnect/Views/color.dart';

// // // class PostModel {
// // //   late String title;
// // //   late String description;
// // //   late String tags;
// // //   late File image;

// // //   PostModel({
// // //     required this.title,
// // //     required this.description,
// // //     required this.tags,
// // //     required this.image,
// // //   });
// // // }

// // // class PostListPage extends StatelessWidget {
// // //   final List<PostModel> posts;

// // //   const PostListPage({Key? key, required this.posts}) : super(key: key);

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: AppColors.primaryColor,
// // //       body: ListView.builder(
// // //         itemCount: posts.length,
// // //         itemBuilder: (context, index) {
// // //           return Card(
// // //             margin: EdgeInsets.all(8.0),
// // //             child: Padding(
// // //               padding: const EdgeInsets.all(12.0),
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Image.file(
// // //                     posts[index].image,
// // //                     width: double.infinity,
// // //                     height: 200,
// // //                     fit: BoxFit.cover,
// // //                   ),
// // //                   SizedBox(height: 12.0),
// // //                   Text(
// // //                     'Name :${posts[index].title}',
// // //                     style: TextStyle(
// // //                       fontSize: 18.0,
// // //                       fontWeight: FontWeight.bold,
// // //                       color: AppColors.textolor,
// // //                     ),
// // //                   ),
// // //                   SizedBox(height: 12.0),
// // //                   Text(
// // //                     'Date Of Lost :${posts[index].description}',
// // //                     style: TextStyle(
// // //                         color: AppColors.textolor,
// // //                         fontSize: 18.0,
// // //                         fontWeight: FontWeight.bold),
// // //                   ),
// // //                   SizedBox(height: 10.0),
// // //                   Text(
// // //                     'Phone : ${posts[index].tags}',
// // //                     style: TextStyle(
// // //                         color: AppColors.textolor,
// // //                         fontSize: 18.0,
// // //                         fontWeight: FontWeight.bold),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),

// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'dart:io';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/widgets.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:reconnect/Views/color.dart';
// // import 'package:reconnect/Views/post.dart';

// // class PostModel {
// //   late String title;
// //   late String description;
// //   late String tags;
// //   late File image;

// //   PostModel({
// //     required this.title,
// //     required this.description,
// //     required this.tags,
// //     required this.image,
// //   });
// // }

// // class PostListPage extends StatelessWidget {
// //   final List<PostModel> posts;

// //   const PostListPage({Key? key, required this.posts}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AppColors.primaryColor,
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: posts.length,
// //               itemBuilder: (context, index) {
// //                 return Card(
// //                   elevation: 30, // Set the elevation to add a shadow
// //                   shadowColor: AppColors.textolor,
// //                   color: AppColors.primaryColor,
// //                   margin: EdgeInsets.all(8.0),
// //                   child: Padding(
// //                     padding: const EdgeInsets.all(12.0),
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         ClipRRect(
// //                           borderRadius: BorderRadius.circular(12.0),
// //                           child: Image.file(
// //                             posts[index].image,
// //                             width: double.infinity,
// //                             height: 200,
// //                             fit: BoxFit.cover,
// //                           ),
// //                         ),
// //                         SizedBox(height: 12.0),
// //                         Text(
// //                           'Name: ${posts[index].title}',
// //                           style: TextStyle(
// //                             fontSize: 18.0,
// //                             fontWeight: FontWeight.bold,
// //                             color: AppColors.textolor,
// //                           ),
// //                         ),
// //                         SizedBox(height: 12.0),
// //                         Text(
// //                           'Date Of Lost: ${posts[index].description}',
// //                           style: TextStyle(
// //                               color: AppColors.textolor,
// //                               fontSize: 18.0,
// //                               fontWeight: FontWeight.bold),
// //                         ),
// //                         SizedBox(height: 10.0),
// //                         Text(
// //                           'Phone: ${posts[index].tags}',
// //                           style: TextStyle(
// //                               color: AppColors.textolor,
// //                               fontSize: 18.0,
// //                               fontWeight: FontWeight.bold),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),
// //           Column(
// //             children: [
// //               IconButton(
// //                 color: AppColors.secondaryColor,
// //                 icon: Padding(
// //                   padding: EdgeInsets.only(bottom: 2),
// //                   child: Icon(
// //                     Icons.add,
// //                     size: 30,
// //                   ),
// //                 ),
// //                 onPressed: () {
// //                   // Navigate to the post creation page
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder: (context) => Post(),
// //                     ),
// //                   );
// //                 },
// //               ),
// //               Text(
// //                 'Add Post',
// //                 style: TextStyle(
// //                     color: AppColors.secondaryColor,
// //                     fontWeight: FontWeight.w500),
// //               )
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:reconnect/Views/color.dart';
// import 'package:reconnect/Views/post.dart';

// class PostModel {
//   late String title;
//   late String description;
//   late String tags;
//   late File image;

//   PostModel({
//     required this.title,
//     required this.description,
//     required this.tags,
//     required this.image,
//   });
// }

// class PostListPage extends StatelessWidget {
//   final List<PostModel> posts;

//   const PostListPage({Key? key, required this.posts}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primaryColor,
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: posts.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   elevation: 30,
//                   shadowColor: AppColors.textolor,
//                   color: AppColors.primaryColor,
//                   margin: EdgeInsets.all(8.0),
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(12.0),
//                           child: Image.file(
//                             posts[index].image,
//                             width: double.infinity,
//                             height: 200,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         SizedBox(height: 12.0),
//                         Text(
//                           'Name: ${posts[index].title}',
//                           style: TextStyle(
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.textolor,
//                           ),
//                         ),
//                         SizedBox(height: 12.0),
//                         Text(
//                           'Date Of Lost: ${posts[index].description}',
//                           style: TextStyle(
//                               color: AppColors.textolor,
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 10.0),
//                         Text(
//                           'Phone: ${posts[index].tags}',
//                           style: TextStyle(
//                               color: AppColors.textolor,
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           // Column(
//           //   children: [
//           //     IconButton(
//           //       color: AppColors.secondaryColor,
//           //       icon: Padding(
//           //         padding: EdgeInsets.only(bottom: 2),
//           //         child: Icon(
//           //           Icons.add,
//           //           size: 30,
//           //         ),
//           //       ),
//           //       onPressed: () {
//           //         Navigator.push(
//           //           context,
//           //           MaterialPageRoute(
//           //             builder: (context) => Post(),
//           //           ),
//           //         );
//           //       },
//           //     ),
//           //     Text(
//           //       'Add Post',
//           //       style: TextStyle(
//           //           color: AppColors.secondaryColor,
//           //           fontWeight: FontWeight.w500),
//           //     )
//           //   ],
//           // ),
//         ],
//       ),
//     );
//   }
// }

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
                        Text(
                          'Name: ${posts[index].title}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textolor,
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          'Date Of Lost: ${posts[index].description}',
                          style: TextStyle(
                              color: AppColors.textolor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Phone: ${posts[index].tags}',
                          style: TextStyle(
                              color: AppColors.textolor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
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
