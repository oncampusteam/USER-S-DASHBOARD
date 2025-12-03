import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen1 extends StatefulWidget {
  const WelcomeScreen1({super.key});

  @override
  State<WelcomeScreen1> createState() => _WelcomeScreen1State();
}

class _WelcomeScreen1State extends State<WelcomeScreen1> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
          child: SizedBox(
        child: Stack(
          children: [
            Image.asset(
              "assets/welcome_screen_1/welcomeImage_1.jpg",
              fit: BoxFit.cover,
              height: double.infinity,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              top: 450.h,
              child: SizedBox(
                // height: 100.h,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      // height: 40.h,
                      // color: Colors.red,
                      width: double.infinity,
                      child: Expanded(
                        child: Text(
                          "Stress-Free Student Living",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            letterSpacing: 0.15.w,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                            fontSize: 35.sp.clamp(0, 35),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                          "Book in flash, save your cash! find the perfect\n spot without hassle",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            letterSpacing: 0.15.w,
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            fontSize: 18.sp.clamp(0, 18),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    ));
  }
}
