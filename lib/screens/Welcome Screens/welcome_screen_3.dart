import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen3 extends StatefulWidget {
  const WelcomeScreen3({super.key});

  @override
  State<WelcomeScreen3> createState() => _WelcomeScreen3State();
}

class _WelcomeScreen3State extends State<WelcomeScreen3> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Image.asset(
                  "assets/welcome_screen_3/welcomeImage_3.png",
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
                Positioned(
                    top: 490.h,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Text(
                            "Price Match Guaranted",
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
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                              "we keep our Promise. Grab the best offers along with the lowest price promise",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  letterSpacing: 0.15.w,
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp.clamp(0, 18),
                                  // fontStyle: FontStyle.normal
                                  fontFamily: "Poppins")),
                        ],
                      ),
                    )),
              ],
            )),
      ),
    );
  }
}
