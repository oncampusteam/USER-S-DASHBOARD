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
    Size constant = MediaQuery.of(context).size;
    return Material(
      child: Scaffold(
        extendBodyBehindAppBar: true,
              body: SizedBox(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Image.asset(
            "assets/welcome_screen_1/welcomeImage_1.jpg",
            fit: BoxFit.fitHeight,
            height: double.infinity,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.72,
            child: SizedBox(
              height: constant.height * 0.28,
              // height: 100.h,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    // height: 40.h,
                    // color: Colors.red,
                    width: MediaQuery.of(context).size.width,
                    child: SizedBox(
                      height: constant.height * 0.045,
                      
                      child: FittedBox(
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
                  ),
                  SizedBox(
                    width: constant.width* 0.8,
                    height: constant.height * 0.06,
                    child: FittedBox(
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
              )),
            ),
    );
  }
}
