import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";


typedef GestureTapCallback = void Function();
Widget bottomIndicator({
  double height = 0,
  double screenWidth = 0,
  int containerToColor = 0,
  double percentageToColor = 0,
  GestureTapCallback? handleNextTap,
  GestureTapCallback? handleBackTap,
  required bool proceed,
  String text = "Next"
}) {
  double width = screenWidth * 0.3265;
  return Container(
      color: Colors.white,
      height: height,
      width: screenWidth,
      child: Column(
        children: [
          SizedBox(
              height: 5.h,
              child: Row(
                children: [
                  SizedBox(
                    height: 5.h,
                    width: width,
                    child: SizedBox(
                        height: 5.h,
                        width: width,
                        child: Stack(
                          children: [
                            Container(
                                color: const Color(0XFFB0B0B0),
                                height: 5.h,
                                width: screenWidth * 0.323,
                                child: const Placeholder(
                                    color: Colors.transparent)),
                            Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF00EFD1),
                                      borderRadius: BorderRadius.circular(
                                        containerToColor == 1 ||
                                            containerToColor == 2 ||
                                            containerToColor == 3 ? 0 : 12.r
                                      )
                                    ),
                                    height: 5.h,
                                    width: containerToColor == 1 ||
                                            containerToColor == 2 ||
                                            containerToColor == 3
                                        ? width
                                        : (width) * percentageToColor,
                                    
                                    )
                                    ),
                          ],
                        )),
                  ),

                  ///////////////////////////////////
                  SizedBox(height: 5.h, width: screenWidth * 0.01),
                  //////////////////////////////////

                  SizedBox(
                    height: 5.h,
                    width: width,
                    child: SizedBox(
                        height: 5.h,
                        width: width,
                        child: Stack(
                          children: [
                            Container(
                                color: const Color(0XFFB0B0B0),
                                height: 5.h,
                                width: screenWidth * 0.323,
                                child: const Placeholder(
                                    color: Colors.transparent)),
                            Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF00EFD1),
                                      borderRadius: BorderRadius.circular(
                                        containerToColor == 2 ||
                                            containerToColor == 3 ? 0: 12.r
                                      )
                                    ),
                                    height: 5.h,
                                    width: containerToColor == 2 ||
                                            containerToColor == 3
                                        ? width
                                        : containerToColor == 0
                                            ? 0
                                            : (width) * percentageToColor,
                                    )),
                          ],
                        )),
                  ),

                  ///////////////////////////////////
                  SizedBox(height: 5.h, width: screenWidth * 0.01),
                  //////////////////////////////////

                  SizedBox(
                    height: 5.h,
                    width: width,
                    child: SizedBox(
                        height: 5.h,
                        width: width,
                        child: Stack(
                          children: [
                            Container(
                                color: const Color(0XFFB0B0B0),
                                height: 5.h,
                                width: width,
                                child: const Placeholder(
                                    color: Colors.transparent)),
                            Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF00EFD1),
                                      borderRadius: BorderRadius.circular(containerToColor == 2 ? 12.r: 0),
                                    ),
                                    height: 5.h,
                                    width: containerToColor == 3
                                        ? width
                                        : containerToColor == 0 ||
                                                containerToColor == 1
                                            ? 0
                                            : (width) * percentageToColor,
                                    )),
                          ],
                        )),
                  )
                ],
              )),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 35.h),
                  child: Align(
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  GestureDetector(
                    onTap: handleBackTap,
                    child: Container(
                      height: 30.h,
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black))
                      ),
                      child: FittedBox(
                        child: Text(
                          "Back",
                          style: TextStyle(
                            fontFamily: "Segoe UI",
                            fontSize: 24.sp,
                            height: 1.3.h,
                            letterSpacing: 24.sp * 0.02,
                          )
                          ),
                      ),
                      ),
                  ),
                    GestureDetector(
                      onTap: proceed?handleNextTap:(){},
                      child: Container(
                        height: 50.h,
                        width: 120.w,
                        padding: EdgeInsets.all(14.h),
                        decoration: BoxDecoration(
                          color: proceed?const Color(0xFF00EFD1): const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: FittedBox(
                          child: Text(
                            text,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                                        
                            )
                            )
                        )
                      ),
                    )
                                ],),),
                ))
        ],
      ));
}


class Bottom_Nav extends StatefulWidget {
  const Bottom_Nav({super.key});

  @override
  State<Bottom_Nav> createState() => _BottomNavState();
}

class _BottomNavState extends State<Bottom_Nav> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80, 
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width,80),
            painter: BottomNavPainter()
          )
        ],
      )
      );
  }
}

class BottomNavPainter extends CustomPainter{
  @override

  void paint(Canvas canvas, Size size) {
  double w = size.width;

  Paint paint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;

  Path path = Path()
    ..moveTo(w * 0.34, 0)
    ..quadraticBezierTo(w * 0.43, 0, w * 0.45, 10) // Left curve
    ..arcToPoint(
      Offset(w * 0.55, 10), // End point of arc
      radius: const Radius.circular(3.0),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
      clockwise: false,
    )
    ..quadraticBezierTo(w * 0.59, 0, w * 0.70, 0); // Right curve

  canvas.drawPath(path, paint);
}
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final double height;
  final int dip;
  const CustomBottomNavBar({super.key, required this.height, required this.dip});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomPaint(
        size: Size(MediaQuery.of(context).size.width, 80),
        painter: BottomNavBarPainter(dip: dip),
      ),
    );
  }
}

class BottomNavBarPainter extends CustomPainter {
  final int dip;
  const BottomNavBarPainter({required this.dip});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00EFD1)// same color as your image
      ..style = PaintingStyle.fill;

    final path = Path();

    // Start from bottom-left corner
    path.moveTo(0, 0);

    // Top-left corner rounded
    path.quadraticBezierTo(0, 0, 20, 0);

    // Straight line until curve starts
    path.lineTo(size.width * 0.35, 0);

    // Left curve down
    path.quadraticBezierTo(
      size.width * 0.40, 0, // control point
      size.width * 0.42, 20, // curve down
    );

    // Bottom semi-circle dip
    path.quadraticBezierTo(
      size.width * 0.50, dip.toDouble(), // deep middle
      size.width * 0.58, 20, // curve back up
    );

    // Right curve up
    path.quadraticBezierTo(
      size.width * 0.60, 0, // control point
      size.width * 0.65, 0, // join back to top line
    );

    // Continue to top-right
    path.lineTo(size.width - 20, 0);

    // Rounded top-right corner
    path.quadraticBezierTo(size.width, 0, size.width, 20);

    // Go down to bottom-right
    path.lineTo(size.width, size.height);

    // Go bottom-left
    path.lineTo(0, size.height);

    // Close the shape
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}