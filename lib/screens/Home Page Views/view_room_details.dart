import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_campus/screens/Home%20Page%20Views/home.dart';
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
                  height: 120.h,
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
                              "GHc 2,000",
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
                                    "GHc 1,800",
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
                                    "GHc 200",
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
                        () => const Home(),
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

  Widget amenities() {
    return Align(
      child: AnimatedContainer(
        height: height,
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
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 5.h),
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
                Text(
                  "Amenities",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
                const Divider(color: Color.fromRGBO(120, 120, 120, 0.3)),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.45,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/view_room_details/bed.png",
                                width: 25.w,
                                height: 25.h,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Bed",
                                style: TextStyle(fontFamily: "Poppins"),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Image.asset(
                                "assets/view_room_details/kitchen.png",
                                width: 25.w,
                                height: 25.h,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Kitchen",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Image.asset(
                                "assets/view_room_details/air.png",
                                width: 25.w,
                                height: 25.h,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Air condition",
                                style: TextStyle(fontFamily: "Poppins"),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Image.asset(
                                "assets/view_room_details/closet.png",
                                width: 25.w,
                                height: 25.h,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Wardrobe",
                                style: TextStyle(fontFamily: "Poppins"),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Image.asset(
                                "assets/view_room_details/sports.png",
                                width: 25.w,
                                height: 25.h,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Sports field",
                                style: TextStyle(fontFamily: "Poppins"),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Image.asset(
                                "assets/view_room_details/dining-table.png",
                                width: 25.w,
                                height: 25.h,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Outdoor Courtyard",
                                style: TextStyle(fontFamily: "Poppins"),
                              ),
                            ],
                          ),
                          // SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.45,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/view_room_details/study desk.png",
                                width: 25.w,
                                height: 25.h,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Study desk",
                                style: TextStyle(fontFamily: "Poppins"),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Image.asset(
                                "assets/view_room_details/mirror.png",
                                width: 25.w,
                                height: 25.h,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Mirror",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Image.asset(
                                "assets/view_room_details/game-pad.png",
                                width: 25.w,
                                height: 25.h,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Gaming room",
                                style: TextStyle(fontFamily: "Poppins"),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Image.asset(
                                "assets/view_room_details/market.png",
                                width: 25.w,
                                height: 25.h,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Market",
                                style: TextStyle(fontFamily: "Poppins"),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Image.asset(
                                // "assets/view_room_details/bathtub.png",
                                "assets/view_room_details/sink.png",
                                width: 25.w,
                                height: 25.h,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Shower",
                                style: TextStyle(fontFamily: "Poppins"),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Image.asset(
                                "assets/view_room_details/sink.png",
                                width: 25.w,
                                height: 25.h,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Sink",
                                style: TextStyle(fontFamily: "Poppins"),
                              ),
                            ],
                          ),
                          // SizedBox(height: 20),
                        ],
                      ),
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
            padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 5.h),
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
                Text(
                  "My room info",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                const Divider(color: Color.fromRGBO(120, 120, 120, 0.3)),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Albert-Acquah hall",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text("Room number 134"),
                    SizedBox(height: 15.h),
                    Text("Second floor "),
                    SizedBox(height: 15.h),
                    Text("Females only"),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text("4 in a room"),
                        SizedBox(width: 5.w),
                        Icon(Icons.groups_outlined),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 15),
                        SizedBox(width: 5.w),
                        Text(
                          "1995 Broadway, Kenyase",
                          style: TextStyle(fontSize: 10.sp),
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
      child: SafeArea(
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
                    padding: EdgeInsets.only(top: 20.h),
                    foregroundDecoration: BoxDecoration(
                      color: _receit | _amenities | _roomInfo
                          ? Colors.black.withOpacity(0.5)
                          : null,
                    ),
                    // color:Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // The back button, Text[Room details] and the emoji container
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 25.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              Container(
                                child: Text(
                                  "Room details",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.sp,
                                    // letterSpacing: 0.15.w,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              // the emoji Icon
                              Icon(Icons.emoji_emotions_outlined, size: 24.h),
                            ],
                          ),
                        ),
                        // space //
                        SizedBox(height: 15.h),
                        // text[My room info] container
                        Container(
                          margin: EdgeInsets.only(left: 15.h),
                          child: Text(
                            "My room info",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        // space
                        // SizedBox(height: 10.h,),
                        // Room picture and Room details Container
                        Container(
                          margin: EdgeInsets.only(left: 15.h),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 124.h,
                                width: 118.w,
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
                                margin: EdgeInsets.only(top: 20.h),
                                width: 170.w,
                                // color: Colors.blue,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Text widget
                                    Container(
                                      child: Text(
                                        "Albert-Acquah hall",
                                        style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    // space
                                    SizedBox(height: 10.h),

                                    // Room number
                                    Container(
                                      child: Text(
                                        "Room Number 134",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    // space
                                    SizedBox(height: 10.h),
                                    // Room capacity container
                                    Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            "4 in a room ",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/view_room_details/people.png",
                                            height: 24.h,
                                            width: 24.w,
                                          ),
                                        ],
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
                                            color: Colors.black.withOpacity(
                                              0.6,
                                            ),
                                          ),
                                          Text(
                                            "Broadway, Kenyasi",
                                            style: TextStyle(
                                              fontFamily: "Roboto",
                                              fontSize: 10.sp,
                                              color: Colors.black.withOpacity(
                                                0.6,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // space
                                    SizedBox(height: 10.h),
                                    Container(
                                      child: FilledButton(
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
                                                Color.fromARGB(
                                                  255,
                                                  0,
                                                  239,
                                                  209,
                                                ),
                                              ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            roomInfoHeight =
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.4;
                                            _roomInfo = true;
                                          });
                                        },
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // space
                        SizedBox(height: 20.h),
                        Container(
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(horizontal: 15.h),
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          height: 50.h,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Booked duration",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15.sp,
                                ),
                              ),
                              SizedBox(width: 70.w),
                              Container(
                                width: 2,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              SizedBox(width: 70.w),
                              Text(
                                "one year",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15.h),
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
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Booking Date",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    Text(
                                      "August 08, 2024 | 4.40 PM",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15.sp,
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
                                    Text(
                                      "Check In",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    Text(
                                      "August 08, 2024",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15.sp,
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
                                    Text(
                                      "Check Out",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    Text(
                                      "August 08, 2025",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15.sp,
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
                                    Text(
                                      "Tenant",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    Text(
                                      "04",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Divider(color: Colors.black.withOpacity(0.5)),
                              SizedBox(height: 10.h),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Amount",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    Text(
                                      "GHC 1,800",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15.sp,
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
                                    Text(
                                      "Tax & Fees",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    Text(
                                      "GHC 200",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15.sp,
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
                                    Text(
                                      "Total",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    Text(
                                      "GHC 2,000",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15.sp,
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
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
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
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Paid",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15.sp,
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.h,
                    vertical: 5.h,
                  ),
                  width: double.infinity,
                  height: 60.h,
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
                      setState(() {
                        height = MediaQuery.of(context).size.height * 0.5;
                        _amenities = true;
                      });
                    },
                    child: Text(
                      "Amenities",
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
              Positioned(bottom: 0, left: 0, right: 0, child: amenities()),
            ],
          ),
        ),
      ),
    );
  }
}
