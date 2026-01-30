import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget roomCard({
  required Hostels pendingHostel,
  required BookedHostels bookedHostel,
}) {
  return Container(
    height: Constant.height * 0.15,
    margin: EdgeInsets.symmetric(horizontal: 20.h),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 3,
          spreadRadius: 1,
          color: const Color.fromRGBO(0, 0, 0, 0.15),
        ),
        BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 2,
          spreadRadius: 0,
          color: const Color.fromRGBO(0, 0, 0, 0.15),
        ),
      ],
    ),
    child: Align(
      child: Container(
        height: Constant.height * 0.12,
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              child: Container(
                // color: Colors.blue,
                width: Constant.width * 0.25,
                height: Constant.height * 0.12,
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/payment/paymentImage.png",
                      fit: BoxFit.fitHeight,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.all(5.0.r),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2.0.r),
                            child: const Icon(
                              Icons.favorite_border,
                              size: 17,
                              color: Color.fromARGB(255, 33, 243, 201),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 5.w,),
            Container(
              // color: Colors.yellow,
              width: Constant.width * 0.58,
              // padding: EdgeInsets.only(left: 5.0.w),
              child: SizedBox(
                // height: 90.h,
                // width: MediaQuery.sizeOf(context).width,
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: Constant.height * 0.025,
                          child: FittedBox(
                            child: Text(
                              bookedHostel.hostel_name ?? "",
                              style: TextStyle(
                                fontSize: 16.sp.clamp(0, 18),
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.15.w,
                                color: Color.fromARGB(255, 58, 48, 74),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 15.sp.clamp(0, 17),
                              color: const Color.fromARGB(255, 33, 243, 201),
                            ),
                            Text(
                              "${pendingHostel.rate}",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                color: const Color(0xFF323232),
                                fontSize: 13.sp.clamp(0, 15),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 10.sp.clamp(0, 12),
                          color: Color(0xFF333333),
                        ),
                        SizedBox(
                          height: Constant.height * 0.015,
                          child: FittedBox(
                            child: Text(
                              "${pendingHostel.city},  ${pendingHostel.region}",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                color: const Color(0xFF333333),
                                fontSize: 10.sp.clamp(0, 12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: 2.h),
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: Constant.width * 0.5.w,
                        height: Constant.height * 0.025,
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            child: Text(
                              "    ${pendingHostel.amenities?[0]["label"]?.capitalize ?? "Wifi"} • ${pendingHostel.amenities?[1]["label"]?.capitalize ?? "Shower"}• ${pendingHostel.amenities?[2]["label"]?.capitalize ?? "Kitchen"} • ${pendingHostel.amenities?[2]["label"]?.capitalize ?? "Security"} •\n ${pendingHostel.amenities?[2]["label"]?.capitalize ?? "Parking"} • ${pendingHostel.amenities?[1]["label"]?.capitalize ?? "Balcony"} • ${pendingHostel.amenities?[0]["label"]?.capitalize ?? "Friendly environment"}",
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                fontSize: 9.sp.clamp(0, 11),
                                fontFamily: "Roboto",
                                color: const Color(0xFF1D1B20),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        height: Constant.height * 0.02,
                        child: FittedBox(
                          child: Text(
                            "Price Estimate",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12.sp.clamp(0, 14),
                              color: const Color(0xFF323232),
                              letterSpacing: 0.15.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Constant.height * 0.025,
                      child: FittedBox(
                        child: Row(
                          children: [
                            Text(
                              "GH₵ ${pendingHostel.amt_per_year}/",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 18.sp.clamp(0, 20),
                                color: const Color(0xFF323232),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "Academic Year",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp.clamp(0, 14),
                                color: const Color(0xFF323232),
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
          ],
        ),
      ),
    ),
  );
}
