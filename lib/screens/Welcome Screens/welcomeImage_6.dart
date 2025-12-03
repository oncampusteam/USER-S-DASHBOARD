
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen6 extends StatefulWidget {
  const WelcomeScreen6({super.key});

  @override
  State<WelcomeScreen6> createState() => _WelcomeScreen6State();
}

class _WelcomeScreen6State extends State<WelcomeScreen6> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
          child: SizedBox(
        child: Stack(
          children: [
            Image.asset(
              "assets/welcomeImage_6/welcomeImage_6.png",
              fit: BoxFit.cover,
              height: double.infinity,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              top: 490.h,
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
                        child: Text("Refer & Earn",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              letterSpacing: 0.15.w,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                              fontSize: 35.sp.clamp(0, 35),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                          "Invite friends to book with us and get rewards\n The more you refer the more you earn",
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
