import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_campus/screens/pickCampus.dart';

class WelcomeScreen5 extends StatefulWidget {
  final String username;
  const WelcomeScreen5({super.key, required this.username});

  @override
  State<WelcomeScreen5> createState() => _WelcomeScreen5State();
}

class _WelcomeScreen5State extends State<WelcomeScreen5> {
  TextEditingController nameTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: SizedBox(
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    child: Image.asset(
                      "assets/welcome_screen_5/welcomeImage_5.jpg",
                      fit: BoxFit.cover,
                      height: 700.h,
                      width: MediaQuery.of(context).size.width,
                    )),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.45,
                    child: Container(
                      margin: EdgeInsets.only(left: 25.w),
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          "assets/welcome_screen_5/transparent_logo-removebg.png",
                          fit: BoxFit.cover,
                          height: 45.h,
                          width: 105.h,
                        ),
                      ),
                    )),
                Positioned(
                    top: 0,
                    child: Container(
                      height: 700.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            // Color.fromARGB(0, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0),
                            Color.fromARGB(80, 0, 0, 0),
                            Color.fromARGB(100, 0, 0, 0),
                            Color.fromARGB(120, 0, 0, 0),
                            // Color.fromARGB(120, 0, 0, 0),
                            Color.fromARGB(140, 0, 0, 0),
                            Color.fromARGB(160, 0, 0, 0),
                            Color.fromARGB(180, 0, 0, 0),
                            Color.fromARGB(200, 0, 0, 0),
                          ])),
                      // color: Colors.green,

                      // child:
                    )),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.45,
                    child: Container(
                      margin: EdgeInsets.only(left: 25.w),
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          "assets/welcome_screen_5/transparent_logo-removebg.png",
                          fit: BoxFit.cover,
                          height: 45.h,
                          width: 105.h,
                        ),
                      ),
                    )),
                Positioned(
                    top: 170.h,
                    left: 0,
                    child: Container(
                      margin: EdgeInsets.only(left: 10.h),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10.h),
                            child: Text("Welcome",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 39.sp.clamp(0, 39),
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.none,
                                )),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10.h),
                            child: Text(widget.username,
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  color: const Color.fromARGB(255, 0, 239, 209),
                                  fontSize: 40.sp.clamp(0, 40),
                                  // fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.none,
                                )),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10.h),
                            child: Text("to our platform",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 39.sp.clamp(0, 39),
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.none,
                                )),
                          )
                        ],
                      ),
                    )),
                Positioned(
                  left: 10.h,
                  right: 10.h,
                  bottom: 10.h,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //   return Pickcampus(username: widget.username);
                      // }));
                      Get.to(
                          () => Pickcampus(
                                username: widget.username,
                              ),
                          transition: Transition.fadeIn,
                          curve: Curves.easeIn,
                          duration: const Duration(milliseconds: 600));
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
                        child: Text(
                          "Next",
                          style: TextStyle(
                            fontSize: 18.sp.clamp(0, 18),
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 60.h,
                  left: 15.h,
                  child: Container(
                    height: 40.h,
                    width: 40.w,
                    foregroundDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: const Color.fromARGB(10, 0, 0, 0)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r)),
                    child: Icon(
                      Icons.chevron_left,
                      size: 24.sp.clamp(
                            0,
                            24,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
