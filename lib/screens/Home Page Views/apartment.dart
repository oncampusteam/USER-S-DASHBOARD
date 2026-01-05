import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:on_campus/screens/apartment_history.dart';
import 'view_room_details.dart';

class Apartment extends StatefulWidget {
  
  const Apartment({super.key});

  @override
  State<Apartment> createState() => _ApartmentState();
}

class _ApartmentState extends State<Apartment> {
  final User? user = FirebaseAuth.instance.currentUser;
  int selectedIndex = 0;
  bool menu = false;
  double width = 0;
  // ignore: prefer_final_fields
  bool _width = false;
  @override
  Widget build(BuildContext context) {
    return PopScope(
          canPop: false,
          child: Scaffold(
    body: Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.only(top: Constant.height * 0.06),
            // color: Colors.blue,
            foregroundDecoration: BoxDecoration(
              color: _width ? Colors.black.withOpacity(0.5) : null,
            ),
            // padding: EdgeInsets.only(top: 20.h),
            decoration: const BoxDecoration(
              
                image: DecorationImage(
                    image: AssetImage(
                        "assets/apartment/apartment_background.jpg"),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // back button///
                      Container(
                        height: 40.h,
                        width: 40.w,
                        // foregroundDecoration: BoxDecoration(
                        //     color: Colors.black.withOpacity(0.10),
                        //     borderRadius: BorderRadius.circular(8.r)),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 0.3),
                            borderRadius: BorderRadius.circular(8.r)),
                        child: Icon(Icons.chevron_left,
                            color: Colors.black, size: 24.w.clamp(0, 26)),
                      ),
                      // My Apartment Text Widget
                      SizedBox(
                        height: Constant.height * 0.04,
                        child: FittedBox(
                          child: Text("My Apartment",
                              style: TextStyle(
                                fontFamily: "Poppins-Bold",
                                fontSize: 22.sp.clamp(0, 24),
                                letterSpacing: 0.15.w,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // ScaffoldMessenger.of(context).
                          // setState(() {
                          //   width =
                          //       MediaQuery.of(context).size.width * 0.85;
                          //   _width = false;
                          // });
                        },
                        child: Container(
                          height: 40.h,
                          width: 40.w,
                          // foregroundDecoration: BoxDecoration(
                          //     color: const Color.fromRGBO(0, 0, 0, 0.1),
                          //     borderRadius: BorderRadius.circular(8.r)),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 255, 255, 0.3),
                              borderRadius: BorderRadius.circular(8.r)),
                          child: Padding(
                            padding: EdgeInsets.all(8.r),
                            child: Image.asset(
                              "assets/apartment/menu.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // height: Constant.height * 0.06,
                  margin: EdgeInsets.only(top: Constant.height * 0.6),
                  child: Column(
                    children: [
                      Container(
                        width: Constant.width * 0.8,
                        height: Constant.height * 0.06,
                        // height: 40.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => const ViewRoomDetails(),
                                transition: Transition.fadeIn,
                                curve: Curves.easeIn,
                                duration:
                                    const Duration(milliseconds: 600));
                          },
                          child: Align(
                            child: SizedBox(
                              height: Constant.height * 0.03,
                              child: FittedBox(
                                child: Text("View Room detail",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.sp.clamp(0, 20),
                                        color: const Color(0xFF00EFD1))),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        width: Constant.width * 0.8,
                        height: Constant.height * 0.06,
                        // height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00EFD1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            // Get.to(
                            //     () => ApartmentHistory(
                            //         user: user!),
                            //     transition: Transition.fadeIn,
                            //     curve: Curves.easeIn,
                            //     duration:
                            //         const Duration(milliseconds: 600));
                          },
                          child: Align(
                            child: Container(
                              // color: Colors.brown,
                              height: Constant.height * 0.03,
                              width: Constant.width * 0.35,
                              child: Row(children: [
                                Image.asset("assets/apartment/room chat.png", fit: BoxFit.cover),
                                FittedBox(
                                  child: Text(" Room Chat",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.sp.clamp(0, 20),
                                    color: Colors.white,
                                  )),
                                ),
                              ],),
                            ),
                          )
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
          ),
        );
  }
}
