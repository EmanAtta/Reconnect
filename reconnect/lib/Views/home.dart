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
      backgroundColor: const Color(0xFFF1E4D4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF233F41),
        title: const Text(
          'Reconnect',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.primaryColor),
        ),
        elevation: 40,
        shadowColor: Colors.black,
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
          padding: const EdgeInsets.only(top: 40),
          color: const Color(0xFF233F41),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 130,

                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: Color(0xFFE9D6BF),
                    ),
                    title: const Text(
                      'Profile',
                      style: TextStyle(
                        color: Color(0xFFE9D6BF),
                      ),
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
                      color: Color(0xFFE9D6BF),
                    ),
                    title: const Text(
                      'Settings',
                      style: TextStyle(
                        color: Color(0xFFE9D6BF),
                      ),
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
                      color: Color(0xFFE9D6BF),
                    ),
                    title: const Text(
                      'Privacy',
                      style: TextStyle(
                        color: Color(0xFFE9D6BF),
                      ),
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
                        color: Color(0xFFE9D6BF),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'about');
                    },
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CustomPaint(
                  painter: RoundedTrianglePainter(),
                  size: const Size(100, 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 640, left: 130),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'login');
                      },
                      icon: const Padding(
                        padding: EdgeInsets.only(),
                        child: Icon(
                          Icons.exit_to_app_sharp,
                          size: 25,
                          color: AppColors.textolor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'login');
                      },
                      child: const Text(
                        'Sign Out',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textolor,
                          fontSize: 21,
                        ),
                      ),
                    ),
                  ],
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

class RoundedTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.primaryColor
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(size.width, size.height);

    path.lineTo(size.width, -120); // Draw a straight line to the top
    path.lineTo(size.width - 300, 30); // Adjust the value as needed
    // Adjust the value as needed
    path.quadraticBezierTo(size.width, 40, size.width, 30);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Content'),
    );
  }
}
