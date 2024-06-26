import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reconnect/Views/about.dart';
import 'package:reconnect/Views/autentication.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/login.dart';
import 'package:reconnect/Views/privacy.dart';
import 'package:reconnect/Views/profile.dart';
import 'package:reconnect/Views/settings.dart';
import 'package:reconnect/Views/welcom_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Delete1 extends StatefulWidget {
  const Delete1({super.key});

  @override
  State<Delete1> createState() => _Delete1State();
}

class _Delete1State extends State<Delete1> {
  final email = TextEditingController();
final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        // toolbarHeight: 35,
        backgroundColor: AppColors.secondaryColor,

        title: const Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Text(
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
                        Icons.settings,
                        color: AppColors.primaryColor,
                      ),
                      title: const Text(
                        'Settings',
                        style: TextStyle(
                            color: AppColors.primaryColor, fontSize: 20),
                      ),
                      onTap: () {
                        Get.to(() => const settings());
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
                              Get.to(() => const login());
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/delete.svg',
                height: 300,
              ),
            ),
            const Center(
              child: Text(
                'Delete your account',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w300,
                    color: AppColors.secondaryColor),
              ),
            ),
            const Center(
              child: Text(
                'You will lose all of your data by deleting \n            your account this action \n                     cannt be undo',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 40, right: 40),
              child: TextFormField(
                controller: email,
                cursorColor: AppColors.secondaryColor,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: const TextStyle(
                      fontSize: 15, color: AppColors.secondaryColor),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.textolor),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.textolor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 40, right: 40,top: 40),
              child: TextFormField(
                controller: password,
                cursorColor: AppColors.secondaryColor,
                decoration: InputDecoration(
                  labelText: "password",
                  labelStyle: const TextStyle(
                      fontSize: 15, color: AppColors.secondaryColor),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.textolor),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.textolor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomRedButton(
              buttonText: 'Delete account',
              onPressed: () {
                Authentication.instance.deleteUserByEmail(email.text.trim(),password.text.trim());
                
              },
              buttonColor: Colors.red.withOpacity(0.3),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomRedButton(
              
              buttonText: '       Cancel       ',
              onPressed: () {
                Navigator.of(context).pop();
              },
              buttonColor: Colors.grey.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final Color buttonColor;
  

  const CustomRedButton({super.key, 
    required this.buttonText,
    required this.onPressed,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
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
