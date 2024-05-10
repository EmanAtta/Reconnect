import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:reconnect/Views/about.dart';
import 'package:reconnect/Views/authentications/routes/navigationcontroller.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/donation.dart';
import 'package:reconnect/Views/login.dart';
import 'package:reconnect/Views/post.dart';
import 'package:reconnect/Views/postlist.dart';
import 'package:reconnect/Views/home_page.dart';
import 'package:reconnect/Views/privacy.dart';
import 'package:reconnect/Views/profile.dart';
import 'package:reconnect/Views/settings.dart';
import 'package:reconnect/Views/welcom_page.dart';
import 'package:reconnect/Views/current_user_screen.dart';




class Navigationpage extends StatelessWidget {
  Bottomnavigationcontroller bottomnavigationcontroller =
      Get.put(Bottomnavigationcontroller());
  Navigationpage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;
    String? userE = user?.email;

    final screens = [
      MyHomePage(),
      Post(),
      PostListPage(posts: []),
      Donation(),
      FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserData(user?.email),
        builder: (context, snapshot) {
            final userData = snapshot.data?.data();
            final firstName = userData?['firstname'] as String?;
            final lastName = userData?['lastname'] as String?;
            final userPhotoUrl = userData?['imageUrl'] as String?;

            return currentUsers(
              userPhotoUrl: '${userPhotoUrl}',
              firstName: '${firstName}',
              lastName: '${lastName}',
              userEmail: '${userE}',
            );
          }
      ),
    ];



    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 35,
        backgroundColor: AppColors.secondaryColor,

        title: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: const Text(
            'Reconnect',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.primaryColor),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.keyboard_arrow_left,
                color: AppColors.primaryColor),
          ),
        ),
      ),
      endDrawer: Opacity(
        opacity: 0.9,
        child: Drawer(
          width: 250,
          backgroundColor: AppColors.secondaryColor,
          child: Container(
            padding: const EdgeInsets.only(top: 0),
            //color: AppColors.secondaryColor,

            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ClipPath(
                    clipper: DiagonalClipper(),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(4)),
                      ),
                      height: 100,
                      width: double.infinity,
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 215,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: AppColors.primaryColor,
                      ),
                      title: const Text(
                        'Profile',
                        style: TextStyle(
                            color: AppColors.primaryColor, fontSize: 20),
                      ),
                      onTap: () {
                        Get.to(() => profile());
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.settings,
                        color: AppColors.primaryColor,
                      ),
                      title: const Text(
                        'Settings',
                        style: TextStyle(
                            color: AppColors.primaryColor, fontSize: 20),
                      ),
                      onTap: () {
                        Get.to(() => settings());
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.privacy_tip_outlined,
                        color: AppColors.primaryColor,
                      ),
                      title: const Text(
                        'Privacy',
                        style: TextStyle(
                            color: AppColors.primaryColor, fontSize: 20),
                      ),
                      onTap: () {
                        Get.to(() => Privacy());
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.report_gmailerrorred_rounded,
                        color: AppColors.primaryColor,
                      ),
                      title: const Text(
                        'About',
                        style: TextStyle(
                            color: AppColors.primaryColor, fontSize: 20),
                      ),
                      onTap: () {
                        Get.to(() => About());
                      },
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipPath(
                    clipper: BottomDiagonalClipper(),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                      ),
                      height: 100,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30, bottom: 15),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => login());
                            },
                            child: const Text(
                              'Sign Out',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondaryColor,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(
        () => IndexedStack(
          index: bottomnavigationcontroller.selectedIndex.value,
          children: screens,
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.fastOutSlowIn,
        height: 60,
        index: bottomnavigationcontroller.selectedIndex.value,
        backgroundColor: Color(0xFFFFE8D6),
        color: Color(0xFF4A563E),
        items: [
          Icon(
            Icons.face,
            color: AppColors.primaryColor,
          ),
          Icon(
            Icons.post_add,
            color: AppColors.primaryColor,
          ),
          Icon(
            Icons.public_rounded,
            color: AppColors.primaryColor,
          ),
          Icon(
            Icons.monetization_on_outlined,
            color: AppColors.primaryColor,
          ),
          Icon(
            Icons.account_circle,
            color: AppColors.primaryColor,
          ),
        ],
        onTap: (index) {
          bottomnavigationcontroller.changeIndex(index);
        },
      ),
    );
  }
}

Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String? userEmail) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: userEmail)
      .get();

  final userDoc = querySnapshot.docs.first;

  final userId = userDoc.id;

  final userSnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .get();

  return userSnapshot;
}

class BottomDiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
