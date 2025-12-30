import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen2 extends StatefulWidget {
  const WelcomeScreen2({super.key});

  @override
  State<WelcomeScreen2> createState() => _WelcomeScreen2State();
}

class _WelcomeScreen2State extends State<WelcomeScreen2> {
  @override
  Widget build(BuildContext context) {
    Size constant = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
          child: SizedBox(
        child: Stack(
          children: [
            Image.asset(
              "assets/welcome_screen_2/welcomeImage_2.jpg",
              fit: BoxFit.cover,
              height: double.infinity,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              top: constant.height * 0.72,
              child: SizedBox(
                height: constant.height * 0.28,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: constant.height * 0.045,
                      child: FittedBox(
                        child: Text(
                          "100% Verified Listing",
                          textAlign: TextAlign.center,
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              letterSpacing: 1.5.w,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 35.sp.clamp(0, 35),
                              // fontStyle: FontStyle.normal
                              fontFamily: "Poppins"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: constant.width* 0.8,
                      height: constant.height * 0.06,
                      child: FittedBox(
                        child: Text(
                          "we guarantee that what you see on our app is\nwhat you get.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              letterSpacing: 0.15.w,
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp.clamp(0, 18),
                              // fontStyle: FontStyle.normal
                              fontFamily: "Poppins"),
                        ),
                      ),
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
