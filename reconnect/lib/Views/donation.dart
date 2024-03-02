import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:reconnect/Views/color.dart';

class Donation extends StatefulWidget {
  const Donation({super.key});

  @override
  State<Donation> createState() => _DonationState();
}

class _DonationState extends State<Donation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: const Image(
                image: AssetImage("assets/donation.jpg"),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              margin: EdgeInsets.only(right: 10, left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.secondaryColor),
              ),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                    child: Text(
                      'About',
                      style: TextStyle(color: AppColors.textolor, fontSize: 16),
                    ),
                  ),
                  TextField(
                    cursorColor: AppColors.secondaryColor,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(
                          16, 30, 16, 16), // Adjust padding as needed
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              height: 190,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.secondaryColor),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 20, left: 10, bottom: 10, right: 60),
                          child: Container(
                            height: 43,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.secondaryColor),
                                  borderRadius: BorderRadius.circular(20)
                            ),
                            child: Container(
                              height: 20,
                              padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
                              child: TextFormField(
                                cursorColor: AppColors.secondaryColor,
                                decoration: InputDecoration(
                                  hintText: 'Name',
                                  hintStyle: TextStyle(
                                      color: AppColors.textolor, fontSize: 15),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 2, bottom: 3, left: 10, right: 60),
                          child: Container(
                            height: 43,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.secondaryColor),
                                   borderRadius: BorderRadius.circular(20)
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5, 20, 3, 3),
                              child: TextFormField(
                                cursorColor: AppColors.secondaryColor,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      color: AppColors.textolor, fontSize: 15),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 10, left: 10, bottom: 10, right: 150),
                          child: Container(
                            height: 43,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.secondaryColor),
                                   borderRadius: BorderRadius.circular(20)
                            ),
                            child: Container(
                              height: 20,
                              padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
                              child: TextFormField(
                                cursorColor: AppColors.secondaryColor,
                                decoration: InputDecoration(
                                  hintText: 'Amount',
                                  hintStyle: TextStyle(
                                      color: AppColors.textolor, fontSize: 15),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'pay');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors
                    .secondaryColor, // Change color to your desired color
                maximumSize:
                    Size(230, 60), // Set width and height to increase size
              ),
              child: Text(
                'Donate now',
                style: TextStyle(
                    fontSize: 17,
                    color:
                        AppColors.primaryColor), // Adjust font size as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
