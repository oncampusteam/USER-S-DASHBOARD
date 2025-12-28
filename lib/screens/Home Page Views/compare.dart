import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:on_campus/classes/hostel.dart';

class Compare extends StatefulWidget {
  final String username;
  const Compare({super.key, required this.username});

  @override
  State<Compare> createState() => _CompareState();
}

class _CompareState extends State<Compare> {
  int selectedIndex = 2;
  TextEditingController searchController = TextEditingController();

  List<Hostel> hostels = [
    Hostel(
        imageUrl: "assets/compare/hostel-1.png",
        hotelName: "Albert-Acquah Hall",
        location: "Kenyasi",
        roomCapacity: 4,
        price: "2,000",
        rate: "4.5",
        category: "Popular"),
    Hostel(
        imageUrl: "assets/compare/hostel-2.png",
        hotelName: "Ultimate Hostel",
        location: "Kenyasi",
        roomCapacity: 4,
        price: "4,000",
        rate: "4.5",
        category: "Popular"),
    Hostel(
        imageUrl: "assets/compare/hostel-3.png",
        hotelName: "Adom Hostel",
        location: "Kenyasi",
        roomCapacity: 2,
        price: "1,500",
        rate: "4.5",
        category: "Popular"),
    Hostel(
        imageUrl: "assets/compare/hostel-4.png",
        hotelName: "Albert-Acquah Hall",
        location: "Kenyasi",
        roomCapacity: 4,
        price: "2,000",
        rate: "4.5",
        category: "Popular"),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 20.h),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // compare container////////////////////////
                          Container(
                              margin: EdgeInsets.only(left: 15.h, right: 15.h),
                              // color: Colors.blue,
                              width: MediaQuery.of(context).size.width,
                              height: 50.h,
                              child: Row(
                                children: [
                                  Container(
                                      height: 40.h,
                                      width: 40.w,
                                      foregroundDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          color: const Color.fromARGB(
                                              10, 0, 0, 0)),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.r)),
                                      child: Icon(Icons.chevron_left,
                                          size: 24.sp)),
                                  SizedBox(
                                    width: 70.h,
                                  ),
                                  Text("Compare Hostels",
                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.sp,
                                      )),
                                ],
                              )),
                          SizedBox(
                            height: 5.h,
                          ),
                          // search container /////////////
                          Container(
                              height: 40.h,
                              width: 345.w,
                              margin: EdgeInsets.only(
                                  top: 10.h, right: 15.h, left: 15.h),
                              padding: EdgeInsets.only(left: 10.h),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(
                                          0.3), // Shadow color with opacity
                                      spreadRadius:
                                          -5, // Spread radius (expands the shadow)
                                      blurRadius:
                                          8, // Blur radius (softness of the shadow)
                                      offset: const Offset(
                                          0, 5), // Offset in X and Y direction
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(50.r),
                                  border: Border.all(
                                      width: 1.w,
                                      color:
                                          const Color.fromARGB(30, 0, 0, 0))),
                              child: Row(
                                children: [
                                  const Icon(Icons.search,
                                      color: Color(0xFF00EFD1)),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text("Search ...",
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14.sp,
                                      ))
                                ],
                              )
                              // TextField(
                              //   controller: searchController,
                              //   decoration: InputDecoration(
                              //       fillColor: Colors.white,
                              //       hintText: "Search ...",
                              //       hintStyle: TextStyle(
                              //         fontFamily: "Work Sans",
                              //         fontSize: 14.sp,
                              //       ),
                              //       prefixIcon: const Icon(Icons.search, color: Color(0xFF00EFD1)),
                              //       focusedBorder:
                              //           const OutlineInputBorder(borderSide: BorderSide.none),
                              //       border: const OutlineInputBorder(
                              //         borderSide: BorderSide.none,
                              //       )),
                              // ),
                              ),
                          SizedBox(
                            height: 5.h,
                          ),
                          // Enter hostel name ////////////////////////
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                margin:
                                    EdgeInsets.only(left: 15.h, right: 15.h),
                                child: Text("Enter hostel name or location",
                                    style: TextStyle(
                                      color: const Color.fromARGB(80, 0, 0, 0),
                                      fontFamily: "Roboto",
                                      fontSize: 12.sp,
                                    ))),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          // Select hostel containers //////////////////////////
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.only(left: 15.h, right: 15.h),
                              height: 35,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: hostels.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(
                                        () {},
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 8.h),
                                      decoration: BoxDecoration(
                                        // color: Color(0XFF00EFD1),
                                        border: Border.all(
                                            width: 1,
                                            color: const Color(0XFF00EFD1)),
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                      ),
                                      // height: 40.h,
                                      width: 80.w,
                                      child: Align(
                                        child: Text(
                                          "Hostel ${index + 1}",
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 12.sp,
                                            color: const Color(0XFF00EFD1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          SizedBox(
                              height: 2100.h,
                              child: ListView.builder(
                                  itemCount: hostels.length,
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (BuildContext context, index) {
                                    return Container(
                                      width: 360.w,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFFFFF),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      padding: EdgeInsets.only(
                                          right: 2.h, left: 2.h),
                                      margin: index == 0
                                          ? EdgeInsets.only(
                                              left: 10.h, right: 2.h)
                                          : EdgeInsets.only(
                                              left: 2.h, right: 2.h),
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 5, right: 5.h),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // SizedBox(height: 5.h,),
                                            // Image Container
                                            ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15.r),
                                              ),
                                              child: SizedBox(
                                                height: 400.h,
                                                width: 360.w,
                                                child: Image.asset(
                                                    hostels[index].imageUrl,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Container(
                                              margin: index == 0
                                                  ? EdgeInsets.only(left: 10.h)
                                                  : EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    hostels[index].hotelName,
                                                    style: TextStyle(
                                                        fontFamily: "Roboto",
                                                        fontSize: 16.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        size: 19.h,
                                                        color: const Color(
                                                            0XFF00EFD1),
                                                      ),
                                                      Text(
                                                        " 4.4",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.room_outlined,
                                                      color:
                                                          const Color.fromARGB(
                                                              80, 0, 0, 0),
                                                      size: 10.sp),
                                                  Text(
                                                    "1995 Broadway, ${hostels[index].location}",
                                                    style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                              80, 0, 0, 0),
                                                      fontFamily: "Roboto",
                                                      fontSize: 10.sp,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Container(
                                              width: 360.w,
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Text(
                                                "Welcome to the resort paradise we ensure the best service during your stay in bali with an emphasis on customer...",
                                                style: TextStyle(
                                                    color: const Color.fromARGB(
                                                        80, 0, 0, 0),
                                                    fontFamily: "Poppins",
                                                    fontSize: 12.sp,
                                                    overflow:
                                                        TextOverflow.visible),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "20% off",
                                                    style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: const Color(
                                                          0XFF00EFD1),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      // Image.asset("warning.png", height: 12, width: 10,),
                                                      Transform.flip(
                                                          flipY: true,
                                                          child: const Icon(
                                                            Icons.info,
                                                            color: Colors.red,
                                                          )),
                                                      Text(" 7 Slots available",
                                                          style: TextStyle(
                                                            color: const Color
                                                                .fromARGB(
                                                                180, 0, 0, 0),
                                                            fontFamily:
                                                                "Roboto",
                                                            fontSize: 13.sp,
                                                          ))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(left: 5.h),
                                                child: Text("Amenities",
                                                    style: TextStyle(
                                                        fontFamily: "Roboto",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18.sp))),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            // wifi ///
                                            Container(
                                              height: 40.h,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              20, 0, 0, 0)))),
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          "assets/compare/wifi.png",
                                                          height: 24.h,
                                                          width: 24.w),
                                                      Text(" Wifi",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  Text("Yes",
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp))
                                                ],
                                              ),
                                            ),
                                            // Kitchen
                                            Container(
                                              height: 40.h,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              20, 0, 0, 0)))),
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          "assets/compare/kitchen.png",
                                                          height: 24.h,
                                                          width: 24.w,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high),
                                                      Text(" Kitchen",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  Text("Included",
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp)),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 40.h,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              20, 0, 0, 0)))),
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          "assets/compare/bed.png",
                                                          height: 24.h,
                                                          width: 24.w,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high),
                                                      Text(" Bed",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  Text("Available",
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 40.h,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              20, 0, 0, 0)))),
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          "assets/compare/bathtub.png",
                                                          height: 24.h,
                                                          width: 24.w,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high),
                                                      Text(" Shower",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  Text("Available",
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 40.h,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              20, 0, 0, 0)))),
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          "assets/compare/electricity.png",
                                                          height: 22.h,
                                                          width: 24.w,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high),
                                                      Text(" Electricity",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  Text("Available",
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 40.h,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              20, 0, 0, 0)))),
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          "assets/compare/tap.png",
                                                          height: 24.h,
                                                          width: 24.w,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high),
                                                      Text(" Water",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  Text("Available",
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 40.h,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              20, 0, 0, 0)))),
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          "assets/compare/house.png",
                                                          height: 20.h,
                                                          width: 17.w,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high),
                                                      Text(" House Keeping",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  Text("Available",
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 40.h,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              20, 0, 0, 0)))),
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          "assets/compare/bus.png",
                                                          height: 24.h,
                                                          width: 24.w,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high),
                                                      Text(" Bus",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  Text("Available",
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 40.h,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              20, 0, 0, 0)))),
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          "assets/compare/desk.png",
                                                          height: 24.h,
                                                          width: 24.w,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high),
                                                      Text(" Study Desk",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  Text("Available",
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 40.h,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              20, 0, 0, 0)))),
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          "assets/compare/closet.png",
                                                          height: 24.h,
                                                          width: 24.w,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high),
                                                      Text(" Wardrobe",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  Text("Available",
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 40.h,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              20, 0, 0, 0)))),
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          "assets/compare/sports.png",
                                                          height: 24.h,
                                                          width: 24.w,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high),
                                                      Text(" Sports Field",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  Text("Available",
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 40.h,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              20, 0, 0, 0)))),
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          "assets/compare/air.png",
                                                          height: 24.h,
                                                          width: 24.w,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high),
                                                      Text(" Air Condition",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  Text("Available",
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 40.h,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              20, 0, 0, 0)))),
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        "assets/compare/sink.png",
                                                        height: 24.h,
                                                        width: 24.w,
                                                        filterQuality:
                                                            FilterQuality.high,
                                                      ),
                                                      Text(" Sink",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  Text("Available",
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 40.h,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              20, 0, 0, 0)))),
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          "assets/compare/market.png",
                                                          height: 24.h,
                                                          width: 24.w,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high),
                                                      Text(" Market",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  Text("Available",
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 40.h,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              20, 0, 0, 0)))),
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          "assets/compare/game-pad.png",
                                                          height: 24.h,
                                                          width: 24.w,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high),
                                                      Text(" Gaming Room",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  Text("Available",
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 40.h,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              20, 0, 0, 0)))),
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          "assets/compare/mirror.png",
                                                          height: 24.h,
                                                          width: 24.w,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high),
                                                      Text(" Mirror",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  Text("Available",
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 40.h,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              20, 0, 0, 0)))),
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Image.asset(
                                                      "assets/compare/view_less.png",
                                                      height: 24.h,
                                                      width: 24.w,
                                                      filterQuality:
                                                          FilterQuality.high),
                                                  Text("  View less",
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(left: 5.h),
                                                child: Text("Prices",
                                                    style: TextStyle(
                                                        fontFamily: "Roboto",
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black))),
                                            SizedBox(height: 15.h),
                                            Container(
                                              height: 40.h,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              20, 0, 0, 0)))),
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          "assets/compare/people.png",
                                                          height: 24.h,
                                                          width: 24.w,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high),
                                                      Text(" 1 in a room",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  Text("₵ 7,000",
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 40.h,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              20, 0, 0, 0)))),
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          "assets/compare/people.png",
                                                          height: 24.h,
                                                          width: 24.w,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high),
                                                      Text(" 2 in a room",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  Text("₵ 3,500",
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 40.h,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              20, 0, 0, 0)))),
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          "assets/compare/people.png",
                                                          height: 24.h,
                                                          width: 24.w,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high),
                                                      Text(" 3 in a room",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  Text("₵ 2,000",
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 40.h,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              20, 0, 0, 0)))),
                                              margin:
                                                  EdgeInsets.only(left: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          "assets/compare/people.png",
                                                          height: 24.h,
                                                          width: 24.w,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high),
                                                      Text(" 4 in a room",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
                                                    ],
                                                  ),
                                                  Text("₵ 1,500",
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp))
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 15.h),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(left: 5.h),
                                                child: Text("Reviews",
                                                    style: TextStyle(
                                                        fontFamily: "Roboto",
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black))),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            Container(
                                              height: 100.h,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.h,
                                                  vertical: 10.h),
                                              foregroundDecoration:
                                                  BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.r),
                                                      color:
                                                          const Color.fromARGB(
                                                              10, 0, 0, 0)),
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                // border: Border.all(width: 1, color: const Color.fromARGB(20, 0, 0, 0))
                                              ),
                                              margin: EdgeInsets.only(
                                                  left: 5.h, bottom: 5.h),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 20.h,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const SizedBox(
                                                              height: 24,
                                                              width: 24,
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        "assets/compare/no_picture.jpeg"),
                                                              ),
                                                            ),
                                                            Text(" User 1",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Roboto",
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500))
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(Icons.star,
                                                                color: const Color(
                                                                    0xFFFFC700),
                                                                size: 10.h),
                                                            Icon(Icons.star,
                                                                color: const Color(
                                                                    0xFFFFC700),
                                                                size: 10.h),
                                                            Icon(Icons.star,
                                                                color: const Color(
                                                                    0xFFFFC700),
                                                                size: 10.h),
                                                            Icon(Icons.star,
                                                                color: const Color(
                                                                    0xFFFFC700),
                                                                size: 10.h),
                                                            Icon(Icons.star,
                                                                color: const Color(
                                                                    0xFFFFC700),
                                                                size: 10.h),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  SizedBox(
                                                    height: 55.h,
                                                    child: Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                            "Great Hostel!",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              color:
                                                                  Colors.black,
                                                            ))),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 100.h,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.h,
                                                  vertical: 10.h),
                                              foregroundDecoration:
                                                  BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.r),
                                                      color:
                                                          const Color.fromARGB(
                                                              10, 0, 0, 0)),
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                // border: Border.all(width: 1, color: const Color.fromARGB(20, 0, 0, 0))
                                              ),
                                              margin: EdgeInsets.only(
                                                  left: 5.h, bottom: 5.h),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 20.h,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const SizedBox(
                                                              height: 24,
                                                              width: 24,
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        "assets/compare/no_picture.jpeg"),
                                                              ),
                                                            ),
                                                            Text(" User 2",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Roboto",
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500))
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(Icons.star,
                                                                color: const Color(
                                                                    0xFFFFC700),
                                                                size: 10.h),
                                                            Icon(Icons.star,
                                                                color: const Color(
                                                                    0xFFFFC700),
                                                                size: 10.h),
                                                            Icon(Icons.star,
                                                                color: const Color(
                                                                    0xFFFFC700),
                                                                size: 10.h),
                                                            Icon(Icons.star,
                                                                color: const Color(
                                                                    0xFFFFC700),
                                                                size: 10.h),
                                                            Icon(Icons.star,
                                                                color: const Color(
                                                                    0xFFFFC700),
                                                                size: 10.h),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  SizedBox(
                                                    height: 55.h,
                                                    child: Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                            "Highly Recommended!",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              color:
                                                                  Colors.black,
                                                            ))),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 100.h,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.h,
                                                  vertical: 10.h),
                                              foregroundDecoration:
                                                  BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.r),
                                                      color:
                                                          const Color.fromARGB(
                                                              10, 0, 0, 0)),
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                // border: Border.all(width: 1, color: const Color.fromARGB(20, 0, 0, 0))
                                              ),
                                              margin: EdgeInsets.only(
                                                  left: 5.h, bottom: 5.h),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 20.h,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const SizedBox(
                                                              height: 24,
                                                              width: 24,
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        "assets/compare/no_picture.jpeg"),
                                                              ),
                                                            ),
                                                            Text(" User 3",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Roboto",
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500))
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(Icons.star,
                                                                color: const Color(
                                                                    0xFFFFC700),
                                                                size: 10.h),
                                                            Icon(Icons.star,
                                                                color: const Color(
                                                                    0xFFFFC700),
                                                                size: 10.h),
                                                            Icon(Icons.star,
                                                                color: const Color(
                                                                    0xFFFFC700),
                                                                size: 10.h),
                                                            Icon(Icons.star,
                                                                color: const Color(
                                                                    0xFFFFC700),
                                                                size: 10.h),
                                                            Icon(Icons.star,
                                                                color: const Color(
                                                                    0xFFFFC700),
                                                                size: 10.h),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  SizedBox(
                                                    height: 55.h,
                                                    child: Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                            "Best Hostel!",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14.sp,
                                                              color:
                                                                  Colors.black,
                                                            ))),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(left: 5.h),
                                                child: Text("Location",
                                                    style: TextStyle(
                                                        fontFamily: "Roboto",
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black))),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Container(
                                                child: Image.asset(
                                              "assets/compare/locationImage.png",
                                              width: 346,
                                              height: 174,
                                            )),
                                            SizedBox(height: 15.h),
                                            Align(
                                              child: SizedBox(
                                                width: 130.w,
                                                height: 50.h,
                                                child: FilledButton(
                                                  style: ButtonStyle(
                                                      shape: WidgetStatePropertyAll(
                                                          RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(15
                                                                          .r)))),
                                                      backgroundColor:
                                                          const WidgetStatePropertyAll(
                                                              Color.fromARGB(
                                                                  255,
                                                                  0,
                                                                  239,
                                                                  209))),
                                                  onPressed: () {
                                                    setState(() {});
                                                  },
                                                  child: Text("Book Now",
                                                      style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp,
                                                      )),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            SizedBox(
                                              width: 350.w,
                                              height: 40.h,
                                              child: FilledButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      const WidgetStatePropertyAll(
                                                          Colors.white),
                                                  shape: WidgetStatePropertyAll(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                15.r),
                                                          ),
                                                          side: const BorderSide(
                                                              color: Color(
                                                                  0xFF00EFD1)))),
                                                  // backgroundColor: const WidgetStatePropertyAll(
                                                  //     Color.fromARGB(255, 0, 239, 209)
                                                  //     )
                                                ),
                                                onPressed: () {
                                                  setState(() {});
                                                },
                                                child: Text("Clear",
                                                    style: TextStyle(
                                                      fontFamily: "Roboto",
                                                      color: const Color(
                                                          0xFF00EFD1),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16.sp,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })),
                          SizedBox(
                            height: 110.h,
                            width: MediaQuery.of(context).size.width,
                            // color: Colors.orange
                          )
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
