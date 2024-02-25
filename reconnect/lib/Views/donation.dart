import 'package:flutter/material.dart';
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
      body: 
      Center(
        child: Text('Donation Page'),
      ),
    );
  }
}