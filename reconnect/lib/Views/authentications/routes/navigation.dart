import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reconnect/Views/Chat/HomeChat.dart';
import 'package:reconnect/Views/about.dart';
import 'package:reconnect/Views/authentications/routes/navigationcontroller.dart';
import 'package:reconnect/Views/change_password.dart';
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
import 'package:reconnect/Views/search.dart';
import 'package:reconnect/delete1.dart';




class Navigationpage extends StatefulWidget {
  const Navigationpage({super.key});

  @override
  State<Navigationpage> createState() => _NavigationpageState();
}



class _NavigationpageState extends State<Navigationpage> {
  BottomNavigationController bottomnavigationcontroller =
  Get.put(BottomNavigationController());
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    String? userE = user?.email;

    final screens = [
      const MyHomePage(),
      //const Post(),
      const PostListPage(posts: []),
      const Donation(),
      FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getUserData(user?.email),
          builder: (context, snapshot) {
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
          }),
      const HomeChat(),

    ];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
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
          child: Container(
            child: Image.asset(
              'assets/logo.png',
              width: 50,
              height: 50,
            ),
          ),
        ),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.search,
                color: AppColors.primaryColor,
              ),
              onPressed: () {
                // Navigate to SearchPage
                Get.to(() => const SearchPage());
              },
            ),
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: Opacity(
        opacity: 0.9,
        child: Drawer(
          width: 250,
          backgroundColor: AppColors.secondaryColor,
          child: Container(
            padding: const EdgeInsets.only(top: 0),
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
                    const SizedBox(
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
                        Get.to(() => const profile());
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.change_circle,
                        color: AppColors.primaryColor,
                      ),
                      title: const Text(
                        'change password',
                        style: TextStyle(
                            color: AppColors.primaryColor, fontSize: 20),
                      ),
                      onTap: () {
                        Get.to(() => const Change_Password());
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.delete,
                        color: AppColors.primaryColor,
                      ),
                      title: const Text(
                        'delet account',
                        style: TextStyle(
                            color: AppColors.primaryColor, fontSize: 20),
                      ),
                      onTap: () {
                        Get.to(() => const Delete1());
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
                        Get.to(() => const Privacy());
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
                        Get.to(() => const About());
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
                              Get.offAll(() => const login());
                            },
                            child: const Text(
                              'Sign Out',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondaryColor,
                                fontSize: 20,
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
      body: GetX<BottomNavigationController>(
        builder: (controller) {
          return controller.pages[controller.selectedIndex.value];
        },
      ),
      bottomNavigationBar: GetBuilder<BottomNavigationController>(
        builder: (controller) {
          return CurvedNavigationBar(
            animationCurve: Curves.fastOutSlowIn,
            height: 60,
            backgroundColor: AppColors.primaryColor,
            color: AppColors.secondaryColor,
            key: controller.curvedNavigationKey,
            index: controller.selectedIndex.value,
            onTap: (index) => controller.changeIndex(index),
            items: List.generate(
              controller.icons.length,
                  (index) {
                IconData icon = controller.icons[index]['icon'];
                Color color = controller.icons[index]['color'];
                return Icon(icon, color: color);
              },
            ),
          );
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
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    throw UnimplementedError();
  }
}