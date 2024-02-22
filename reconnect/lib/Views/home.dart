import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1E4D4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF233F41),
        title: const Text(
          'Reconnect',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE9D6BF)),
        ),
        elevation: 40,
        shadowColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left, color: Color(0xFFE9D6BF)),
        ),
      ),
      endDrawer: Drawer(
        child: Container(
          padding: const EdgeInsets.only(top: 40),
          color: const Color(0xFF233F41),
          child: Column(
            children: [
              const SizedBox(
                height: 150,
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
                  'Setings',
                  style: TextStyle(
                    color: Color(0xFFE9D6BF),
                  ),
                ),
                onTap: () {
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
                  Navigator.pushNamed(context, 'privacy');
                },
              ),
              SizedBox(
                height: 15,
              ),
              ListTile(
                leading: Icon(
                  Icons.report_gmailerrorred_rounded,
                  color: Color(0xFFE9D6BF),
                ),
                title: Text(
                  'About',
                  style: TextStyle(
                    color: Color(0xFFE9D6BF),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'about');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
