import 'package:flutter/material.dart';

class NavCustomPainter extends CustomPainter {
  late double loc;
  late double s;
  Color color;
  TextDirection textDirection;

  NavCustomPainter(
      double startingLoc, int itemsLength, this.color, this.textDirection) {
    final span = 1.0 / itemsLength;
    s = 0.2;
    double l = startingLoc + (span - s) / 2;
    loc = textDirection == TextDirection.rtl ? 0.8 - l : l;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo((loc - 0.1) * size.width, 0)
      ..cubicTo(
        (loc + s * 0.20) * size.width,
        size.height * 0.05,
        loc * size.width,
        size.height * 0.60,
        (loc + s * 0.50) * size.width,
        size.height * 0.60,
      )
      ..cubicTo(
        (loc + s) * size.width,
        size.height * 0.60,
        (loc + s - s * 0.20) * size.width,
        size.height * 0.05,
        (loc + s + 0.1) * size.width,
        0,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}




class CustomBottomNavBar extends StatelessWidget {
  final double height;
  const CustomBottomNavBar({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomPaint(
        size: Size(MediaQuery.of(context).size.width, 80),
        painter: BottomNavBarPainter(),
      ),
    );
  }
}

class BottomNavBarPainter extends CustomPainter {
  
  BottomNavBarPainter();
  @override

  void paint(Canvas canvas, Size size) {
  // Width of the curved notch as a fraction of total width
  final double curveWidth = 0.225;

  // Perfect horizontal center
  final double centerX = 0.5;

  // Curve start position (left edge of curve)
  final double startX = centerX - curveWidth / 2;

  final paint = Paint()
    ..color = const Color(0xFF00EFD1)
    ..style = PaintingStyle.fill;

  final path = Path()
    ..moveTo(0, 20)
    ..quadraticBezierTo(0, 0, 20, 0)
    ..lineTo(startX * size.width, 0)

    // Left curve
    ..cubicTo(
      (startX + curveWidth * 0.15) * size.width,
      size.height * 0.05,
      (startX + curveWidth * 0.25) * size.width,
      size.height * 0.55,
      centerX * size.width,
      size.height * 0.55,
    )

    // Right curve
    ..cubicTo(
      (startX + curveWidth * 0.75) * size.width,
      size.height * 0.55,
      (startX + curveWidth * 0.85) * size.width,
      size.height * 0.05,
      (startX + curveWidth) * size.width,
      0,
    )

    ..lineTo(size.width-20, 0)
    ..quadraticBezierTo(size.width, 0, size.width, 20)
    ..lineTo(size.width, size.height)
    ..lineTo(0, size.height)
    ..close();

  canvas.drawPath(path, paint);
}


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
