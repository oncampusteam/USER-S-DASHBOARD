import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: ClipPath(
//             clipper: BellCurveClipper(),
//             child: Container(
//               width: 320,
//               height: 50,
//               color: Colors.blue,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double radius = 40.h;
    path.moveTo(0, 0);
    // path.lineTo(size.width, 0);
    // path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    // Starting point for the semicircle in the middle
    path.lineTo(size.width / 2 + radius, size.height/20);
    path.arcToPoint(
      Offset(size.width / 2 - radius, size.height/20),
      radius: Radius.circular(radius),
      // clockwise: false,
    );
    // path.lineTo(0, size.height);
    // path.lineTo(size.width, size.height);
    // path.lineTo(size.width, 0);
    // path.lineTo(50, 0);
    // path.cubicTo(56, 12, 60, 15, 50, 20);
    // path.cubicTo(24, 10, 15, 10, 40, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
