import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_campus/screens/Home%20Page%20Views/apartment.dart';
import 'package:on_campus/screens/Home%20Page%20Views/compare.dart';
import 'package:on_campus/screens/Home%20Page%20Views/home.dart';
import 'package:on_campus/screens/Home%20Page%20Views/payment.dart';
import 'package:on_campus/screens/Home%20Page%20Views/profile.dart';
import 'package:on_campus/temps/clipper.dart';

class ApartmentHistory extends StatefulWidget {
  final User user;
  const ApartmentHistory({super.key, required this.user});

  @override
  State<ApartmentHistory> createState() => _ApartmentHistoryState();
}

class _ApartmentHistoryState extends State<ApartmentHistory> {
  bool tapped = false;
  int selectedIndex = 0;
  bool _receit = false;
  double _height = 0;

  Widget receit() {
    return Align(
      // alignment: AlignmentDirectional.bottomEnd,
      child: AnimatedContainer(
        curve: Curves.easeIn,
        height: _height,
        duration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
          // color: const Color(0xFFF5F8FF),
          color: const Color(0xFFF5F8FF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r),
            topRight: Radius.circular(25.r),
          ),
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 20.h),
            child: Column(
              children: [
                SizedBox(
                  // color: Colors.red,
                  height: 140.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _height = 0;
                              _receit = false;
                            });
                          },
                          child: Icon(Icons.close, size: 24.h),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 25.h),
                        child: Column(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: const Color(0xFF00EFD1),
                              size: 24.h,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "Payment Success",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                                color: const Color(0xFF00EFD1),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "¢ 2,000",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                fontSize: 28.sp,
                                // color: const Color(0xFF00EFD1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: Icon(Icons.ios_share_outlined, size: 24.h),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25.h),
                  padding: EdgeInsets.all(5.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16.r)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 50.h,
                        // margin: EdgeInsets.symmetric(horizontal: 3.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: const Color(0xFFF5F6F7),
                        ),
                        child: Align(
                          child: Text(
                            "Payment Details",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 15.h),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Ref Number",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 13.sp,
                                      color: const Color(0xFF707070),
                                    ),
                                  ),
                                  Text(
                                    "000085752257",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Payment Time",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 13.sp,
                                      color: const Color(0xFF707070),
                                    ),
                                  ),
                                  Text(
                                    "17-08-2024, 04:40:17",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Payment Method",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 13.sp,
                                      color: const Color(0xFF707070),
                                    ),
                                  ),
                                  Text(
                                    "Mobile Money",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Sender Name",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 13.sp,
                                      color: const Color(0xFF707070),
                                    ),
                                  ),
                                  Text(
                                    "Antonio Roberto",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 5.h,
                            // ),
                            SizedBox(
                              // color: Colors.blue,
                              height: 20.h,
                              width: double.infinity,
                              child: Align(
                                child: Text(
                                  "...........................................................................................................................",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Amount",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 13.sp,
                                      color: const Color(0xFF707070),
                                    ),
                                  ),
                                  Text(
                                    "¢ 1,800",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Admin Fee",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 13.sp,
                                      color: const Color(0xFF707070),
                                    ),
                                  ),
                                  Text(
                                    "¢ 200",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Payment Status",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 13.sp,
                                      color: const Color(0xFF707070),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5.h),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                        35,
                                        162,
                                        109,
                                        0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(23.r),
                                    ),
                                    child: Text(
                                      "Success",
                                      style: TextStyle(
                                        color: const Color(0xFF00EFD1),
                                        fontFamily: "Poppins",
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Sizedbox()
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25.h),
                  width: double.infinity,
                  height: 40.h,
                  child: FilledButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Color(0xFF00EFD1),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        ),
                      ),
                      backgroundColor: const WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Get PDF Receit",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: const Color(0xFF00EFD1),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25.h),
                  width: double.infinity,
                  height: 40.h,
                  child: FilledButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          // side: const BorderSide(color: Color(0xFF00EFD1), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        ),
                      ),
                      backgroundColor: const WidgetStatePropertyAll(
                        Color(0xFF00EFD1),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Get.to(
                        () => Home(),
                        transition: Transition.fadeIn,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeIn,
                      );
                      _receit = false;
                    },
                    child: Text(
                      "Back to Home",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                child: Container(
                  foregroundDecoration: BoxDecoration(
                    color: _receit ? Colors.black.withOpacity(0.5) : null,
                  ),
                  height: MediaQuery.sizeOf(context).height,
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10.h),
                              height: 30.h,
                              width: 35.w,
                              foregroundDecoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(7.r),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(7.r),
                              ),
                              child: Icon(
                                Icons.chevron_left,
                                color: Colors.black,
                                size: 24.w,
                              ),
                            ),
                          ),
                          SizedBox(width: 75.w),
                          Text(
                            "Apartment History",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                              fontSize: 20.sp,
                              color: const Color(0xFF323232),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 10.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          height: 40.h,
                          width: 40.w,
                          child: Image.asset(
                            "assets/apartment_history/trash_container.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            tapped = !tapped;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.h),
                          child: Card(
                            shadowColor: Colors.black.withOpacity(0.8),
                            color: Colors.white,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 80.w,
                                    height: 60.h,
                                    child: SizedBox(
                                      width: 80.w,
                                      height: 60.h,
                                      child: Image.asset(
                                        "assets/apartment_history/hostel-2.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.0.w,
                                        vertical: 10.h,
                                      ),
                                      child: SizedBox(
                                        // color: Colors.red,
                                        height: 60.h,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: 15.h,
                                                  // color: Colors.red,
                                                  child: FittedBox(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Albert-Acquah hall",
                                                      style: TextStyle(
                                                        fontFamily: "Roboto",
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: 0.15.w,
                                                        color: const Color(
                                                          0xFF1D1B20,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      size: 15.sp,
                                                      color:
                                                          const Color.fromARGB(
                                                            255,
                                                            33,
                                                            243,
                                                            201,
                                                          ),
                                                    ),
                                                    SizedBox(width: 5.w),
                                                    Text(
                                                      "4.5/5",
                                                      style: TextStyle(
                                                        fontFamily: "Roboto",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 10.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 10.h,
                                              child: Row(
                                                children: [
                                                  FittedBox(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Location:  ",
                                                      style: TextStyle(
                                                        fontFamily: "Roboto",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 10.sp,
                                                        color: const Color(
                                                          0xFF333333,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "1994 Broadway, Kenyase",
                                                    style: TextStyle(
                                                      fontFamily: "Roboto",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 10.sp,
                                                      color: const Color(
                                                        0xFF333333,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // SizedBox(height: 2.h),
                                            Container(
                                              // color: Colors.blue,
                                              height: 10.h,
                                              child: FittedBox(
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Room type:  ",
                                                      style: TextStyle(
                                                        fontFamily: "Roboto",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 10.sp,
                                                        color: const Color(
                                                          0xFF333333,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "2 in a room",
                                                      style: TextStyle(
                                                        fontFamily: "Roboto",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 10.sp,
                                                        color: const Color(
                                                          0xFF333333,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // SizedBox(height: 2.h),
                                            Container(
                                              height: 10.h,
                                              child: FittedBox(
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Price:  ",
                                                      style: TextStyle(
                                                        fontFamily: "Roboto",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 10.sp,
                                                        color: const Color(
                                                          0xFF333333,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "¢1,500 (paid)",
                                                      style: TextStyle(
                                                        fontFamily: "Roboto",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 10.sp,
                                                        color: const Color(
                                                          0xFF333333,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // SizedBox(height: 2.h),
                                            Container(
                                              height: 10.h,
                                              child: FittedBox(
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.error,
                                                      size: 11.sp,
                                                      color: Colors.red,
                                                    ),
                                                    SizedBox(width: 2.w),
                                                    Text(
                                                      "Dates of stay:  ",
                                                      style: TextStyle(
                                                        fontFamily: "Roboto",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 10.sp,
                                                        color: const Color(
                                                          0xFF333333,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "01/02/2023 - 30/06/2023",
                                                      style: TextStyle(
                                                        fontFamily: "Roboto",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 10.sp,
                                                        color: const Color(
                                                          0xFF333333,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      tapped
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.h),
                              child: Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 15.0.w,
                                    top: 20.h,
                                    right: 15.0.w,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Booking Date",
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                          Text(
                                            "August 08, 2024 | 4:40 PM",
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Check In",
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                          Text(
                                            "August 08, 2024",
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Check Out",
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                          Text(
                                            "August 08, 2026",
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Tenant",
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                          Text(
                                            "01 person",
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12.h),
                                      const Divider(),
                                      SizedBox(height: 12.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Amount",
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                          Text(
                                            "¢1,800",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Tax & Fees",
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                          Text(
                                            "¢200.00",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total",
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                          Text(
                                            "¢2,000",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _height =
                                                        MediaQuery.of(
                                                          context,
                                                        ).size.height *
                                                        0.85;
                                                    _receit = true;
                                                  });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          30.r,
                                                        ),
                                                  ),
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                        255,
                                                        33,
                                                        243,
                                                        201,
                                                      ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "View Receipt",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 11.sp,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "Paid",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12.h),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(height: 0, width: 0),
                      SizedBox(height: 10.h),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                // color: Colors.white,
                // color: Colors.blue,
                height: 45.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //// left container///////////////////////////////////////////////////////////////////////////
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 239, 209),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.r),
                          topRight: Radius.circular(37.r),
                        ),
                      ),
                      height: 45.h,
                      width: 170.w,
                      child: SizedBox(
                        height: 45.h,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              // color: Colors.red,
                              width: 85.w,
                              child: Column(
                                children: [
                                  selectedIndex == 0
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedIndex = 0;
                                              Get.to(
                                                () => Apartment(),
                                                transition: Transition.fadeIn,
                                                curve: Curves.easeIn,
                                                duration: const Duration(
                                                  milliseconds: 600,
                                                ),
                                              );
                                            });
                                          },
                                          child: Container(
                                            // color: Colors.red,
                                            // padding: EdgeInsets.only(left: 10.h),
                                            child: ColorFiltered(
                                              colorFilter: const ColorFilter.mode(
                                                Color.fromARGB(
                                                  255,
                                                  0,
                                                  183,
                                                  185,
                                                ), // The color you want to apply
                                                BlendMode
                                                    .modulate, // The blend mode
                                              ),
                                              child: Image.asset(
                                                "assets/apartment_history/my apartment.png",
                                                height: 45.h,
                                                width: 100.w,
                                              ),
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedIndex = 0;
                                              Get.to(
                                                () => Apartment(),
                                                transition: Transition.fadeIn,
                                                curve: Curves.easeIn,
                                                duration: const Duration(
                                                  milliseconds: 600,
                                                ),
                                              );
                                            });
                                          },
                                          child: Image.asset(
                                            "assets/apartment_history/my apartment.png",
                                            height: 45.h,
                                            width: 100.w,
                                          ),
                                        ),
                                  // Text("My Apartment")
                                ],
                              ),
                            ),
                            SizedBox(width: 5.w),
                            selectedIndex == 1
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = 1;
                                        Get.to(
                                          () => Payment(user: widget.user),
                                          transition: Transition.fadeIn,
                                          curve: Curves.easeIn,
                                          duration: const Duration(
                                            milliseconds: 600,
                                          ),
                                        );
                                      });
                                    },
                                    child: ColorFiltered(
                                      colorFilter: const ColorFilter.mode(
                                        Color.fromARGB(
                                          255,
                                          0,
                                          183,
                                          185,
                                        ), // The color you want to apply
                                        BlendMode.modulate, // The blend mode
                                      ),
                                      child: SizedBox(
                                        // color: Colors.blue,
                                        width: 75.w,
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              "assets/apartment_history/payment.png",
                                              height: 40.h,
                                              width: 65.w,
                                            ),
                                            // Text("Payment")
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = 1;
                                        Get.to(
                                          () => Payment(user: widget.user),
                                          transition: Transition.fadeIn,
                                          curve: Curves.easeIn,
                                          duration: const Duration(
                                            milliseconds: 600,
                                          ),
                                        );
                                      });
                                    },
                                    child: Image.asset(
                                      "assets/apartment_history/payment.png",
                                      height: 40.h,
                                      width: 65.w,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    ////////////right container
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 239, 209),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(37.r),
                          topRight: Radius.circular(12.r),
                        ),
                      ),
                      height: 45.h,
                      width: 170.w,
                      child: SizedBox(
                        height: 45.h,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            selectedIndex == 2
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = 2;
                                        Get.to(
                                          () => Compare(
                                            username:
                                                widget.user.displayName ?? "",
                                          ),
                                          transition: Transition.fadeIn,
                                          curve: Curves.easeIn,
                                          duration: const Duration(
                                            milliseconds: 600,
                                          ),
                                        );
                                      });
                                    },
                                    child: ColorFiltered(
                                      colorFilter: const ColorFilter.mode(
                                        Color.fromARGB(
                                          255,
                                          0,
                                          183,
                                          185,
                                        ), // The color you want to apply
                                        BlendMode.modulate, // The blend mode
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.only(left: 10.h),
                                        // color: Colors.red,
                                        width: 70.w,
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              "assets/apartment_history/compare.png",
                                              height: 40.h,
                                              width: 65.w,
                                            ),
                                            // Text("My Apartment")
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = 2;
                                        Get.to(
                                          () => Compare(
                                            username:
                                                widget.user.displayName ?? "",
                                          ),
                                          transition: Transition.fadeIn,
                                          curve: Curves.easeIn,
                                          duration: const Duration(
                                            milliseconds: 600,
                                          ),
                                        );
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10.h),
                                      child: Image.asset(
                                        "assets/apartment_history/compare.png",
                                        height: 40.h,
                                        width: 65.w,
                                      ),
                                    ),
                                  ),
                            SizedBox(width: 10.w),
                            selectedIndex == 3
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = 3;
                                        Get.to(
                                          () => Profile(),
                                          transition: Transition.fadeIn,
                                          curve: Curves.easeIn,
                                          duration: const Duration(
                                            milliseconds: 600,
                                          ),
                                        );
                                      });
                                    },
                                    child: ColorFiltered(
                                      colorFilter: const ColorFilter.mode(
                                        Color.fromARGB(
                                          255,
                                          0,
                                          183,
                                          185,
                                        ), // The color you want to apply
                                        BlendMode.modulate, // The blend mode
                                      ),
                                      child: SizedBox(
                                        // margin:
                                        //   EdgeInsets.only(left: 10.h),
                                        // color: Colors.blue,
                                        width: 70.w,
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              "assets/apartment_history/profile.png",
                                              height: 40.h,
                                              width: 65.w,
                                            ),
                                            // Text("Payment")
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = 3;
                                        Get.to(
                                          () => Profile(),
                                          transition: Transition.fadeIn,
                                          curve: Curves.easeIn,
                                          duration: const Duration(
                                            milliseconds: 600,
                                          ),
                                        );
                                      });
                                    },
                                    child: Image.asset(
                                      "assets/apartment_history/profile.png",
                                      height: 40.h,
                                      width: 65.w,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0.h,
              left: 160.w,
              right: 160.w,
              child: ClipPath(
                clipper: Clipper(),
                child: Container(
                  height: 65.h,
                  // width: 10.w,
                  decoration: const BoxDecoration(
                    // color: Colors.blue,
                    color: Color.fromARGB(255, 0, 239, 209),
                  ),
                ),
              ),
            ),
            // Positioned(
            //     bottom: 35.h,
            //     left: 160.w,
            //     right: 160.w,
            //     child: Container(
            //       height: 55.h,
            //       decoration: const BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: Colors.white,
            //       ),
            //     )),
            Positioned(
              bottom: 30.h,
              left: 160.w,
              right: 160.w,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 4;
                    Get.to(
                      () => Home(),
                      transition: Transition.fadeIn,
                      curve: Curves.easeIn,
                      duration: const Duration(milliseconds: 600),
                    );
                  });
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) {
                  //   return Home();
                  // }));
                },
                child: Container(
                  height: 55.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 1.w,
                      color: const Color.fromARGB(20, 0, 0, 0),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(15.h),
                    child: Align(
                      child: Image.asset(
                        "assets/apartment_history/HomeIcon.png",
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _receit
                ? Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _height = 0;
                          _receit = false;
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                    ),
                  )
                : const Visibility(
                    visible: true,
                    child: Placeholder(color: Colors.transparent),
                  ),
            Positioned(bottom: 0, left: 0, right: 0, child: receit()),
          ],
        ),
      ),
    );
  }
}
