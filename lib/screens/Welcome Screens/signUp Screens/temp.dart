import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_campus/classes/screen_details.dart';
import 'package:on_campus/firebase/firestore_db.dart';
import 'package:on_campus/screens/Welcome%20Screens/signUp%20Screens/phone.dart';
import 'package:on_campus/screens/Welcome%20Screens/welcome_screen_4.dart';

class LoginPage extends StatefulWidget {
  final double? index;
  const LoginPage({super.key, required this.index});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? result;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  TextEditingController PhoneNumTextEditingController = TextEditingController();
  TextEditingController GoogleTextEditingController = TextEditingController();
  TextEditingController AppleTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Image.asset(
                      "assets/loginPage/Group 7.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    child: Column(
                      children: [
                        SizedBox(
                          child: Text(
                            "Find Your Home \n Away from Home",
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black87,
                              fontSize: 25.sp,
                              fontFamily: "Poppins-Black",
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.h),
                          child: Text(
                            "Easy & Simple",
                            style: TextStyle(
                              fontFamily: "Poppins-Black",
                              decoration: TextDecoration.none,
                              color: Colors.black87,
                              fontSize: 25.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Get the opportunity to stay at incredible \n place at economical prices.",
                          style: TextStyle(
                            // letterSpacing: 2.w,
                            fontWeight: FontWeight.w200,
                            fontFamily: "Poppins",
                            decoration: TextDecoration.none,
                            color: Colors.black38,
                            fontSize: 14.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        // SizedBox(height: 5.h),
                        DotsIndicator(
                          position: widget.index ?? 1,
                          dotsCount: 3,
                          decorator: DotsDecorator(
                            size: const Size(9, 7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            color: const Color.fromARGB(100, 158, 158, 158),
                            activeColor: const Color.fromARGB(255, 0, 239, 209),
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            activeSize: Size(
                              40.w,
                              ScreenDetails.ScreenHeight * 0.0105,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Material(
                          child: GestureDetector(
                            onTap: () {
                              // Get.to(
                              //   () => Phone(),
                              //   transition: Transition.fadeIn,
                              //   curve: Curves.easeIn,
                              //   duration: Duration(milliseconds: 600),
                              // );
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Phone();
                                  },
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.h),
                              height: 42.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.r),
                                ),
                                border: Border.all(
                                  width: 1.w,
                                  color: Colors.black38,
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/loginPage/Phone.png",
                                    width: 20.h,
                                    height: 20.h,
                                    fit: BoxFit.contain,
                                  ),

                                  // This keeps text centered irrespective of icon size
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "Sign In with Phone Number",
                                        style: TextStyle(
                                          fontFamily: "Ag Body 1",
                                          fontSize: 15.sp,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Material(
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });
                              await FirestoreDb.instance.signInWithGoogle();
                              setState(() {
                                isLoading = false;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.h),
                              height: 42.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.r),
                                ),
                                border: Border.all(
                                  width: 1.w,
                                  color: Colors.black38,
                                ),
                              ),
                              // padding: EdgeInsets.only(left: 10.w),
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/loginPage/google.png",
                                    width: 20.h,
                                    height: 20.h,
                                    fit: BoxFit.contain,
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: isLoading
                                          ? Align(
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 15,
                                                    height: 15,
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    "Please wait..",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Text(
                                              "Sign In with Google",
                                              style: TextStyle(
                                                fontFamily: "Ag Body 1",
                                                fontSize:
                                                    ScreenDetails.ScreenHeight *
                                                    0.0178,
                                                color: const Color.fromARGB(
                                                  255,
                                                  0,
                                                  0,
                                                  0,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Material(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.h),
                            height: 42.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.r),
                              ),
                              border: Border.all(
                                width: 1.w,
                                color: Colors.black38,
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/loginPage/apple.png",
                                  width: 20.h,
                                  height: 20.h,
                                  fit: BoxFit.contain,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "Sign In with Apple",
                                      style: TextStyle(
                                        fontFamily: "Ag Body 1",
                                        fontSize:
                                            ScreenDetails.ScreenHeight * 0.0178,
                                        color: const Color.fromARGB(
                                          255,
                                          0,
                                          0,
                                          0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Material(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const WelcomeScreen4(),
                                transition: Transition.fadeIn,
                                curve: Curves.easeIn,
                                duration: const Duration(milliseconds: 600),
                              );
                            },
                            child: Container(
                              height: ScreenDetails.ScreenHeight * 0.05832,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 0, 239, 209),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.r),
                                ),
                              ),
                              width: ScreenDetails.ScreenWidth * 0.8,
                              child: Align(
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: "Poppins",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
