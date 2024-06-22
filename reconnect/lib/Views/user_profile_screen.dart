import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reconnect/Views/Chat/Pages/ChatPage.dart';
import 'package:reconnect/Views/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

class UserProfileScreen extends StatelessWidget {
  final String userPhotoUrl;
  final String firstName;
  final String lastName;
  final String userEmail;

  const UserProfileScreen({super.key,
    required this.userPhotoUrl,
    required this.firstName,
    required this.lastName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.primaryColor,
        ),
        backgroundColor: AppColors.secondaryColor,
        title: const Padding(
          padding: EdgeInsets.only(bottom: 1),
          child: Text(
            'Reconnect',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 1),
          child: Row(
            children: [
              Expanded(
                // flex: 1,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_outlined), // Back arrow icon
                  onPressed: () {
                    Navigator.of(context).pop(); // This will pop the current route
                  },
                ),
              ),
              SizedBox(width: 10), // Adjust the space between the back arrow and logo
              // Expanded(
              //   flex: 1,
              //   child: Image.asset(
              //     'assets/logo.png',
              //     width: 50, // Adjust the size as needed
              //     height: 50, // Adjust the size as needed
              //   ),
              // ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 120,
                  backgroundImage: NetworkImage(userPhotoUrl),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$firstName $lastName',
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatPage(
                          receivedUserID: user!.uid,
                          receivedUserEmail: userEmail,
                        )
                        ),
                      );
                      },
                      icon: const Icon(Icons.message_rounded),
                    )



                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .where('user_email', isEqualTo: userEmail)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.labelStyle));
                }

                List<PostModel> posts = snapshot.data!.docs
                    .map((doc) => PostModel.fromJson(
                  doc.data() as Map<String, dynamic>,
                ))
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
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
