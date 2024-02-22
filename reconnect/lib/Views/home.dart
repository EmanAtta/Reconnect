// import 'package:flutter/material.dart';

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF1E4D4),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF233F41),
//         title: const Text(
//           'Reconnect',
//           style:
//               TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE9D6BF)),
//         ),
//         elevation: 40,
//         shadowColor: Colors.black,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.keyboard_arrow_left, color: Color(0xFFE9D6BF)),
//         ),
//       ),
//       endDrawer: Drawer(
//         child: Container(
//           padding: const EdgeInsets.only(top: 40),
//           color: const Color(0xFF233F41),
//           child: Column(
//             children: [
//               ListTile(
//                 leading: const Icon(
//                   Icons.person,
//                   color: Color(0xFFE9D6BF),
//                 ),
//                 title: const Text(
//                   'Profile',
//                   style: TextStyle(
//                     color: Color(0xFFE9D6BF),
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pushNamed(context, 'profile');
//                 },
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.settings,
//                   color: Color(0xFFE9D6BF),
//                 ),
//                 title: const Text(
//                   'Setings',
//                   style: TextStyle(
//                     color: Color(0xFFE9D6BF),
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pushNamed(context, 'settings');
//                 },
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.privacy_tip_outlined,
//                   color: Color(0xFFE9D6BF),
//                 ),
//                 title: const Text(
//                   'Privacy',
//                   style: TextStyle(
//                     color: Color(0xFFE9D6BF),
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pushNamed(context, 'privacy');
//                 },
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.report_gmailerrorred_rounded,
//                   color: Color(0xFFE9D6BF),
//                 ),
//                 title: const Text(
//                   'About',
//                   style: TextStyle(
//                     color: Color(0xFFE9D6BF),
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pushNamed(context, 'about');
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1E4D4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF233F41),
        title: const Text(
          'Reconnect',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE9D6BF)),
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
          child: Stack(
            children: [
              Column(
                children: [
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
                      'Settings',
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
                  const SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.report_gmailerrorred_rounded,
                      color: Color(0xFFE9D6BF),
                    ),
                    title: const Text(
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
              Positioned(
                bottom: 0,
                right: 0,
                child: CustomPaint(
                  painter: RoundedTrianglePainter(),
                  size: const Size(100, 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFFF1E4D4)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(size.width, size.height);
    path.lineTo(size.width, size.height - 150);
    path.lineTo(size.width - 310, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - 20);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

