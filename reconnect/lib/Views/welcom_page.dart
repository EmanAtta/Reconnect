import 'package:flutter/material.dart';

class WelcomPage extends StatelessWidget {
  const WelcomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF233F41),
        body: Column(children: [
          ClipPath(
            clipper: DiagonalClipper(),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFE9D6BF),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(4)),
              ),
              height: 110,
              width: double.infinity,
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
    path.lineTo(size.width, size.height - 80);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
