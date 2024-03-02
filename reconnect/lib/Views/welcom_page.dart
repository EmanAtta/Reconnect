import 'package:flutter/material.dart';
import 'package:reconnect/Views/color.dart';

class WelcomPage extends StatelessWidget {
  const WelcomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.secondaryColor,
        body: Stack(fit: StackFit.expand, children: [
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
          Center(
              child: Row(
            children: [
              Container(
                  width: 150,
                  child: Image(image: AssetImage("assets/logo.png"))),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Reconnect',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              )
            ],
          )),
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
                        Navigator.pushNamed(context, 'login');
                      },
                      child: const Text(
                        'Get started',
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
        ]),
      ),
    );
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
