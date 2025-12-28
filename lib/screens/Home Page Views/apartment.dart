import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
    return SafeArea(
        child: PopScope(
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
                
                // color: Colors.blue,
                foregroundDecoration: BoxDecoration(
                  color: _width ? Colors.black.withOpacity(0.5) : null,
                ),
                padding: EdgeInsets.only(top: 20.h),
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
                            foregroundDecoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.10),
                                borderRadius: BorderRadius.circular(8.r)),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8.r)),
                            child: Icon(Icons.chevron_left,
                                color: Colors.black, size: 24.w.clamp(0, 26)),
                          ),
                          // My Apartment Text Widget
                          Container(
                            child: Text("My Apartment",
                                style: TextStyle(
                                  fontFamily: "Poppins-Bold",
                                  fontSize: 22.sp.clamp(0, 24),
                                  letterSpacing: 0.15.w,
                                  color: Colors.white,
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                width =
                                    MediaQuery.of(context).size.width * 0.85;
                                _width = true;
                              });
                            },
                            child: Container(
                              height: 40.h,
                              width: 40.w,
                              foregroundDecoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.10),
                                  borderRadius: BorderRadius.circular(8.r)),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.30),
                                  borderRadius: BorderRadius.circular(8.r)),
                              child: Image.asset(
                                "assets/apartment/menu.png",
                                height: 14.h,
                                width: 14.w,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 140.h,
                      margin: EdgeInsets.only(top: 400.h),
                      child: Column(
                        children: [
                          Container(
                            width: 320.w,
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
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 6.h,
                                ),
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
                          SizedBox(
                            height: 15.h,
                          ),
                          Container(
                            width: 320.w,
                            // height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFF00EFD1),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(
                                    () => ApartmentHistory(
                                        user: user!),
                                    transition: Transition.fadeIn,
                                    curve: Curves.easeIn,
                                    duration:
                                        const Duration(milliseconds: 600));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 6.h,
                                ),
                                child: Text("Apartment History",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.sp.clamp(0, 20),
                                      color: Colors.white,
                                    )),
                              ),
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
    ));
  }
}
