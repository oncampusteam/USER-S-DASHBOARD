import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_campus/screens/Welcome%20Screens/welcome_screen_4.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  double selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
  }

  TextEditingController emailPhoneTextEditingController =
      TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                Positioned(
                    top: 15.h,
                    child: Transform.rotate(
                      angle: -90.r,
                      child: SizedBox(
                        // color: Colors.red,
                        height: 250.h,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 80.h),
                              child: Row(
                                children: [
                                  imageContainer("assets/20240728_121552.png"),
                                  SizedBox(width: 15.w),
                                  imageContainer(
                                      "assets/maskgroup2_rotated.png")
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 35.h),
                              child: Row(
                                children: [
                                  imageContainer(
                                      "assets/maskgroup3_rotated.png"),
                                  SizedBox(width: 15.w),
                                  imageContainer(
                                      "assets/maskgroup4_rotated.png"),
                                  SizedBox(width: 15.w),
                                  imageContainer(
                                      "assets/maskgroup5_rotated.png")
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 80.h),
                              child: Row(
                                children: [
                                  imageContainer(
                                      "assets/maskgroup7_rotated.png"),
                                  SizedBox(width: 15.w),
                                  imageContainer(
                                      "assets/maskgroup6_rotated.png")
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                Positioned(
                  top: 340.h,
                  child: SizedBox(
                    // color: Colors.blue,
                    // margin: EdgeInsets.symmetric(horizontal: 45.h),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Let's Find Your Sweet",
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              letterSpacing: 3.w,
                              color: const Color.fromARGB(180, 0, 0, 0),
                              fontSize: 28.sp,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w600,
                            )),
                        Text("& Dream Place",
                            style: TextStyle(
                              letterSpacing: 3.w,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none,
                              color: const Color.fromARGB(180, 0, 0, 0),
                              fontSize: 28.sp,
                            )),
                        SizedBox(height: 10.h),
                        Text("Get the opportunity to stay at incredible",
                            style: TextStyle(
                              letterSpacing: 2.w,
                              fontFamily: "Roboto",
                              decoration: TextDecoration.none,
                              color: const Color.fromARGB(100, 0, 0, 0),
                              fontSize: 14.sp,
                            )),
                        Text("place at economical prices",
                            style: TextStyle(
                              letterSpacing: 2.w,
                              fontFamily: "Roboto",
                              decoration: TextDecoration.none,
                              color: const Color.fromARGB(100, 0, 0, 0),
                              fontSize: 14.sp,
                            )),
                        SizedBox(height: 10.h),
                        DotsIndicator(
                          position: selectedIndex,
                          dotsCount: 3,
                          decorator: DotsDecorator(
                              color: Colors.grey,
                              activeColor:
                                  const Color.fromARGB(255, 0, 239, 209),
                              activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              activeSize: Size(40.w, 7.h)),
                        ),
                        SizedBox(height: 10.h),
                        Material(
                          child: Container(
                            // height: 50.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                              border: Border.all(
                                  width: 2.w,
                                  color: const Color.fromARGB(100, 0, 0, 0)),
                            ),
                            padding: EdgeInsets.only(left: 10.w),
                            width: 330.w,
                            child: TextField(
                              cursorColor: Colors.black,
                              // enabled: false,
                              controller: emailPhoneTextEditingController,
                              decoration: const InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  labelText: "Email or Phone Number",
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0))),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Material(
                          child: Container(
                            // height: 50.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                              border: Border.all(
                                  width: 2.w,
                                  color: const Color.fromARGB(100, 0, 0, 0)),
                            ),
                            padding: EdgeInsets.only(left: 10.w),
                            width: 330.w,
                            child: TextField(
                              cursorColor: Colors.black,
                              // enabled: false,
                              controller: passwordTextEditingController,
                              decoration: const InputDecoration(
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  labelText: "Password",
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0))),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Material(
                          child: GestureDetector(
                            onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const WelcomeScreen4();
                                    }));
                                  },
                            child: Container(
                                height: 45.h,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 0, 239, 209),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                  // border: Border.all(
                                  //     width: 2.w,
                                  //     color:
                                  //         const Color.fromARGB(100, 0, 0, 0)),
                                ),
                                // padding: EdgeInsets.only(left: 10.w),
                                width: 330.w,
                                child: Align(
                                    child: Text("Sign Up",
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        )))),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        RichText(
                            text: TextSpan(
                                text: "Don't have an account?",
                                style: TextStyle(
                                    color: const Color.fromARGB(150, 0, 0, 0),
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500),
                                children: [
                              TextSpan(
                                text: " sign up",
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 0, 239, 209),
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500),
                              )
                            ]))
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    ));
  }
}

Widget imageContainer(String imagePath) {
  return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(15.r),
        bottomRight: Radius.circular(15.r),
        topLeft: Radius.circular(15.r),
        topRight: Radius.circular(15.r),
      ),
      child: SizedBox(
          // color: Colors.yellow,
          height: 70.h,
          width: 90.w,
          child: Transform.rotate(
            angle: 0.r,
            child: Image.asset(imagePath,
                width: 100.w, height: 100.h, fit: BoxFit.cover),
          )));
}
