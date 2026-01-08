import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:on_campus/screens/get_icon.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:on_campus/screens/hostels_detail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
      physics: !variant
          ? const BouncingScrollPhysics()
          : NeverScrollableScrollPhysics(),
      scrollDirection: !variant ? Axis.horizontal : Axis.vertical,
      itemCount: seeAllPopular ? hostels.length : 5,
      itemBuilder: (context, index) {
        Hostels hostel = hostels[index];
        String? string = hostel.hostel_images?[0];
        return !variant
            ? Row(
                children: [
                  if (index == 0) SizedBox(width: 25.h),
                  hostelGestureCard(
                    hostel: hostel,
                    favoriteBools: favoriteBools,
                    onFavoriteTap: onFavoriteTap,
                    string: string,
                    value: value,
                    index: index,
                  ),

                  const SizedBox(width: 20),
                ],
              )
            : Column(
                children: [
                  hostelGestureCard(
                    hostel: hostel,
                    favoriteBools: favoriteBools,
                    onFavoriteTap: onFavoriteTap,
                    string: string,
                    value: value,
                    index: index,
                    variant: variant,
                  ),
                  SizedBox(height: 25.h),
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
  // bool favorite = false,
}) {

  
  return GestureDetector(
    onTap: () {
      Get.to(
        () => HostelDetails(hostel: hostel, favorite: favoriteBools[index]),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeIn,
      );
    },
    child: Container(
      height: Constant.height * 0.44,
      decoration: BoxDecoration(
        border: !variant ? Border.all(color: Color(0xFFD9D9D9)) : null,
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: !variant ? Offset(0, 12) : Offset.zero,
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
            padding: variant ? EdgeInsets.symmetric(horizontal: 25.h) : null,
            height: Constant.height * 0.25,
            width: !variant ? Constant.width * 0.85 : Constant.width,
            decoration: BoxDecoration(
              // color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
                bottomLeft: Radius.circular(variant ? 12.r : 0),
                bottomRight: Radius.circular(variant ? 12.r : 0),
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
                      bottomLeft: Radius.circular(variant ? 8.r : 0),
                      bottomRight: Radius.circular(variant ? 8.r : 0),
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
                          // favorite = favoriteBools[index];
                          // debugPrint("This is the value of favorite in hostelGestureCard : $favorite");
                          onFavoriteTap();
                        },
                        child: Icon(
                          size: 20.h,
                          favoriteBools[index]
                          // favorite
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
            // color: Colors.yellow,
            padding: !variant
                ? EdgeInsets.only(right: 5.h, left: 10.h)
                : EdgeInsets.symmetric(horizontal: 25.h),
            height: Constant.height * 0.067,
            width: !variant ? Constant.width * 0.85 : Constant.width,
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
                                height: (Constant.height * 0.08) * 0.3,
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
                              "GH₵ ${hostel.amt_per_year} ",
                              style: TextStyle(
                                fontWeight:
                                    FontWeight.w600, // Only "GH₵" is bold
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
                                    FontWeight.w500, // Only "GH₵" is bold
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
            width: !variant ? Constant.width * 0.85 : Constant.width - 25.h,
            height: Constant.height * 0.04,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hostel.amenities!.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    if (index == 0) SizedBox(width: !variant ? 10.h : 25.h),
                    Container(
                      margin: EdgeInsets.only(
                        left: !variant ? 5.h : 0,
                        right: 5.w,
                      ),
                      padding: EdgeInsets.only(
                        left: 5.w,
                        top: .5.h,
                        bottom: .5.h,
                        right: 10.w,
                      ),
                      height: Constant.height * 0.04,
                      decoration: BoxDecoration(
                        // color: Colors.blue,
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
                                Container(
                                  // color: Colors.red,
                                  height: Constant.height * 0.03,
                                  width: Constant.width * 0.05,
                                  child: FittedBox(
                                    child: GetIcon(
                                      text:
                                          hostel.amenities![index] ?? "noicon",
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.w),
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
            // color: Colors.blue,
            width: !variant ? Constant.width * 0.85 : Constant.width - 25.h,
            height: Constant.height * 0.04,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: value.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    if (index == 0) SizedBox(width: !variant ? 10.h : 25.h),
                    Container(
                      margin: EdgeInsets.only(
                        left: !variant ? 5.h : 0,
                        right: 5.w,
                      ),
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
                                SizedBox(
                                  height: Constant.height * 0.028,
                                  width: Constant.width * 0.05,
                                  child: FittedBox(
                                    child: Image.asset(
                                      index == 0
                                          ? "assets/home/distance.png"
                                          : "assets/home/circled-check-box.png",
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.w),
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
                    if (variant && index == value.length - 1)
                      SizedBox(width: 25.h),
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

Widget hostelCardVariant({
  required Hostels hostel,
  required bool favorite,
  required void Function() triggerRebuild,
  bool variant = false,
  int index = 0,
  bool variant2 = false,
}) {
  int length = hostel.amenities?.length ?? 0;
  return Row(
    children: [
      // if (index == 0) SizedBox(width: 20.w),
      GestureDetector(
        onTap: () {
          Get.to(
            () => HostelDetails(hostel: hostel, favorite: favorite),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeIn,
          );
        },
        child: Padding(
          padding: !variant
              ? const EdgeInsets.all(7.5)
              : EdgeInsetsGeometry.only(bottom: 20.h),
          child: Container(
            // height: 215.h,
            width: !variant2
                ? (!variant ? Constant.width * 0.65 : Constant.width * 0.9)
                : Constant.width * 0.55,
            decoration: BoxDecoration(
              // color: Colors.red,
              border: variant || variant2
                  ? Border.all(color: Color(0xFFCAC4D0))
                  : null,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(28.r),
                topLeft: Radius.circular(28.r),
                bottomLeft: Radius.circular(28.r),
                bottomRight: Radius.circular(28.r),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: !variant || !variant2
                      ? const Offset(0, 1)
                      : Offset.zero,
                  blurRadius: 4,
                  color: !variant || !variant2
                      ? const Color.fromARGB(64, 0, 0, 0)
                      : Colors.white,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: !variant2
                      ? (variant
                            ? Constant.height * 0.25
                            : Constant.height * 0.2)
                      : Constant.height * 0.15,
                  // width: !variant ? Constant.width * 0.65,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          height: Constant.height * 0.25,
                          // width: 245.w,
                          decoration: BoxDecoration(
                            // color: Colors.brown,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.network(
                              hostel.hostel_images?[0] ?? "",
                              height: Constant.height * 0.25,
                              // width: 225.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5.h,
                        right: 5.w,
                        // left: 0,
                        child: GestureDetector(
                          onTap: () {
                            // setState(() {
                            // debugdebugPrint(
                            //   "This is the value of favorite before flip: $favorite",
                            // );
                            // favorite = !favorite;
                            // debugdebugPrint(
                            //   "This is the value of favorite: $favorite",
                            // );
                            triggerRebuild();
                            // });
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              size: 20.h,
                              favorite
                                  ? Icons.favorite_outlined
                                  : Icons.favorite_border_outlined,
                              color: const Color.fromARGB(255, 0, 239, 209),
                            ),
                          ),
                        ),
                      ),
                      variant
                          ? Positioned(
                              top: 5.h,
                              left: 5.w,
                              // left: 0,
                              child: SizedBox(
                                height: Constant.height * 0.035,

                                child: index % 2 == 0
                                    ? Image.asset(
                                        "assets/hostel_category_widget/Frame.png",
                                        fit: BoxFit.fitHeight,
                                      )
                                    : Image.asset(
                                        "assets/hostel_category_widget/Frame 1.png",
                                        fit: BoxFit.fitHeight,
                                      ),
                              ),
                            )
                          : Positioned(child: Container()),
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
                const SizedBox(height: 5),
                Container(
                  // color: Colors.green,
                  // padding: variant ? EdgeInsets.only(left: 15.h): EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15.h),
                        height: !variant2
                            ? (Constant.height * 0.03)
                            : Constant.height * 0.025,
                        child: FittedBox(
                          child: Text(
                            hostel.name,
                            style: TextStyle(
                              color: const Color(0xFF111111),
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.only(left: 15.h),
                          height: !variant2
                              ? (Constant.height * 0.02)
                              : Constant.height * 0.015,
                          width: Constant.width * 0.8,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${hostel.university}" == "null"
                                  ? "University, ${hostel.city}, ${hostel.region ?? {"region"}}"
                                  : "${hostel.university}, ${hostel.city}, ${hostel.region ?? {"region"}}",
                              style: TextStyle(
                                fontSize: 13.sp.clamp(0, 18),
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                                color: const Color(0xFF7A7A7A),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        padding: EdgeInsets.only(left: 15.h),
                        height: !variant2
                            ? Constant.height * 0.025
                            : Constant.height * 0.02,
                        child: FittedBox(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: "From "),
                                TextSpan(
                                  text: "GH₵ ${hostel.amt_per_year}/",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: "year"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        // color: Colors.red,
                        width: !variant
                            ? Constant.width * 0.65
                            : Constant.width * 0.91,
                        height: 25,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: length != 0
                              ? (hostel.amenities!.length / 2).ceil()
                              : 0,
                          itemBuilder: (context, index2) {
                            return Row(
                              children: [
                                if (index2 == 0) SizedBox(width: 15.h),
                                Container(
                                  margin: EdgeInsets.only(left: 0, right: 5.w),
                                  padding: EdgeInsets.only(
                                    left: 5.w,
                                    top: .5.h,
                                    bottom: .5.h,
                                    right: 10.w,
                                  ),
                                  height: Constant.height * 0.04,
                                  decoration: BoxDecoration(
                                    // color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5.r),
                                    border: Border.all(
                                      color: Color(0xFF7A7A7A),
                                    ),
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
                                            // SizedBox(width: 15.h),
                                            SizedBox(
                                              // color: Colors.green,
                                              height: Constant.height * 0.03,
                                              width: Constant.width * 0.05,
                                              child: FittedBox(
                                                child: GetIcon(
                                                  text:
                                                      hostel
                                                          .amenities![index2] ??
                                                      "noicon",
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 5.w),
                                            Text(
                                              hostel
                                                      .amenities![index2]
                                                      ?.capitalize ??
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
                                if (index2 + 1 == length) SizedBox(width: 15.h),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        margin: EdgeInsets.only(bottom: 15.h),
                        width: !variant
                            ? Constant.width * 0.65
                            : Constant.width * 0.91,
                        height: 25,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: length != 0
                              ? hostel.amenities!.length -
                                    ((hostel.amenities!.length / 2).ceil())
                              : 0,
                          itemBuilder: (context, index3) {
                            int i = length != 0
                                ? hostel.amenities!.length -
                                      ((hostel.amenities!.length / 2).ceil())
                                : 0;
                            int offset = length != 0 ? i + 1 : 0;
                            return Row(
                              children: [
                                if (index3 + offset == i + 1)
                                  SizedBox(width: 15.h),
                                Container(
                                  margin: EdgeInsets.only(left: 0, right: 5.w),
                                  padding: EdgeInsets.only(
                                    left: 5.w,
                                    top: .5.h,
                                    bottom: .5.h,
                                    right: 10.w,
                                  ),
                                  height: Constant.height * 0.04,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r),
                                    border: Border.all(
                                      color: Color(0xFF7A7A7A),
                                    ),
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
                                            // SizedBox(width: 15.h),
                                            SizedBox(
                                              height: Constant.height * 0.03,
                                              width: Constant.width * 0.05,
                                              child: FittedBox(
                                                child: GetIcon(
                                                  text:
                                                      hostel.amenities![index3 +
                                                          offset] ??
                                                      "noicon",
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              hostel
                                                      .amenities![index3 +
                                                          offset]
                                                      ?.capitalize ??
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
