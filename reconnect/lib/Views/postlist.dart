import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reconnect/Views/authentications/routes/navigationcontroller.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/user_profile_screen.dart';
import 'package:share_plus/share_plus.dart';



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
  late String? uniqueLink;

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
    this.uniqueLink,
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
        uniqueLink: json['uniqueLink'] ?? '',
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
        'uniqueLink': uniqueLink,
      };
}

class PostListPage extends StatelessWidget {
  final List<PostModel> posts;

  const PostListPage({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    BottomNavigationController bottomnavigationcontroller =
    Get.put(BottomNavigationController());
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('datestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
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
                margin: const EdgeInsets.all(8.0),
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
                          const SizedBox(width: 8.0),
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
                                  style: const TextStyle(
                                    color: AppColors.secondaryColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                RichText(
                                  text: TextSpan(
                                    text:
                                    '${posts[index].postDate}    |    ${posts[index].postTime}',
                                    style: const TextStyle(
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
                      const SizedBox(height: 10.0),
                      SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: posts[index].image_url != null &&
                            posts[index].image_url!.isNotEmpty
                            ? Image.network(
                          posts[index].image_url!,
                          fit: BoxFit.contain,
                        )
                            : const Center(
                          child: Text('No image'),
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      RichText(
                        text: TextSpan(
                          text: 'Name: ',
                          style: const TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: '${posts[index].name}',
                              style: const TextStyle(
                                color: AppColors.textolor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      RichText(
                        text: TextSpan(
                          text: 'Date Of Lost: ',
                          style: const TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: '${posts[index].dateoflost}',
                              style: const TextStyle(
                                color: AppColors.textolor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      RichText(
                        text: TextSpan(
                          text: 'Phone: ',
                          style: const TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: '${posts[index].phone}',
                              style: const TextStyle(
                                color: AppColors.textolor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      RichText(
                        text: TextSpan(
                          text: 'Description: ',
                          style: const TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: '${posts[index].description}',
                              style: const TextStyle(
                                color: AppColors.textolor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          sharePost(posts[index]);
                        },
                        icon: const Icon(Icons.share),
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
        backgroundColor: AppColors.primaryColor,
        child: const Icon(
          Icons.add,
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }

  Future<void> sharePost(PostModel post) async {
    final String uniqueLink = post.uniqueLink ?? '';
    final String webUrl = 'https://reconnect-8f8e9.web.app/?id=$uniqueLink';  // رابط صفحة الويب

    await Share.share(
      'Check out this lost item!\n\n$webUrl',
      subject: 'Lost Item Post',
    );
  }
}



