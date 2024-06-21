import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reconnect/Views/color.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: const Text(
          'About',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.keyboard_arrow_left,
            color: AppColors.primaryColor,
          ),
        ),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: Column(
        
        children: [
          
          Center(child: CircleAvatar(backgroundImage:AssetImage('assets/logo.png') ,radius: 60,backgroundColor: Colors.transparent,)),
           Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0,top: 20), // Adjust padding as needed
              child: const Text(
                "developed by:",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: AppColors.secondaryColor),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10
            ),
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                
                AvatarWithText(
                  imagePath: 'assets/z.png',
                  text: 'Zeyad gomaa',
                ),
                SizedBox(width: 10),
                AvatarWithText(
                  imagePath: 'assets/e.png',
                  text: 'Eslam Nour El-Den',
                ),
                SizedBox(width: 10),
                AvatarWithText(
                  imagePath: 'assets/n.png',
                  text: 'Nada Awad',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
               
                SizedBox(width: 10),
                AvatarWithText(
                  imagePath: 'assets/s.png',
                  text: 'Sahar Ibrahim',
                ),
                SizedBox(width: 10),
               
                 AvatarWithText(
                  imagePath: 'assets/em.png',
                  text: 'Eman Ata',
                ),
                 AvatarWithText(
                  imagePath: 'assets/r.png',
                  text: 'Roqaia Mohamed',
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0,bottom: 10), // Adjust padding as needed
              child: const Text(
                "About",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: AppColors.secondaryColor),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0), // Adjust padding as needed
              child: const Text(
                "Reconnect is AI application to modify images based on age. It allows sharing modified images on social media and contains a special section for donating to DNA testing  ",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AvatarWithText extends StatelessWidget {
  final String imagePath;
  final String text;

  const AvatarWithText({
    Key? key,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(imagePath),
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: const TextStyle(color: Colors.black,fontSize: 12), // Change text color to black
        ),
      ],
    );
  }
}
