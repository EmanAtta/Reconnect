import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reconnect/Views/change_password.dart';

import 'package:reconnect/delete1.dart';

import 'color.dart';

class settings extends StatelessWidget {
  const settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: const Text(
          'Settings',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.primaryColor),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.keyboard_arrow_left,
              color: AppColors.primaryColor),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  'Account Settings',
                  style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              height: 10,
            ),
           /* InkWell(
              onTap: () {
                Get.to(() => Edit());
              },
              child: const button_settingpage(
                button_settingpage_text: "Edit Profile",
                icon: Icons.border_color_outlined,
              ),
            ),
            SizedBox(
              height: 20,
            ),*/
            InkWell(
              onTap: () {
                Get.to(const Change_Password());
              },
              child: const button_settingpage(
                button_settingpage_text: "Change Password",
                icon: Icons.password_outlined,
              ),
            ),
            InkWell(
              onTap: () {
                _showDeleteAccountDialog(context);
              },
              child: const button_settingpage(
                button_settingpage_text: "Delete account",
                icon: Icons.delete,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const button_settingpage(
              button_settingpage_text: 'Notification',
              icon: Icons.notifications,
            ),
            const SizedBox(
              height: 20,
            ),
            const button_settingpage(
              button_settingpage_text: 'Dark Mode',
              icon: Icons.bedtime,
            ),
          ],
        ),
      ),
    );
  }
}

class button_settingpage extends StatefulWidget {
  final String button_settingpage_text;
  final IconData icon;

  const button_settingpage(
      {super.key, required this.button_settingpage_text, required this.icon});

  @override
  State<button_settingpage> createState() => _button_settingpageState();
}

class _button_settingpageState extends State<button_settingpage> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        height: 60,
        width: 300,
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 1, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    widget.icon,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.button_settingpage_text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              // if (widget.button_settingpage_text == 'Notification' ||
              //     widget.button_settingpage_text == 'Dark Mode')
              //   Switch(
              //     activeColor: AppColors.primaryColor,
              //     value: switchValue,
              //     onChanged: (value) {
              //       setState(() {
              //         switchValue = value;
              //       });
              //       // Add logic for handling switch state change here
              //     },
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showDeleteAccountDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.secondaryColor, width: 3),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.delete, size: 50, color: Colors.red),
              const SizedBox(height: 16),
              const Text("Are you sure you want to delete your account?",
                  textAlign: TextAlign.center),
              const SizedBox(height: 16),
              const Text("This action cannot be undone.",
                  textAlign: TextAlign.center),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.to(const Delete1());
                      // Navigator.of(context).pop();
                      // Call your delete account function
                    },
                    child: const Text(
                      "Delete",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

