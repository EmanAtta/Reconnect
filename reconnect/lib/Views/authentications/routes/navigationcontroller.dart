import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/donation.dart';
import 'package:reconnect/Views/home_page.dart';
import 'package:reconnect/Views/post.dart';
import 'package:reconnect/Views/postlist.dart';

class BottomNavigationController extends GetxController {
  static BottomNavigationController get instance => Get.find();

  var selectedIndex = 0.obs;
  final List<Widget> pages = [
    MyHomePage(),
    Post(),
    PostListPage(posts: []),
    Donation(),
  ];
  final List<Map<String, dynamic>> icons = [
    {'icon': Icons.home, 'color': AppColors.primaryColor},
    {'icon': Icons.post_add, 'color': AppColors.primaryColor},
    {'icon': Icons.public_rounded, 'color': AppColors.primaryColor},
    {'icon': Icons.monetization_on_outlined, 'color': AppColors.primaryColor},
  ];
  final GlobalKey<CurvedNavigationBarState> curvedNavigationKey =
      GlobalKey<CurvedNavigationBarState>();
  int initPage = 0;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void change(index) {
    final navigationstate = curvedNavigationKey.currentState!;
    navigationstate.setPage(index);
  }
}
