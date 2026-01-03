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
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, snapshot) {
        
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            child: SizedBox(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: Image.asset(
                      "assets/welcome_screen_5/welcomeImage_5.jpg",
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.46,
                    child: Container(
                      margin: EdgeInsets.only(left: 20.w),
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          "assets/welcome_screen_5/transparent_logo-removebg.png",
                          fit: BoxFit.cover,
                          height: 50.h,
                          width: 115.h,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
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
                          ],
                        ),
                      ),
                      // color: Colors.green,

                      // child:
                    ),
                  ),
                  // Positioned(
                  //     top: MediaQuery.of(context).size.height * 0.5,
                  //     child: Container(
                  //       margin: EdgeInsets.only(left: 25.w),
                  //       width: MediaQuery.of(context).size.width,
                  //       child: Align(
                  //         alignment: Alignment.topCenter,
                  //         child: Image.asset(
                  //           "assets/welcome_screen_5/transparent_logo-removebg.png",
                  //           fit: BoxFit.cover,
                  //           height: 45.h,
                  //           width: 105.h,
                  //         ),
                  //       ),
                  //     )),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.23,
                    left: 0,
                    child: Container(
                      // color: Colors.red,
                      height: MediaQuery.of(context).size.height * 0.2,
                      margin: EdgeInsets.only(left: 10.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10.h),
                            child: SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.065,
                              child: FittedBox(
                                child: Text(
                                  "Welcome",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                    fontSize: 39.sp.clamp(0, 39),
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10.h),
                            child: SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.065,
                              child: FittedBox(
                                child: Text(
                                  widget.username,
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    color: const Color.fromARGB(
                                      255,
                                      0,
                                      239,
                                      209,
                                    ),
                                    fontSize: 40.sp.clamp(0, 40),
                                    // fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            // color: Colors.blue,
                            height: MediaQuery.of(context).size.height * 0.065,
                            margin: EdgeInsets.only(left: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height *
                                      0.065,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: FittedBox(
                                    child: Text(
                                      "to our platform",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontSize: 39.sp.clamp(0, 39),
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: Image.asset(
                                    "assets/welcome_screen_5/Emoji.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Positioned(
                  //   left: 20.w,
                  //   right: 20.w,
                  //   bottom: 30.h,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //       //   return Pickcampus(username: widget.username);
                  //       // }));
                  //       Get.to(
                  //         () => Pickcampus(username: widget.username),
                  //         transition: Transition.fadeIn,
                  //         curve: Curves.easeIn,
                  //         duration: const Duration(milliseconds: 600),
                  //       );
                  //     },
                  //     child: Container(
                  //       height: MediaQuery.of(context).size.height * 0.06,
                  //       decoration: BoxDecoration(
                  //         color: const Color.fromARGB(255, 0, 239, 209),
                  //         borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  //         // border: Border.all(
                  //         //     width: 2.w,
                  //         //     color:
                  //         //         const Color.fromARGB(100, 0, 0, 0)),
                  //       ),
                  //       // padding: EdgeInsets.only(left: 10.w),
                  //       width: 330.w,
                  //       child: Align(
                  //         child: Text(
                  //           "Next",
                  //           style: TextStyle(
                  //             fontSize: 18.sp.clamp(0, 18),
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.w600,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                    top: 60.h,
                    left: 15.h,
                    child: Container(
                      height: 40.h,
                      width: 40.w,
                      foregroundDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: const Color.fromARGB(10, 0, 0, 0),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(Icons.chevron_left, size: 24.sp.clamp(0, 24)),
                    ),
                  ),
                ],
              ),
            ),
          );
        } 
        if (snapshot.connectionState == ConnectionState.done) {
          return Pickcampus(username: widget.username);
        }
        else {
          return Container();
        }
      },
    );
  }
}
