import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:on_campus/screens/Home%20Page%20Views/home.dart';
import 'package:on_campus/screens/bottom_nav.dart';
// import 'package:on_campus/screens/Home%20Page%20Views/home.dart';

class ViewRoomDetails extends StatefulWidget {
  const ViewRoomDetails({super.key});

  @override
  State<ViewRoomDetails> createState() => _ViewRoomDetailsState();
}

bool _receit = false;
bool _amenities = false;
bool _roomInfo = false;

class _ViewRoomDetailsState extends State<ViewRoomDetails> {
  double _height = 0;
  double height = 0;
  double roomInfoHeight = 0;
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
                  height: Constant.height * 0.16,
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
                            SizedBox(
                              height: Constant.height * 0.03,
                              child: FittedBox(
                                child: Text(
                                  "Payment Success",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp,
                                    color: const Color(0xFF00EFD1),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              height: Constant.height * 0.04,
                              child: FittedBox(
                                child: Text(
                                  "GH₵ 2,000",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 28.sp,
                                    // color: const Color(0xFF00EFD1),
                                  ),
                                ),
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
                SizedBox(height: 40.h),
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
                          child: SizedBox(
                            height: Constant.height * 0.025,
                            child: FittedBox(
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
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Ref Number",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                          color: const Color(0xFF707070),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "000085752257",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Payment Time",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                          color: const Color(0xFF707070),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "17-08-2024, 04:40:17",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Payment Method",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                          color: const Color(0xFF707070),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Mobile Money",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Sender Name",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                          color: const Color(0xFF707070),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Antonio Roberto",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                        ),
                                      ),
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
                              height: 25.h,
                              width: double.infinity,
                              child: Align(
                                child: Text(
                                  "------------------------------------------------------------------------------------------------------",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    color: const Color.fromRGBO(0, 0, 0, 0.03),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Amount",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                          color: const Color(0xFF707070),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "GH₵ 1,800",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Admin Fee",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                          color: const Color(0xFF707070),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "GH₵ 20",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Payment Status",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                          color: const Color(0xFF707070),
                                        ),
                                      ),
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
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF00EFD1)),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  height: Constant.height * 0.06,
                  child: Align(
                    child: SizedBox(
                      height: Constant.height * 0.025,
                      child: FittedBox(
                        child: Row(
                          children: [
                            SizedBox(
                              height: Constant.height * 0.025,
                              child: Image.asset(
                                "assets/view_room_details/import.png",
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            SizedBox(
                              height: Constant.height * 0.025,
                              child: FittedBox(
                                child: Text(
                                  " Get PDF Receit",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: const Color(0xFF00EFD1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
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
                SizedBox(height: 5.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25.h),
                  width: double.infinity,
                  height: Constant.height * 0.06,
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
                        () => const BottomNav(username: "Godfred"),
                        transition: Transition.fadeIn,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeIn,
                      );
                      _receit = false;
                    },
                    child: SizedBox(
                      height: Constant.height * 0.025,
                      child: FittedBox(
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget amenities() {
  //   return Align(
  //     child: AnimatedContainer(
  //       height: height,
  //       curve: Curves.easeIn,
  //       duration: const Duration(milliseconds: 400),
  //       decoration: BoxDecoration(
  //         // color: const Color(0xFFF5F8FF),
  //         color: const Color(0xFFF5F8FF),
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(25.r),
  //           topRight: Radius.circular(25.r),
  //         ),
  //       ),
  //       child: SingleChildScrollView(
  //         child: Container(
  //           padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 5.h),
  //           width: double.infinity,
  //           child: Column(
  //             children: [
  //               Container(
  //                 height: 5.h,
  //                 width: 30.w,
  //                 decoration: BoxDecoration(
  //                   color: const Color(0xFF79747E),
  //                   borderRadius: BorderRadius.circular(100.r),
  //                 ),
  //               ),
  //               SizedBox(height: 15.h),
  //               Text(
  //                 "Amenities",
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                   fontFamily: "Poppins",
  //                   fontWeight: FontWeight.w500,
  //                   fontSize: 16.sp,
  //                 ),
  //               ),
  //               const Divider(color: Color.fromRGBO(120, 120, 120, 0.3)),
  //               SizedBox(height: 20),
  //               Row(
  //                 children: [
  //                   SizedBox(
  //                     width: MediaQuery.sizeOf(context).width * 0.45,
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       children: [
  //                         Row(
  //                           children: [
  //                             Image.asset(
  //                               "assets/view_room_details/bed.png",
  //                               width: 25.w,
  //                               height: 25.h,
  //                             ),
  //                             SizedBox(width: 5.w),
  //                             Text(
  //                               "Bed",
  //                               style: TextStyle(fontFamily: "Poppins"),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(height: 20.h),
  //                         Row(
  //                           children: [
  //                             Image.asset(
  //                               "assets/view_room_details/kitchen.png",
  //                               width: 25.w,
  //                               height: 25.h,
  //                             ),
  //                             SizedBox(width: 5.w),
  //                             Text(
  //                               "Kitchen",
  //                               style: TextStyle(
  //                                 fontFamily: "Poppins",
  //                                 fontWeight: FontWeight.w500,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(height: 20.h),
  //                         Row(
  //                           children: [
  //                             Image.asset(
  //                               "assets/view_room_details/air.png",
  //                               width: 25.w,
  //                               height: 25.h,
  //                             ),
  //                             SizedBox(width: 5.w),
  //                             Text(
  //                               "Air condition",
  //                               style: TextStyle(fontFamily: "Poppins"),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(height: 20.h),
  //                         Row(
  //                           children: [
  //                             Image.asset(
  //                               "assets/view_room_details/closet.png",
  //                               width: 25.w,
  //                               height: 25.h,
  //                             ),
  //                             SizedBox(width: 5.w),
  //                             Text(
  //                               "Wardrobe",
  //                               style: TextStyle(fontFamily: "Poppins"),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(height: 20.h),
  //                         Row(
  //                           children: [
  //                             Image.asset(
  //                               "assets/view_room_details/sports.png",
  //                               width: 25.w,
  //                               height: 25.h,
  //                             ),
  //                             SizedBox(width: 5.w),
  //                             Text(
  //                               "Sports field",
  //                               style: TextStyle(fontFamily: "Poppins"),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(height: 20.h),
  //                         Row(
  //                           children: [
  //                             Image.asset(
  //                               "assets/view_room_details/dining-table.png",
  //                               width: 25.w,
  //                               height: 25.h,
  //                             ),
  //                             SizedBox(width: 5.w),
  //                             Text(
  //                               "Outdoor Courtyard",
  //                               style: TextStyle(fontFamily: "Poppins"),
  //                             ),
  //                           ],
  //                         ),
  //                         // SizedBox(height: 20.h),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: MediaQuery.sizeOf(context).width * 0.45,
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       children: [
  //                         Row(
  //                           children: [
  //                             Image.asset(
  //                               "assets/view_room_details/study desk.png",
  //                               width: 25.w,
  //                               height: 25.h,
  //                             ),
  //                             SizedBox(width: 5.w),
  //                             Text(
  //                               "Study desk",
  //                               style: TextStyle(fontFamily: "Poppins"),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(height: 20.h),
  //                         Row(
  //                           children: [
  //                             Image.asset(
  //                               "assets/view_room_details/mirror.png",
  //                               width: 25.w,
  //                               height: 25.h,
  //                             ),
  //                             SizedBox(width: 5.w),
  //                             Text(
  //                               "Mirror",
  //                               style: TextStyle(
  //                                 fontFamily: "Poppins",
  //                                 fontWeight: FontWeight.w500,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(height: 20.h),
  //                         Row(
  //                           children: [
  //                             Image.asset(
  //                               "assets/view_room_details/game-pad.png",
  //                               width: 25.w,
  //                               height: 25.h,
  //                             ),
  //                             SizedBox(width: 5.w),
  //                             Text(
  //                               "Gaming room",
  //                               style: TextStyle(fontFamily: "Poppins"),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(height: 20.h),
  //                         Row(
  //                           children: [
  //                             Image.asset(
  //                               "assets/view_room_details/market.png",
  //                               width: 25.w,
  //                               height: 25.h,
  //                             ),
  //                             SizedBox(width: 5.w),
  //                             Text(
  //                               "Market",
  //                               style: TextStyle(fontFamily: "Poppins"),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(height: 20.h),
  //                         Row(
  //                           children: [
  //                             Image.asset(
  //                               // "assets/view_room_details/bathtub.png",
  //                               "assets/view_room_details/sink.png",
  //                               width: 25.w,
  //                               height: 25.h,
  //                             ),
  //                             SizedBox(width: 5.w),
  //                             Text(
  //                               "Shower",
  //                               style: TextStyle(fontFamily: "Poppins"),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(height: 20.h),
  //                         Row(
  //                           children: [
  //                             Image.asset(
  //                               "assets/view_room_details/sink.png",
  //                               width: 25.w,
  //                               height: 25.h,
  //                             ),
  //                             SizedBox(width: 5.w),
  //                             Text(
  //                               "Sink",
  //                               style: TextStyle(fontFamily: "Poppins"),
  //                             ),
  //                           ],
  //                         ),
  //                         // SizedBox(height: 20),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget roomInfo() {
    return Align(
      child: AnimatedContainer(
        height: roomInfoHeight,
        curve: Curves.easeIn,
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
            padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 10.h),
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  height: 5.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF79747E),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
                SizedBox(height: 15.h),
                SizedBox(
                  height: Constant.height * 0.03,
                  child: FittedBox(
                    child: Text(
                      "My room info",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                const Divider(color: Color.fromRGBO(120, 120, 120, 0.1)),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        // color: Colors.red,
                        height: Constant.height * 0.03,
                        width: Constant.width ,
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Albert-Acquah hall",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    SizedBox(
                      height: Constant.height * 0.025,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Room number 134",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFF323232)
                          )
                          )),
                    ),
                    SizedBox(height: 15.h),
                    SizedBox(
                      height: Constant.height * 0.025,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Second Floor",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFF323232)
                          )
                          )),
                    ),
                    SizedBox(height: 15.h),
                    SizedBox(
                      height: Constant.height * 0.025,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Females only",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFF323232)
                          )
                          )),
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        SizedBox(
                      height: Constant.height * 0.025,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "4 in a room",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFF323232)
                          )
                          )),
                    ),
                        SizedBox(width: 5.w),
                        Icon(Icons.groups_outlined, color: Color(0xFF323232)),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 15),
                        SizedBox(width: 5.w),
                        SizedBox(
                      height: Constant.height * 0.02,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "1995 Broadway, Kenyase",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFF323232)
                          )
                          )),
                    ),
                      ],
                    ),
                  ],
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
    return PopScope(
      canPop: _amenities | _receit | _roomInfo ? false : true,
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
                  padding: EdgeInsets.only(
                    top: Constant.height * 0.06,
                    left: 25.h,
                    right: 25.h,
                  ),
                  // margin: EdgeInsets.symmetric(horizontal: 25.h),
                  foregroundDecoration: BoxDecoration(
                    color: _receit | _amenities | _roomInfo
                        ? const Color.fromRGBO(0, 0, 0, 0.5)
                        : null,
                  ),
                  // color:Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // The back button, Text[Room details] and the emoji container
                      Container(
                        // margin: EdgeInsets.symmetric(horizontal: 20.h),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // the back button container
                            Container(
                              height: 40.h,
                              width: 40.w,
                              foregroundDecoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.03),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.chevron_left,
                                  color: Colors.black,
                                  size: 24.w,
                                ),
                              ),
                            ),
                            // the text[Room details] container
                            Expanded(
                              child: SizedBox(
                                // color: Colors.red,
                                height: Constant.height * 0.03,
                                child: FittedBox(
                                  child: Text(
                                    "My room info",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.sp,
                                      // letterSpacing: 0.15.w,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // the emoji Icon
                            // Icon(Icons.emoji_emotions_outlined, size: 24.h),
                          ],
                        ),
                      ),
                      // space //
                      SizedBox(height: 15.h),
                      // text[My room info] container

                      // space
                      // SizedBox(height: 10.h,),
                      // Room picture and Room details Container
                      Container(
                        margin: EdgeInsets.only(top: 25.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              // alignment: Alignment.topLeft,
                              height: Constant.height * 0.17,
                              width: Constant.width * 0.32,
                              // color: Colors.red,
                              child: const CircleAvatar(
                                backgroundImage: AssetImage(
                                  "assets/view_room_details/user logo.png",
                                ),
                              ),
                            ),
                            // space
                            SizedBox(width: 15.h),
                            // The Room info on the right side of the room Image
                            Container(
                              // margin: EdgeInsets.only(top: 5.h),
                              width: Constant.width * 0.5,
                              // color: Colors.blue,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Text widget
                                  Container(
                                    height: Constant.height * 0.03,
                                    width: Constant.width * 0.55,
                                    child: SizedBox(
                                      child: FittedBox(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Albert-Acquah hall",
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF0E7A63),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // space
                                  // SizedBox(height: 10.h),
                                  SizedBox(height: 5.h),
                                  // Room number
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Room Number 134",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF0E7A63),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // space
                                  SizedBox(height: 5.h),
                                  // Room capacity container
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/view_room_details/people.png",
                                            height: 24.h,
                                            width: 24.w,
                                            color: Color(0xFF0E7A63),
                                          ),
                                          Text(
                                            " 4 in a room ",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 15.sp,
                                              color: Color(0xFF0E7A63),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // space
                                  SizedBox(height: 10.h),
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.room_outlined,
                                          size: 14.h,
                                          color: Color(0xFF0E7A63),
                                        ),
                                        Text(
                                          " Broadway, Kenyasi",
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 10.sp,
                                            color: Color(0xFF0E7A63),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // space
                                  SizedBox(height: 10.h),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        roomInfoHeight = Constant.height * 0.4;
                                      _roomInfo = true;
                                      });
                                    },
                                    child: Container(
                                      width: Constant.width * 0.2,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15.w,
                                        vertical: 5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF00EFD1),
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                      ),
                                      child: Align(
                                        child: SizedBox(
                                          height: Constant.height * 0.025,
                                          child: FittedBox(
                                            child: Text(
                                              "View More",
                                              style: TextStyle(
                                                fontFamily: "Roboto",
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.sp,
                                              ),
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
                      // space
                      SizedBox(height: 20.h),
                      Container(
                        // color: Colors.white,
                        // margin: EdgeInsets.symmetric(horizontal: 15.h),
                        // padding: EdgeInsets.symmetric(horizontal: 10.h),
                        height: Constant.height * 0.07,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          // color: Colors.red,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: Constant.height * 0.022,
                                width: Constant.width * 0.5 - 20.h,
                                child: FittedBox(
                                  child: Text(
                                    "Booked duration",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(width: 70.w),
                              Container(
                                width: 2,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              // SizedBox(width: 70.w),
                              Expanded(
                                child: SizedBox(
                                  height: Constant.height * 0.022,
                                  child: FittedBox(
                                    child: Text(
                                      "1 (one) academic year",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        // margin: EdgeInsets.symmetric(horizontal: 15.h),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.h,
                          vertical: 20.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                              color: Colors.black.withOpacity(0.25),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Booking Date",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "August 08, 2024 | 4.40 PM",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Move In",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "August 08, 2024",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Move Out",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "August 08, 2026",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Tenant",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "04 person",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Divider(color: Colors.black.withOpacity(0.5)),
                            SizedBox(height: 10.h),
                            SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Amount",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "GH₵ 2,000",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Tax & Fees",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "GH₵ 200",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Total",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "GH₵ 2,200",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FilledButton(
                                    style: ButtonStyle(
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20.r),
                                          ),
                                        ),
                                      ),
                                      backgroundColor:
                                          const WidgetStatePropertyAll(
                                            Color.fromARGB(255, 0, 239, 209),
                                          ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _height =
                                            MediaQuery.of(context).size.height *
                                            0.85;
                                        _receit = true;
                                      });
                                    },
                                    child: Text(
                                      "View Receit",
                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Paid",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
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
                      SizedBox(height: 180.h),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 15.h),
                width: double.infinity,
                height: Constant.height * 0.1,
                child: SizedBox(
                  height: Constant.height * 0.06,
                  child: FilledButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        ),
                      ),
                      backgroundColor: const WidgetStatePropertyAll(
                        Color.fromARGB(255, 0, 239, 209),
                      ),
                    ),
                    onPressed: () {
                      // setState(() {
                      //   height = MediaQuery.of(context).size.height * 0.5;
                      //   _amenities = true;
                      // });
                    },
                    child: Align(
                      child: SizedBox(
                        height: Constant.height * 0.025,
                        child: FittedBox(
                          child: Text(
                            "Extend Stay",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
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
                      child: SizedBox(
                        // color: Colors.transparent,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                    ),
                  )
                : const Visibility(
                    visible: true,
                    child: Placeholder(color: Colors.transparent),
                  ),
            _amenities
                ? Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          height = 0;
                          _amenities = false;
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.5,
                      ),
                    ),
                  )
                : const Visibility(
                    visible: true,
                    child: Placeholder(color: Colors.transparent),
                  ),
            _roomInfo
                ? Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          roomInfoHeight = 0;
                          _roomInfo = false;
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                        // color: Colors.blue,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.6,
                      ),
                    ),
                  )
                : const Visibility(
                    visible: true,
                    child: Placeholder(color: Colors.transparent),
                  ),
            Positioned(bottom: 0, left: 0, right: 0, child: roomInfo()),
            Positioned(bottom: 0, left: 0, right: 0, child: receit()),
            // Positioned(bottom: 0, left: 0, right: 0, child: amenities()),
          ],
        ),
      ),
    );
  }
}
