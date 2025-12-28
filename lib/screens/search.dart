import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:on_campus/classes/classes.dart';
import 'package:on_campus/classes/hostel.dart';
import 'package:on_campus/customscroll.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/screens/Home%20Page%20Views/home.dart';
import 'package:get/get.dart';
import 'package:on_campus/screens/filter.dart';
import 'package:on_campus/screens/get_icon.dart';
import 'package:on_campus/firebase/firestore_db.dart';
import 'package:on_campus/screens/hostels_detail.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Future<void> getPopular() async {
    setState(() {
      // isLoading = true;
    });
    List<Hostels> awaitPopular = await FirestoreDb.instance.getPopular();
    List<Hostels> awaitTop = await FirestoreDb.instance.getPrivateHostels();
    awaitPopular.shuffle();
    awaitTop.shuffle();
    setState(() {
      hostels = awaitPopular;
      recommendedHostels = awaitTop;
      // myLocations = awaitLocations;
      // isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getPopular();
  }

  List<Hostels> hostels = [];
  List<Hostels> recommendedHostels = [];
  List<Swipper> swipers = [
    Swipper(image: "assets/search/search_imgs.jpeg"),
    Swipper(image: "assets/search/search_imgs_1.jpeg"),
    Swipper(image: "assets/search/search_imgs_2.jpeg"),
    Swipper(image: "assets/search/search_imgs_3.jpeg"),
    Swipper(image: "assets/search/search_imgs_4.jpeg"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: 200.h,
              child: Stack(
                children: [
                  Swiper(
                    controller: SwiperController(),
                    autoplay: true,
                    curve: Curves.easeIn,
                    pagination: SwiperPagination(
                      margin: EdgeInsets.only(bottom: 30.h),
                    ),
                    autoplayDelay: 5000,
                    itemCount: swipers.length,
                    itemBuilder: (BuildContext, index) {
                      Swipper swiper = swipers[index];
                      return Image.asset(
                        swiper.image,
                        width: MediaQuery.sizeOf(context).width,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  Container(
                    height: 200.h,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        end: Alignment.bottomCenter,
                        begin: Alignment.topCenter,
                        colors: [Colors.black12, Colors.black87],
                      ),
                    ),
                    child: SizedBox(
                      height: 200.h,
                      width: MediaQuery.sizeOf(context).width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                      255,
                                      255,
                                      255,
                                      .4,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  height: 30.h,
                                  width: 30.w,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios_new_outlined,
                                      size: 17.sp.clamp(0, 17),
                                    ),
                                    color: Colors.black38,
                                    onPressed: () {
                                      Get.to(() => Navigator.of(context).pop());
                                    },
                                  ),
                                ),
                                Image.asset(
                                  "assets/search/logo2.png",
                                  height: 35.h,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                      255,
                                      255,
                                      255,
                                      .4,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  height: 30.h,
                                  width: 30.w,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.list,
                                      size: 17.sp.clamp(0, 17),
                                    ),
                                    color: Colors.black38,
                                    onPressed: () {
                                      Get.to(
                                        Filter(),
                                        transition: Transition.fadeIn,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            SizedBox(
                              height: 35.h,
                              child: Center(
                                child: TextField(
                                  // controller: controller,
                                  obscureText: false,
                                  enableSuggestions: true,
                                  autocorrect: true,
                                  cursorColor: Colors.grey,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 11.sp.clamp(0, 11),
                                  ),
                                  decoration: InputDecoration(
                                    labelText:
                                        "Search by Region, University...",
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11.sp.clamp(0, 11),
                                    ),
                                    contentPadding: EdgeInsets.only(
                                      left: 50.0.w,
                                    ),
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.search,
                                      size: 20.sp.clamp(0, 20),
                                    ),
                                    prefixIconColor: Colors.blue,
                                    fillColor: Colors.white,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.r),
                                      borderSide: BorderSide(
                                        width: 0.w,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  //  TextInputType.emailAddress,
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: Offset(0, -25),
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color.fromARGB(255, 242, 246, 249),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0.w, top: 20.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Most searched hostels",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp.clamp(0, 13),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Padding(
                              padding: EdgeInsets.only(right: 10.0.w),
                              child: Text(
                                "View",
                                style: TextStyle(
                                  color: const Color(0xFF00EFD1),
                                  fontSize: 12.sp.clamp(0, 12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: 20.h),
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: hostels.length,
                          itemBuilder: (BuildContext, index) {
                            Hostels hostel = hostels[index];
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => HostelDetails(hostel: hostel),
                                  transition: Transition.fadeIn,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    width: 190.w.clamp(0, 290),
                                    // height: 200.h,
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          child: Stack(
                                            children: [
                                              Image.network(
                                                hostel.hostel_images?[0] ?? "",
                                                height: 130.h,
                                                width: 200.w.clamp(0, 300),
                                                fit: BoxFit.cover,
                                              ),

                                              Positioned(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 0.0.w,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius.only(
                                                              bottomRight:
                                                                  Radius.circular(
                                                                    10,
                                                                  ),
                                                            ),
                                                        child: Container(
                                                          color: Colors.black87
                                                              .withOpacity(.3),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      8.0.w,
                                                                  vertical: 5.h,
                                                                ),
                                                            child: Text(
                                                              "Top Choice",
                                                              style: TextStyle(
                                                                fontSize: 12.sp
                                                                    .clamp(
                                                                      0,
                                                                      12,
                                                                    ),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                              right: 15.0.w,
                                                            ),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  50.r,
                                                                ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                  2.0.r,
                                                                ),
                                                            child: Icon(
                                                              Icons.favorite,
                                                              size: 17.sp.clamp(
                                                                0,
                                                                17,
                                                              ),
                                                              color:
                                                                  const Color(
                                                                    0xFF00EFD1,
                                                                  ),
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
                                        SizedBox(height: 5.h),
                                        Container(
                                          // color: Colors.green,
                                          padding: EdgeInsets.only(left: 15.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                hostel.name,
                                                style: TextStyle(
                                                  color: const Color.fromARGB(
                                                    150,
                                                    0,
                                                    0,
                                                    0,
                                                  ),
                                                  fontSize: 13.sp.clamp(0, 13),
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Poppins",
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    hostel.university ?? "",
                                                    style: TextStyle(
                                                      fontSize: 9.sp.clamp(
                                                        0,
                                                        9,
                                                      ),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "Poppins",
                                                      color: const Color(
                                                        0xFF323232,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    hostel.city ?? "",
                                                    style: TextStyle(
                                                      fontSize: 9.sp.clamp(
                                                        0,
                                                        9,
                                                      ),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "Poppins",
                                                      color: const Color(
                                                        0xFF323232,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    ", ",
                                                    style: TextStyle(
                                                      fontSize: 9.sp.clamp(
                                                        0,
                                                        9,
                                                      ),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "Poppins",
                                                      color: const Color(
                                                        0xFF323232,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    hostel.region ?? "",
                                                    style: TextStyle(
                                                      fontSize: 9.sp.clamp(
                                                        0,
                                                        9,
                                                      ),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "Poppins",
                                                      color: const Color(
                                                        0xFF323232,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 7),
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "From ",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "GHS ${hostel.amt_per_year}/",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: "year",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Container(
                                                width: 220.w.clamp(0, 220),
                                                height: 25,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: hostels[index]
                                                      .amenities!
                                                      .length,
                                                  itemBuilder: (context, index2) {
                                                    return Container(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                              left: 0,
                                                              right: 4.0,
                                                            ),
                                                        child: OutlinedButton(
                                                          style: OutlinedButton.styleFrom(
                                                            padding:
                                                                EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 3,
                                                                ),
                                                            foregroundColor:
                                                                Colors.black,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    5,
                                                                  ),
                                                            ),
                                                          ),
                                                          onPressed: () {},
                                                          child: Container(
                                                            // width: 40,
                                                            // height: 20,
                                                            child: Row(
                                                              children: [
                                                                GetIcon(
                                                                  text:
                                                                      hostels[index]
                                                                          .amenities![index2] ??
                                                                      "noicon",
                                                                ),
                                                                SizedBox(
                                                                  width: 3,
                                                                ),
                                                                Text(
                                                                  hostels[index]
                                                                          .amenities![index2] ??
                                                                      "none",
                                                                  style:
                                                                      TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
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
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recommended for you",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp.clamp(0, 13),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Padding(
                              padding: EdgeInsets.only(right: 10.0.w),
                              child: Text(
                                "View",
                                style: TextStyle(
                                  color: const Color(0xFF00EFD1),
                                  fontSize: 12.sp.clamp(0, 12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: 20.h),
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: recommendedHostels.length,
                          itemBuilder: (BuildContext, index) {
                            Hostels recommendedHostel =
                                recommendedHostels[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  width: 190.w.clamp(0, 290),
                                  // height: 200.h,
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        child: Stack(
                                          children: [
                                            Image.network(
                                              recommendedHostel
                                                      .hostel_images?[0] ??
                                                  "",
                                              height: 130.h,
                                              width: 200.w.clamp(0, 300),
                                              fit: BoxFit.cover,
                                            ),

                                            Positioned(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 0.0.w,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                  10,
                                                                ),
                                                          ),
                                                      child: Container(
                                                        color: Colors.black87
                                                            .withOpacity(.3),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.symmetric(
                                                                horizontal:
                                                                    8.0.w,
                                                                vertical: 5.h,
                                                              ),
                                                          child: Text(
                                                            "Top Choice",
                                                            style: TextStyle(
                                                              fontSize: 12.sp
                                                                  .clamp(0, 12),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        right: 15.0.w,
                                                      ),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                50.r,
                                                              ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                2.0.r,
                                                              ),
                                                          child: Icon(
                                                            Icons.favorite,
                                                            size: 17.sp.clamp(
                                                              0,
                                                              17,
                                                            ),
                                                            color: const Color(
                                                              0xFF00EFD1,
                                                            ),
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
                                      SizedBox(height: 5.h),
                                      Container(
                                        // color: Colors.green,
                                        padding: EdgeInsets.only(left: 15.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              recommendedHostel.name,
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                  150,
                                                  0,
                                                  0,
                                                  0,
                                                ),
                                                fontSize: 13.sp.clamp(0, 13),
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Poppins",
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  recommendedHostel
                                                          .university ??
                                                      "",
                                                  style: TextStyle(
                                                    fontSize: 9.sp.clamp(0, 9),
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Poppins",
                                                    color: const Color(
                                                      0xFF323232,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  recommendedHostel.city ?? "",
                                                  style: TextStyle(
                                                    fontSize: 9.sp.clamp(0, 9),
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Poppins",
                                                    color: const Color(
                                                      0xFF323232,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  ", ",
                                                  style: TextStyle(
                                                    fontSize: 9.sp.clamp(0, 9),
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Poppins",
                                                    color: const Color(
                                                      0xFF323232,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  recommendedHostel.region ??
                                                      "",
                                                  style: TextStyle(
                                                    fontSize: 9.sp.clamp(0, 9),
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Poppins",
                                                    color: const Color(
                                                      0xFF323232,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 7),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "From ",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "GHS ${recommendedHostel.amt_per_year}/",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: "year",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              width: 220.w.clamp(0, 220),
                                              height: 25,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: hostels[index]
                                                    .amenities!
                                                    .length,
                                                itemBuilder: (context, index2) {
                                                  return Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            left: 0,
                                                            right: 4.0,
                                                          ),
                                                      child: OutlinedButton(
                                                        style: OutlinedButton.styleFrom(
                                                          padding:
                                                              EdgeInsets.symmetric(
                                                                horizontal: 10,
                                                                vertical: 3,
                                                              ),
                                                          foregroundColor:
                                                              Colors.black,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  5,
                                                                ),
                                                          ),
                                                        ),
                                                        onPressed: () {},
                                                        child: Container(
                                                          // width: 40,
                                                          // height: 20,
                                                          child: Row(
                                                            children: [
                                                              GetIcon(
                                                                text:
                                                                    hostels[index]
                                                                        .amenities![index2] ??
                                                                    "noicon",
                                                              ),
                                                              SizedBox(
                                                                width: 3,
                                                              ),
                                                              Text(
                                                                hostels[index]
                                                                        .amenities![index2] ??
                                                                    "none",
                                                                style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
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
                            );
                          },
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
      floatingActionButton: Container(
        width: 90,
        child: ElevatedButton(
          onPressed: () {},

          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFF00EFD1),
            padding: EdgeInsets.all(0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Map", style: TextStyle(fontSize: 12)),
              SizedBox(width: 5),
              Icon(Icons.map),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
