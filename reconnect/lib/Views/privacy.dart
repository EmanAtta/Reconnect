import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reconnect/Views/color.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: const Text('Privacy Policy',
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.keyboard_arrow_left, color: AppColors.primaryColor),
        ),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add padding for better readability
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              const Text(
                'Privacy Policy for Reconnect Application',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const Center(child: Text('Introduction:')),
              const Text(
                'Welcome to Reconnect, your secure communication and social networking platform. At Reconnect, we prioritize your privacy and are committed to safeguarding your personal information. This Privacy Policy outlines how we collect, use, disclose, and protect your information when you use our application.',
              ),
              const SizedBox(height: 10.0),
              const Text('Information We Collect:', style: TextStyle(fontWeight: FontWeight.bold)),
              const Text(
                '1. Personal Information:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                '- Account Information: When you create an account, we collect your username, email address, and password. We use this information to authenticate you, provide access to our services, and communicate with you.',
              ),
              const Text(
                '- Profile Information: You may optionally provide additional information, such as a profile picture, bio, and other personal details. This information helps you personalize your profile and connect with others on the platform.',
              ),
              const SizedBox(height: 10.0),
              const Text('2. Communication Data:', style: TextStyle(fontWeight: FontWeight.bold)),
              const Text(
                '- Chats: We collect and store messages you send and receive within the app, but these messages are end-to-end encrypted, ensuring only you and the recipient can read them. We do not store the decrypted content of your chats.',
              ),
              const Text(
                '- Images: Images shared in chats are securely stored and transmitted using encryption. We do not use these images for any purposes other than facilitating your communication.',
              ),
              const SizedBox(height: 10.0),
              const Text('3. Donation Data:', style: TextStyle(fontWeight: FontWeight.bold)),
              const Text(
                '- Transaction Information: If you make or receive donations, we collect information related to the transaction, such as the amount and the payment method used. However, your financial information is securely processed by our payment gateway and is not stored on our servers.',
              ),
              const SizedBox(height: 10.0),
              const Text('4. Profile Management:', style: TextStyle(fontWeight: FontWeight.bold)),
              const Text(
                '- Profile Updates: Any changes you make to your profile, such as updating your bio or profile picture, are collected and stored securely to reflect your preferences.',
              ),
              const Text(
                '- Password Resets: When you request a password reset, we collect and process the necessary information to verify your identity and reset your password securely.',
              ),
              const SizedBox(height: 10.0),
              const Text('5. Search Data:', style: TextStyle(fontWeight: FontWeight.bold)),
              const Text(
                '- Photo Search: When you use the photo search feature, we collect and temporarily store the image to perform the search. This information is not retained after the search is complete.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
