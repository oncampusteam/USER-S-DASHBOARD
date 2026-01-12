import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:on_campus/firebase/firestore_db.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:on_campus/screens/Welcome%20Screens/welcome_screen_4.dart';
import 'package:on_campus/screens/Welcome%20Screens/signUp%20Screens/phone.dart';
// import 'package:on_campus/Screens/GetStartedScreen/getStartedScreen.dart';

class LoginPage extends StatefulWidget {
  final int index;
  const LoginPage({super.key, required this.index});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(
          top: 16.h,
          left: 28.w,
          right: 28.w,
          bottom: 30.h,
        ),
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FittedBox(
          child: Column(
            children: [
              SizedBox(
                height: 392.h,
                width: 375.w,
                child: Image.asset("assets/loginPage/Group 7.png"),
              ),
              SizedBox(
                // color: Colors.blue,
                // padding: EdgeInsets.only(top: 11.h, left: 10.w, right: 10.w),
                height: 189.h,
                width: 356.w,
                child: Column(
                  children: [
                    SizedBox(
                      height: 117.h,
                      width: 356.w,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40.h,
                            // color: Colors.red,
                            child: FittedBox(
                              child: Text(
                                "Find Your Home",
                                style: TextStyle(
                                  fontFamily: "Poppins-Black",
                                  fontSize: 28.sp,
                                  letterSpacing: 28.sp * 0.02,
                                  // height: 1.4.h,
                                  color: const Color(0XFF323232),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 35.h,
                            // color: Colors.red,
                            child: FittedBox(
                              child: Text(
                                "Away from Home",
                                style: TextStyle(
                                  fontFamily: "Poppins-Black",
                                  fontSize: 28.sp,
                                  letterSpacing: 28.sp * 0.02,
                                  height: 1.4.h,
                                  color: const Color(0XFF323232),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 35.h,
                            // color: Colors.red,
                            child: FittedBox(
                              child: Text(
                                "Easy & Simple",
                                style: TextStyle(
                                  fontFamily: "Poppins-Black",
                                  fontSize: 28.sp,
                                  letterSpacing: 28.sp * 0.02,
                                  height: 1.4.h,
                                  color: const Color(0XFF323232),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 65.h,
                      width: 400.w,
                      padding: EdgeInsets.only(left: 22.w, right: 22.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 17.h,
                            // color: Colors.red,
                            child: FittedBox(
                              child: Text(
                                "Get the opportunity to stay at incredible",
                                style: TextStyle(
                                  fontFamily: "Poppins-Light",
                                  fontSize: 14.sp,
                                  letterSpacing: 14.sp * 0.03,
                                  height: 1.4.h,
                                  // color: const Color(323232)
                                  color: const Color(0XFF787878),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 17.h,
                            // color: Colors.red,
                            child: FittedBox(
                              child: Text(
                                "place at economical prices.",
                                style: TextStyle(
                                  fontFamily: "Poppins-Light",
                                  fontSize: 14.sp,
                                  letterSpacing: 14.sp * 0.03,
                                  height: 1.4.h,
                                  color: const Color(0XFF787878),
                                  // color: const Color(323232)
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025,
                            child: DotsIndicator(
                              position: 0,
                              dotsCount: 3,
                              decorator: DotsDecorator(
                                size: Size(9.h, 7.w),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                color: const Color.fromARGB(100, 158, 158, 158),
                                activeColor: const Color.fromARGB(
                                  255,
                                  0,
                                  239,
                                  209,
                                ),
                                activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                activeSize: Size(51.w, 7.h),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: () {
                  Get.to(() => Phone());
                },
                child: Container(
                  height: 48.h,
                  width: 346.w,

                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.81),
                    border: Border.all(color: const Color(0XFFE5E5E5)),
                    borderRadius: BorderRadius.all(Radius.circular(5.r)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 32.h,
                        width: 32.w,
                        padding: EdgeInsets.only(left: 5.w),
                        child: Image.asset("assets/loginPage/Phone.png"),
                      ),
                      Expanded(
                        child: Align(
                          child: SizedBox(
                            height: 20.h,
                            child: const FittedBox(
                              child: Text(
                                "Sign In with Phone Number",
                                style: TextStyle(fontFamily: "Ag button"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              InkWell(
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
                  height: 48.h,
                  width: 346.w,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.81),
                    border: Border.all(color: const Color(0XFFE5E5E5)),
                    borderRadius: BorderRadius.all(Radius.circular(5.r)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 32.h,
                        width: 32.w,
                        padding: EdgeInsets.only(left: 5.w),
                        child: Image.asset("assets/loginPage/google.png"),
                      ),
                      Expanded(
                        child: Align(
                          child: SizedBox(
                            height: 20.h,
                            child: FittedBox(
                              child: Text(
                                !isLoading
                                    ? "Sign In with Google"
                                    : "Please wait",
                                style: TextStyle(fontFamily: "Ag button"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                height: 48.h,
                width: 346.w,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.81),
                  border: Border.all(color: const Color(0XFFE5E5E5)),
                  borderRadius: BorderRadius.all(Radius.circular(5.r)),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 32.h,
                      width: 32.w,
                      padding: EdgeInsets.only(left: 5.w),
                      child: Image.asset("assets/loginPage/apple.png"),
                    ),
                    Expanded(
                      child: Align(
                        child: SizedBox(
                          height: 20.h,
                          child: const FittedBox(
                            child: Text(
                              "Sign In with Apple",
                              style: TextStyle(fontFamily: "Ag button"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              GestureDetector(
                onTap: () {
                  final FlutterSecureStorage secureStorage =
                      FlutterSecureStorage();
                  secureStorage.write(key: "isfirstOpen", value: "false");
                  Get.to(
                    () => const WelcomeScreen4(),
                    transition: Transition.fadeIn,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeIn,
                  );
                },
                child: Container(
                  height: 54.h,
                  width: 347.w,
                  decoration: BoxDecoration(
                    color: const Color(0XFF00EFD1),
                    border: Border.all(color: const Color(0XFF00EFD1)),
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ),
                  child: Align(
                    child: SizedBox(
                      height: 25.h,
                      child: FittedBox(
                        child: Text(
                          "SKip",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                // color: Colors.red,
                height: 20.h,
                child: Row(
                  children: [
                    SizedBox(
                      height: 3.5.h,
                      child: FittedBox(
                        child: Text(
                          "Already Have an account? ",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: const Color(0xFF000000),
                            letterSpacing: 0.015,
                            height: 0.24,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.5.h,
                      child: FittedBox(
                        child: Text(
                          "Sign In ",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: const Color(0xFF00EFD1),
                            letterSpacing: 0.015,
                            height: 0.24,
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
    );
  }
}
