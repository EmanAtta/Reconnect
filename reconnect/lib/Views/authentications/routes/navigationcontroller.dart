import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reconnect/Views/Chat/HomeChat.dart';
import 'package:reconnect/Views/authentications/routes/navigation.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/current_user_screen.dart';
import 'package:reconnect/Views/donation.dart';
import 'package:reconnect/Views/home_page.dart';
import 'package:reconnect/Views/post.dart';
import 'package:reconnect/Views/postlist.dart';

class BottomNavigationController extends GetxController {
  static BottomNavigationController get instance => Get.find();

  final user = FirebaseAuth.instance.currentUser;
  String? userE;

  @override
  void onInit() {
    super.onInit();
    userE = user?.email;
  }

  var selectedIndex = 0.obs;
  late final List<Widget> pages;

  BottomNavigationController() {
    pages = [
      const MyHomePage(),
      const Post(),
      const PostListPage(posts: []),
      const Donation(),
      FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserData(user?.email),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final userData = snapshot.data?.data();
            final firstName = userData?['firstname'] as String?;
            final lastName = userData?['lastname'] as String?;
            final userPhotoUrl = userData?['imageUrl'] as String?;

            return currentUsers(
              userPhotoUrl: '$userPhotoUrl',
              firstName: '$firstName',
              lastName: '$lastName',
              userEmail: '$userE',
            );
          }
        },
      ),
      const HomeChat(),
    ];
  }

  final List<Map<String, dynamic>> icons = [
    {'icon': Icons.home, 'color': AppColors.primaryColor},
    {'icon': Icons.post_add, 'color': AppColors.primaryColor},
    {'icon': Icons.public_rounded, 'color': AppColors.primaryColor},
    {'icon': Icons.monetization_on_outlined, 'color': AppColors.primaryColor},
    {'icon': Icons.person, 'color': AppColors.primaryColor},
    {'icon': Icons.chat, 'color': AppColors.primaryColor},

  ];

  final GlobalKey<CurvedNavigationBarState> curvedNavigationKey =
      GlobalKey<CurvedNavigationBarState>();

  // int initPage = 0;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void change(index) {
    final navigationstate = curvedNavigationKey.currentState!;
    navigationstate.setPage(index);
  }
}
