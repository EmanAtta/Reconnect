import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'color.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: Text(
          'Settings',
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
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 70, left: 30),
              child: Text(
                'Account Settings',
                style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              )),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "EditProfile");
            },
            child: const button(
              button_text: "Edit Profile",
              icon: Icons.border_color_outlined,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "forgetBassword");
            },
            child: const button(
              button_text: "Change Password",
              icon: Icons.password_outlined,
            ),
          ),
          const button(
            button_text: 'Notification',
            icon: Icons.notifications,
          ),
          SizedBox(
            height: 20,
          ),
          const button(
            button_text: 'Dark Mode',
            icon: Icons.bedtime,
          ),
        ],
      ),
    );
  }
}

class button extends StatefulWidget {
  final String button_text;
  final IconData icon; // Add an icon parameter

  const button({Key? key, required this.button_text, required this.icon})
      : super(key: key);

  @override
  State<button> createState() => _buttonState();
}

class _buttonState extends State<button> {
  bool switchValue = false; // Add a boolean variable to store switch state

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 30),
      child: Container(
        height: 60,
        width: 300,
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color.fromARGB(255, 27, 144, 124)),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 1, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    widget.icon,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(width: 10), // Adjust spacing between icon and text
                  Text(
                    widget.button_text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              if (widget.button_text == 'Notification' ||
                  widget.button_text == 'Dark Mode')
                Switch(
                  activeColor: AppColors.primaryColor,
                  value: switchValue,
                  onChanged: (value) {
                    setState(() {
                      switchValue = value;
                    });
                    // Add logic for handling switch state change here
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}