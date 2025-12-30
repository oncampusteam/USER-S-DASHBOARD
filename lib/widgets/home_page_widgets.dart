import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:on_campus/screens/get_icon.dart';
import 'package:on_campus/screens/hostels_detail.dart';
import 'package:on_campus/firebase/classes.dart';

Widget HostelCard({
  // required Map<String, dynamic> hostelsInfo,
  required List<Hostels> hostels,
  required bool seeAllPopular,
  required List<bool> favoriteBools,
  required VoidCallback onFavoriteTap,
  bool variant = false,
}) {
  List<String> value = [
    "GCUC I 8.0 km",
    "4 Room Options",
    "Pay In Installment",
    "10% Discount",
  ];
  return SizedBox(
    // color: Colors.pink,
    height: Constant.height * 0.44,
    // width: MediaQuery.of(context).size.width,
    width: Constant.width,
    child: ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: !variant ?Axis.horizontal: Axis.vertical,
      itemCount: seeAllPopular ? hostels.length : 5,
      itemBuilder: (context, index) {
        Hostels hostel = hostels[index];
        String? string = hostel.hostel_images?[0];
        return !variant ?Row(
          children: [
            if (index == 0) SizedBox(width: 25.h),
            hostelGestureCard(hostel: hostel, favoriteBools: favoriteBools, onFavoriteTap: onFavoriteTap, string: string, value: value, index: index),

            const SizedBox(width: 20),
          ],
        ): Column(
          children: [
            hostelGestureCard(hostel: hostel, favoriteBools: favoriteBools, onFavoriteTap: onFavoriteTap, string: string, value: value, index: index, variant: variant),
            SizedBox(height : 25.h)
          ],
        );
      },
    ),
  );
}

Widget hostelGestureCard({
  // required Map<String, dynamic> hostelsInfo,
  required Hostels hostel,
  required List<bool> favoriteBools,
  required VoidCallback onFavoriteTap,
  bool variant = false,
  required String? string,
  required List<String> value,
  required int index,
}) {
  return GestureDetector(
    onTap: () {
      Get.to(
        () => HostelDetails(hostel: hostel),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeIn,
      );
    },
    child: Container(
      height: Constant.height * 0.44,
      decoration: BoxDecoration(
        border: !variant ? Border.all(color: Color(0xFFD9D9D9)):null,
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: !variant ? Offset(0, 12): Offset.zero,
            blurRadius: !variant ? 28 : 0,
            spreadRadius: 0,
            color: Color.fromRGBO(0, 0, 0, 0.06),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // margin: EdgeInsets.only(right: 10.h),
            padding: variant ? EdgeInsets.symmetric(horizontal: 25.h):null,
            height: Constant.height * 0.25,
            width: !variant ?Constant.width * 0.85: Constant.width,
            decoration: BoxDecoration(
              // color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
                bottomLeft:
                    Radius.circular( variant ?
                      12.r: 0,
                    ),
                bottomRight:
                    Radius.circular(variant ?
                      12.r: 0,
                    ),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.r),
                      topRight: Radius.circular(8.r),
                      bottomLeft:
                          Radius.circular(variant ?
                            8.r : 0,
                          ),
                      bottomRight:
                          Radius.circular(variant ?
                            8.r: 0,
                          ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: string ?? "",
                      height: Constant.height * 0.25,

                      fit: BoxFit.cover,
                      placeholder: (context, url) => SpinKitThreeBounce(
                        color: const Color.fromARGB(255, 0, 239, 209),
                        size: 50.0,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                Positioned(
                  top: 5.h,
                  right: 5.h,
                  // left: 0,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 35.h,
                      width: 35.w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          favoriteBools[index] = !favoriteBools[index];
                          onFavoriteTap();
                        },
                        child: Icon(
                          size: 20.h,
                          favoriteBools[index]
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: const Color.fromARGB(255, 0, 239, 209),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: hostel.ispopular!
                      ? Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          height: Constant.height * 0.03,
                          // width: 45.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00EFD1),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12.r),
                              topLeft: Radius.circular(8.r),
                            ),
                          ),
                          child: Align(
                            child: SizedBox(
                              height: Constant.height * 0.02,
                              child: FittedBox(
                                child: Text(
                                  "Males only",
                                  style: TextStyle(
                                    fontSize: 12.sp.clamp(0, 12),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Roboto",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ),
                Positioned(
                  left: 10.h,
                  bottom: 5.h,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.h,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                    ),
                    height: Constant.height * 0.025,
                    child: Align(
                      child: SizedBox(
                        height: Constant.height * 0.025,
                        child: FittedBox(
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_border_outlined,
                                color: Color(0xFF00EFD1),
                              ),
                              Text(
                                "4.5",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF111111),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: !variant ? EdgeInsets.only(right: 5.h, left: 10.h): EdgeInsets.symmetric(horizontal: 25.h),
            height: Constant.height * 0.067,
            width: !variant ? Constant.width * 0.85: Constant.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: (Constant.height * 0.08) * 0.48,
                      width: Constant.width * 0.6,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          hostel.name,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp.clamp(0, 22),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      // color: Colors.green,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                // color: Colors.yellow,
                                height: (Constant.height * 0.08) * 0.35,
                                width: Constant.width * 0.6,
                                child: FittedBox(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "${hostel.city}, ${hostel.region}",
                                    style: TextStyle(
                                      fontSize: 15.sp.clamp(0, 18),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.15.w,
                                      color: const Color(0xFF7A7A7A),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 5),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    height: Constant.height * 0.065,
                    width: Constant.width * 0.20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Constant.height * 0.02,
                          child: FittedBox(
                            child: Text(
                              "From",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp.clamp(0, 12),
                                color: const Color(0xFF323232),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Constant.height * 0.025,
                          child: FittedBox(
                            child: Text(
                              "GHS ${hostel.amt_per_year} ",
                              style: TextStyle(
                                fontWeight:
                                    FontWeight.w600, // Only "GHS" is bold
                                fontSize: 12.sp.clamp(0, 12),
                                color: const Color(0xFF323232),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Constant.height * 0.02,
                          child: FittedBox(
                            child: Text(
                              "per year",
                              style: TextStyle(
                                fontWeight:
                                    FontWeight.w500, // Only "GHS" is bold
                                fontSize: 12.sp.clamp(0, 12),
                                color: const Color(0xFF323232),
                              ),
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
          SizedBox(height: 10.h),
          SizedBox(
            width: !variant ? Constant.width * 0.85 : Constant.width,
            height: Constant.height * 0.04,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hostel.amenities!.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    if (index == 0) SizedBox(width: !variant ? 10.h : 25.h),
                    Container(
                      margin: EdgeInsets.only(left: !variant ? 5.h : 0, right: 5.w),
                      padding: EdgeInsets.only(
                        left: 5.w,
                        top: .5.h,
                        bottom: .5.h,
                        right: 10.w,
                      ),
                      height: Constant.height * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(color: Color(0xFF7A7A7A)),
                      ),
                      // width: 40,
                      // height: 20,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          child: SizedBox(
                            height: Constant.height * 0.035,
                            child: Row(
                              children: [
                                GetIcon(
                                  text: hostel.amenities![index] ?? "noicon",
                                ),
                                SizedBox(width: 10),
                                Text(
                                  hostel.amenities![index]?.capitalize ??
                                      "none",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13.sp,
                                    color: Color(0xFF555555),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: !variant ? Constant.width * 0.85: Constant.width,
            height: Constant.height * 0.04,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: value.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    if (index == 0) SizedBox(width :!variant ? 10.h: 25.h),
                    Container(
                      margin: EdgeInsets.only(left: !variant ? 5.h: 0, right: 5.w),
                      padding: EdgeInsets.only(
                        left: 5.w,
                        top: 5.h,
                        bottom: 5.h,
                        right: 10.w,
                      ),
                      height: Constant.height * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(color: Color(0xFF7A7A7A)),
                      ),
                      // width: 40,
                      // height: 20,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          child: SizedBox(
                            height: Constant.height * 0.035,
                            child: Row(
                              children: [
                                Image.asset(
                                  index == 0
                                      ? "assets/home/distance.png"
                                      : "assets/home/circled-check-box.png",
                                  fit: BoxFit.fitHeight,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  value[index],
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13.sp,
                                    color: Color(0xFF555555),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
