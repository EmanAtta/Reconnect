import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/donation.dart';
import 'package:reconnect/Views/post.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    Post(),
    const Donation(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: const Text(
          'Reconnect',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.primaryColor),
        ),
        
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left,
              color: AppColors.primaryColor),
        ),
      ),
      endDrawer: Drawer(
        child: Container(
          padding: const EdgeInsets.only(top: 0),
          color: AppColors.secondaryColor,
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
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'profile');
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
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'settings');
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
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'privacy');
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
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'about');
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
                            Navigator.pushNamed(context, 'welcome');
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
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.secondaryColor,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: AppColors.primaryColor,
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.public,
              color: AppColors.primaryColor,
            ),
            label: 'Post',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.money,
              color: AppColors.primaryColor,
            ),
            label: 'Donation',
          ),
        ],
        selectedItemColor: AppColors.primaryColor, // Color of the selected item
        unselectedItemColor:
            AppColors.primaryColor, // Color of unselected items
        showUnselectedLabels:
            true, // Set to true if you want to show labels on unselected items
        type: BottomNavigationBarType.fixed,
        selectedIconTheme:
            const IconThemeData(size: 50, color: AppColors.primaryColor),
        unselectedIconTheme:
            const IconThemeData(size: 25, color: AppColors.primaryColor),
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height - 90);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Content'),
    );
  }
}
