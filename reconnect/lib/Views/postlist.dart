import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:reconnect/Views/authentications/routes/navigationcontroller.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/user_profile_screen.dart';



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
      };
}

class PostListPage extends StatelessWidget {
  final List<PostModel> posts;

  const PostListPage({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BottomNavigationController bottomnavigationcontroller =
        Get.put(BottomNavigationController());
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<PostModel> posts = snapshot.data!.docs
              .map((doc) =>
                  PostModel.fromJson(doc.data() as Map<String, dynamic>))
              .toList();

          return ListView.builder(
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
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkImage(posts[index].userP ?? ''),
                          ),
                          SizedBox(width: 8.0),
                          GestureDetector(
                            onTap: () {
                              // Navigate to user profile screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserProfileScreen(
                                    userPhotoUrl: posts[index].userP ?? '',
                                    firstName: posts[index].firstN ?? '',
                                    lastName: posts[index].lastN ?? '',
                                    userEmail: posts[index].userEmail ?? '',
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${posts[index].firstN ?? ''} ${posts[index].lastN ?? ''}',
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
                                        '${posts[index].postDate}    |    ${posts[index].postTime}',
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
                        child: posts[index].image_url != null &&
                                posts[index].image_url!.isNotEmpty
                            ? Image.network(
                                posts[index].image_url!,
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bottomnavigationcontroller.change(1);
        },
        child: Icon(
          Icons.add,
          color: AppColors.secondaryColor,
        ),
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }
}
