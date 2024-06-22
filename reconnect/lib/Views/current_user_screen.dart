import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reconnect/Views/color.dart';

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

class currentUsers extends StatefulWidget {
  final String userPhotoUrl;
  final String firstName;
  final String lastName;
  final String userEmail;

  const currentUsers({
    Key? key,
    required this.userPhotoUrl,
    required this.firstName,
    required this.lastName,
    required this.userEmail,
  }) : super(key: key);

  @override
  _currentUsersState createState() => _currentUsersState();
}

class _currentUsersState extends State<currentUsers> {
  Future<void> _deletePost(String postId) async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete Post'),
            content: const Text('Are you sure you want to delete this post?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('posts')
                      .doc(postId)
                      .delete();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Post deleted successfully.'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Delete'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting post: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
            pinned: true,
            floating: true,
            expandedHeight: 200.0,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                double appBarSize = constraints.biggest.height;
                return FlexibleSpaceBar(
                  background: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: appBarSize * 0.6,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(widget.userPhotoUrl),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          '${widget.firstName} ${widget.lastName}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .where('user_email', isEqualTo: widget.userEmail)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator(color: AppColors.labelStyle));
                }

                List<PostModel> posts = snapshot.data!.docs
                    .map((doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
                    .toList();

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 8,
                      shadowColor: AppColors.primaryColor,
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(posts[index].userP ?? ''),
                                    ),
                                    const SizedBox(width: 8.0),
                                    GestureDetector(
                                      onTap: () {},
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
                                              text: '${posts[index].postDate}    |    ${posts[index].postTime}',
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
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: AppColors.secondaryColor,
                                  onPressed: () {
                                    _deletePost(snapshot.data!.docs[index].id);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            SizedBox(
                              width: double.infinity,
                              height: 200,
                              child: posts[index].image_url != null && posts[index].image_url!.isNotEmpty
                                  ? Image.network(
                                      posts[index].image_url!,
                                      fit: BoxFit.cover,
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
