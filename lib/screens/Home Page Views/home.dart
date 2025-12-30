import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/firebase/firestore_db.dart';
import 'package:on_campus/screens/hostels_detail.dart';
import 'package:on_campus/screens/search.dart';
import 'package:on_campus/widgets/home_page_widgets.dart';
import 'package:on_campus/widgets/homestel_hostel_category.dart';
import 'package:on_campus/widgets/private_hostel_category.dart';
import 'package:on_campus/widgets/school_hostel_category.dart';
import 'package:on_campus/screens/get_icon.dart';

class Home extends StatefulWidget {
  final String? username;
  const Home({super.key, this.username});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  bool favorite = false;
  bool seeAllPopular = false;
  bool seeAllTop = false;

  List<Hostels> hostels = [];
  List<Hostels> topHostels = [];
  // Map<String, dynamic> myLocations = {};
  final FirebaseFirestore db = FirebaseFirestore.instance;
  User? user;

  List<bool> favoriteBools = [];
  List<bool> topFavoriteBools = [];
  List<bool> viewedFavoritebool = [];
  bool isLoading = true;
  int num = 0;

  Future<void> getPopular() async {
    setState(() {
      isLoading = true;
    });
    List<Hostels> awaitPopular = await FirestoreDb.instance.getPopular();
    List<Hostels> awaitTop = await FirestoreDb.instance.getPrivateHostels();
    awaitPopular.shuffle();
    awaitTop.shuffle();
    setState(() {
      hostels = awaitPopular;
      topHostels = awaitTop;
      favoriteBools = List.generate(hostels.length, (index) {
        return false;
      });
      topFavoriteBools = List.generate(topHostels.length, (index) {
        return false;
      });
      // topHostelsLength =
      //   (seeAllTop ? topHostels.length : topHostels.length / 2.ceil()).toInt();
      //   for (int i = 0; i <= hostels.length - 1; i++) {
      //   favoritebools.add(false);
      //   debugPrint("");
      // }
      // myLocations = awaitLocations;
      isLoading = false;
    });
  }

  // List<bool> favoritebools = [];
  @override
  void initState() {
    super.initState();

    setState(() {
      user = FirebaseAuth.instance.currentUser;
    });

    getPopular();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Stack(
          children: [
            Positioned(
              top: 40.h,
              right: 0,
              left: 0,
              bottom: 0,
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 30.h),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        // height: 52,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 25),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Constant.height * 0.04,
                                    width: Constant.width * 0.75,
                                    child: FittedBox(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Welcome ${user?.displayName ?? widget.username},",
                                        style: TextStyle(
                                          fontSize: 24.sp.clamp(0, 24),
                                          fontFamily: "Poppins-Bold",
                                          letterSpacing: 0.15.w,
                                          // fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.03,
                                    child: FittedBox(
                                      child: Text(
                                        "Find the best hostel that suits you",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 16.sp.clamp(0, 16),
                                          fontWeight: FontWeight.w500,
                                          height: 1.5,
                                          color: const Color.fromARGB(
                                            200,
                                            0,
                                            0,
                                            0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 15.h),
                                child: Image.asset(
                                  "assets/home/user logo.png",
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.only(left: 25.h, right: 25.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.5.w,
                                    color: const Color.fromARGB(
                                      255,
                                      0,
                                      239,
                                      209,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                                height: 50,
                                // width: 280.w.clamp(0, 280),
                                child: Center(
                                  child: TextField(
                                    onTap: () {
                                      Get.to(
                                        () => Search(),
                                        transition: Transition.fadeIn,
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),
                                        curve: Curves.easeIn,
                                      );
                                    },
                                    controller: searchController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.search_outlined,
                                        size: 17.sp.clamp(0, 17),
                                      ),
                                      prefixIconColor: Color.fromARGB(
                                        255,
                                        0,
                                        239,
                                        209,
                                      ),
                                      hintText: "Search for hostels",
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(120, 0, 0, 0),
                                        fontSize: 14.sp.clamp(0, 14),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        // borderRadius: BorderRadius.circular(50.r),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            SizedBox(
                              height: 37,
                              width: 37,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.5.w,
                                    color: const Color.fromARGB(
                                      255,
                                      0,
                                      239,
                                      209,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Center(
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        child: const Icon(
                                          Icons.notifications_outlined,
                                          size: 27,
                                          color: Color.fromARGB(
                                            255,
                                            0,
                                            239,
                                            209,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0.h,
                                        right: 4.h,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                              255,
                                              0,
                                              239,
                                              209,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              "1",
                                              style: TextStyle(
                                                fontSize: 9.sp.clamp(0, 9),
                                                color: Colors.white,
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
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        margin: EdgeInsets.only(left: 25.h, right: 25.h),
                        height: Constant.height * 0.04,
                        child: FittedBox(
                          child: Text(
                            "Categories",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                              letterSpacing: 0.15,
                              fontSize: 22.sp.clamp(0, 22),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        margin: EdgeInsets.only(right: 20, left: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => Get.to(
                                  () => SchoolHostelCategory(),
                                  transition: Transition.fadeIn,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/home/Ellipse 3.png",
                                      height: 70,
                                      width: 70,
                                    ),
                                    SizedBox(height: 15.h),
                                    SizedBox(
                                      height: Constant.height * 0.025,
                                      child: FittedBox(
                                        child: Text(
                                          "School Hostel",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(/* Your style */),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => Get.to(
                                  () => PrivateHostelCategory(),
                                  transition: Transition.fadeIn,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/home/Ellipse 4.png",
                                      height: 70,
                                      width: 70,
                                    ),
                                    SizedBox(height: 15),
                                    SizedBox(
                                      height: Constant.height * 0.025,
                                      child: FittedBox(
                                        child: Text(
                                          "Private Hostel",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => Get.to(
                                  () => HomestelHostelCategory(),
                                  transition: Transition.fadeIn,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/home/Ellipse 5.png",
                                      height: 70,
                                      width: 70,
                                    ),
                                    SizedBox(height: 15),
                                    SizedBox(
                                      height: Constant.height * 0.025,
                                      child: FittedBox(
                                        child: Text(
                                          "Homestel",
                                          textAlign: TextAlign.center,
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
                      SizedBox(height: 15),
                      Container(
                        margin: EdgeInsets.only(left: 25.h),
                        width: Constant.width,
                        // height: 20.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: Constant.height * 0.04,
                              child: FittedBox(
                                child: Text(
                                  "Popular Hostels",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22.sp.clamp(0, 22),
                                    letterSpacing: 0.15,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: Constant.height * 0.035,
                              padding: EdgeInsets.only(right: 15),
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                    Color.fromRGBO(0, 239, 209, .07),
                                  ),
                                  overlayColor: WidgetStateProperty.all(
                                    Color.fromRGBO(0, 239, 209, .5),
                                  ),
                                  animationDuration: Duration(seconds: 2),
                                ),
                                isSemanticButton: true,
                                child: SizedBox(
                                  height: Constant.height * 0.03,
                                  child: FittedBox(
                                    child: Text(
                                      seeAllPopular ? "see less" : "see all",
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                          255,
                                          0,
                                          239,
                                          209,
                                        ),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp.clamp(0, 16),
                                      ),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    seeAllPopular = !seeAllPopular;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      isLoading
                          ? Center(
                              child: SpinKitThreeBounce(
                                color: const Color.fromARGB(255, 0, 239, 209),
                                size: 50.0,
                              ),
                            )
                          : HostelCard(
                              hostels: hostels,
                              seeAllPopular: seeAllPopular,
                              favoriteBools: favoriteBools,
                              onFavoriteTap: () {
                                debugPrint("on favorite tap is called");
                                setState(() {});
                              },
                            ),
                      SizedBox(height: 15.h),
                      Container(
                        margin: EdgeInsets.only(left: 25.h),
                        width: Constant.width,
                        // height: 20.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: Constant.height * 0.04,
                              width: Constant.width * 0.7,
                              child: FittedBox(
                                child: Text(
                                  "Top Best Hostels for you",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22.sp.clamp(0, 22),
                                    letterSpacing: 0.15,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: Constant.height * 0.035,
                              padding: EdgeInsets.only(right: 15),
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                    Color.fromRGBO(0, 239, 209, .07),
                                  ),
                                  overlayColor: WidgetStateProperty.all(
                                    Color.fromRGBO(0, 239, 209, .5),
                                  ),
                                  animationDuration: Duration(seconds: 2),
                                ),
                                isSemanticButton: true,
                                child: SizedBox(
                                  height: Constant.height * 0.03,
                                  child: FittedBox(
                                    child: Text(
                                      seeAllTop ? "see less" : "see all",
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                          255,
                                          0,
                                          239,
                                          209,
                                        ),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp.clamp(0, 16),
                                      ),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    seeAllPopular = !seeAllPopular;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      isLoading
                          ? Center(
                              child: SpinKitThreeBounce(
                                color: const Color.fromARGB(255, 0, 239, 209),
                                size: 50.0,
                              ),
                            )
                          : Builder(
                              builder: (context) {
                                debugPrint(
                                  "topHostels length : ${topHostels.length}",
                                );
                                return SizedBox(
                                  height:
                                      Constant.height *
                                      0.46 *
                                      (seeAllTop ? topHostels.length : 5),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 0.h,
                                    ),
                                    child: HostelCard(
                                      hostels: topHostels,
                                      seeAllPopular: seeAllTop,
                                      favoriteBools: topFavoriteBools,
                                      onFavoriteTap: () {
                                        setState(() {});
                                      },
                                      variant: true,
                                    ),
                                  ),
                                );
                              },
                            ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25.w),
                        child: RichText(
                          text: TextSpan(
                            text: "Previously",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.sp.clamp(0, 22),
                              fontFamily: "Poppins-Bold",
                              letterSpacing: 0.15.w,
                            ),
                            children: [
                              TextSpan(
                                text: " Viewed",
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 239, 209),
                                  fontSize: 22.sp.clamp(0, 22),
                                  fontFamily: "Poppins-Bold",
                                  letterSpacing: 0.15.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      isLoading
                          ? Center(
                              child: SpinKitThreeBounce(
                                color: const Color.fromARGB(255, 0, 239, 209),
                                size: 50.0,
                              ),
                            )
                          : SizedBox(
                              // margin: EdgeInsets.only(bottom: 5.h),
                              // color: Colors.red,
                              height: Constant.height * 0.4,
                              // width: 225.w,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: hostels.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      if (index == 0) SizedBox(width: 20.w),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(
                                            () => HostelDetails(
                                              hostel: hostels[index],
                                            ),
                                            transition: Transition.fadeIn,
                                            duration: const Duration(
                                              milliseconds: 800,
                                            ),
                                            curve: Curves.easeIn,
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            // height: 215.h,
                                            width: Constant.width * 0.65,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(28.r),
                                                topLeft: Radius.circular(28.r),
                                                bottomLeft: Radius.circular(
                                                  28.r,
                                                ),
                                                bottomRight: Radius.circular(
                                                  28.r,
                                                ),
                                              ),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: const Offset(0, 1),
                                                  blurRadius: 4,
                                                  color: Colors.black
                                                      .withOpacity(0.25),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 166,
                                                  width: Constant.width * 0.65,
                                                  child: Stack(
                                                    children: [
                                                      Positioned(
                                                        top: 0,
                                                        right: 0,
                                                        left: 0,
                                                        child: Container(
                                                          height: 165,
                                                          width: 245.w,
                                                          decoration: BoxDecoration(
                                                            // color: Colors.brown,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  12.r,
                                                                ),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  12.r,
                                                                ),
                                                            child: Image.network(
                                                              hostels[index]
                                                                      .hostel_images?[0] ??
                                                                  "",
                                                              height: 165,
                                                              width: 225.w,
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
                                                            setState(() {
                                                              favorite =
                                                                  !favorite;
                                                            });
                                                          },
                                                          child: Container(
                                                            height: 35,
                                                            width: 35,
                                                            decoration:
                                                                const BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                            child: Icon(
                                                              size: 20.h,
                                                              favorite
                                                                  ? Icons
                                                                        .favorite_outlined
                                                                  : Icons
                                                                        .favorite_border_outlined,
                                                              color:
                                                                  const Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    239,
                                                                    209,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 10.h,
                                                        bottom: 5.h,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.symmetric(
                                                                horizontal: 6.h,
                                                                vertical: 2.h,
                                                              ),
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  10.r,
                                                                ),
                                                            color:
                                                                Color.fromRGBO(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  0.5,
                                                                ),
                                                          ),
                                                          height:
                                                              Constant.height *
                                                              0.025,
                                                          child: Align(
                                                            child: SizedBox(
                                                              height:
                                                                  Constant
                                                                      .height *
                                                                  0.025,
                                                              child: FittedBox(
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .star_border_outlined,
                                                                      color: Color(
                                                                        0xFF00EFD1,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "4.5",
                                                                      style: TextStyle(
                                                                        fontFamily:
                                                                            "Poppins",
                                                                        fontSize:
                                                                            12.sp,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: Color(
                                                                          0xFF111111,
                                                                        ),
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
                                                  padding: EdgeInsets.only(
                                                    left: 15.h,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height:
                                                            Constant.height *
                                                            0.03,
                                                        child: FittedBox(
                                                          child: Text(
                                                            hostels[index].name,
                                                            style: TextStyle(
                                                              color:
                                                                  const Color(
                                                                    0xFF111111,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  "Poppins",
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: SizedBox(
                                                          height:
                                                              Constant.height *
                                                              0.02,
                                                          width:
                                                              Constant.width *
                                                              0.8,
                                                          child: FittedBox(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                            "${hostels[index].university}" ==  "null"? 
                                                            "University, ${hostels[index].city}, ${hostels[index].region?? {"region"}}":
                                                            "${hostels[index].university}, ${hostels[index].city}, ${hostels[index].region ?? {"region"}}",
                                                              style: TextStyle(
                                                                fontSize: 13.sp
                                                                    .clamp(
                                                                      0,
                                                                      18,
                                                                    ),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    "Poppins",
                                                                color:
                                                                    const Color(
                                                                      0xFF7A7A7A,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 5.h),
                                                      SizedBox(
                                                        height:
                                                            Constant.height *
                                                            0.025,
                                                        child: FittedBox(
                                                          child: Text.rich(
                                                            TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: "From ",
                                                                ),
                                                                TextSpan(
                                                                  text:
                                                                      "GHS ${hostels[index].amt_per_year}/",
                                                                  style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: "year",
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 8),
                                                      SizedBox(
                                                        width:
                                                            Constant.width *
                                                            0.65,
                                                        height: 25,
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount:
                                                              (hostels[index]
                                                                          .amenities!
                                                                          .length /
                                                                      2)
                                                                  .ceil(),
                                                          itemBuilder: (context, index2) {
                                                            return Container(
                                                              margin:
                                                                  EdgeInsets.only(
                                                                    left: 0,
                                                                    right: 5.w,
                                                                  ),
                                                              padding:
                                                                  EdgeInsets.only(
                                                                    left: 5.w,
                                                                    top: .5.h,
                                                                    bottom:
                                                                        .5.h,
                                                                    right: 10.w,
                                                                  ),
                                                              height:
                                                                  Constant
                                                                      .height *
                                                                  0.04,
                                                              decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      5.r,
                                                                    ),
                                                                border: Border.all(
                                                                  color: Color(
                                                                    0xFF7A7A7A,
                                                                  ),
                                                                ),
                                                              ),
                                                              // width: 40,
                                                              // height: 20,
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: FittedBox(
                                                                  child: SizedBox(
                                                                    height:
                                                                        Constant
                                                                            .height *
                                                                        0.035,
                                                                    child: Row(
                                                                      children: [
                                                                        GetIcon(
                                                                          text:
                                                                              hostels[index].amenities![index2] ??
                                                                              "noicon",
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          hostels[index].amenities![index2]?.capitalize ??
                                                                              "none",
                                                                          style: TextStyle(
                                                                            fontFamily:
                                                                                "Work Sans",
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize:
                                                                                13.sp,
                                                                            color: Color(
                                                                              0xFF555555,
                                                                            ),
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
                                                      SizedBox(height: 8),
                                                      SizedBox(
                                                        width:
                                                            Constant.width *
                                                            0.65,
                                                        height: 25,
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount:
                                                              hostels[index]
                                                                  .amenities!
                                                                  .length -
                                                              ((hostels[index]
                                                                          .amenities!
                                                                          .length /
                                                                      2)
                                                                  .ceil()),
                                                          itemBuilder: (context, index3) {
                                                            int i =
                                                                hostels[index]
                                                                    .amenities!
                                                                    .length -
                                                                ((hostels[index]
                                                                            .amenities!
                                                                            .length /
                                                                        2)
                                                                    .ceil());
                                                            int offset = i + 1;
                                                            return Container(
                                                              margin:
                                                                  EdgeInsets.only(
                                                                    left: 0,
                                                                    right: 5.w,
                                                                  ),
                                                              padding:
                                                                  EdgeInsets.only(
                                                                    left: 5.w,
                                                                    top: .5.h,
                                                                    bottom:
                                                                        .5.h,
                                                                    right: 10.w,
                                                                  ),
                                                              height:
                                                                  Constant
                                                                      .height *
                                                                  0.04,
                                                              decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      5.r,
                                                                    ),
                                                                border: Border.all(
                                                                  color: Color(
                                                                    0xFF7A7A7A,
                                                                  ),
                                                                ),
                                                              ),
                                                              // width: 40,
                                                              // height: 20,
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: FittedBox(
                                                                  child: SizedBox(
                                                                    height:
                                                                        Constant
                                                                            .height *
                                                                        0.035,
                                                                    child: Row(
                                                                      children: [
                                                                        GetIcon(
                                                                          text:
                                                                              hostels[index].amenities![index3 +
                                                                                  offset] ??
                                                                              "noicon",
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          hostels[index]
                                                                                  .amenities![index3 +
                                                                                      offset]
                                                                                  ?.capitalize ??
                                                                              "none",
                                                                          style: TextStyle(
                                                                            fontFamily:
                                                                                "Work Sans",
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize:
                                                                                13.sp,
                                                                            color: Color(
                                                                              0xFF555555,
                                                                            ),
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
                                    ],
                                  );
                                },
                              ),
                            ),
                      SizedBox(height: 20),

                      SizedBox(height: 10.h),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25.h),
                        width: 380.w,
                        height: 30.h,
                        // color: Colors.amber,
                        child: RichText(
                          text: TextSpan(
                            text: "Can't find the",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.sp.clamp(0, 22),
                              fontFamily: "Poppins-Bold",
                              letterSpacing: 0.15.w,
                            ),
                            children: [
                              TextSpan(
                                text: " perfect place ?",
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 239, 209),
                                  fontSize: 22.sp.clamp(0, 22),
                                  fontFamily: "Poppins-Bold",
                                  letterSpacing: 0.15.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25.h),
                        // padding: EdgeInsets.symmetric(horizontal: 5.h),
                        width: 330.w,
                        height: 256.h,
                        child: Image.asset(
                          "assets/home/Undraw-1.png",
                          height: 256.h,
                          width: 252.w,
                        ),
                      ),
                      SizedBox(height : 20.h),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 40.h),
                        // width: 380.w,
                        // height: 40.h,
                        // color: Colors.amber,
                        child: RichText(
                          text: TextSpan(
                            text:
                                "Our specialists are here to help you discover on",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp.clamp(0, 16),
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                              // letterSpacing: 1.5.w
                            ),
                            children: [
                              TextSpan(
                                text: " idea accomodation",
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 239, 209),
                                  fontSize: 16.sp.clamp(0, 16),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      Container(
                        // color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Constant.width*0.5,
                              height: Constant.height * 0.03,
                              padding: EdgeInsets.only(left: 25.h),
                              // color: Colors.green,
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/home/advice icon.png",
                                    fit: BoxFit.fitHeight,
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "  Free Advice",
                                        style: TextStyle(
                                          fontSize: 16.sp.clamp(0, 16),
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.15.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: Constant.width*0.5,
                              height: Constant.height * 0.03,
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/home/quick response.png",
                                    fit: BoxFit.contain
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "  Quick Response",
                                        style: TextStyle(
                                          fontSize: 16.sp.clamp(0, 16),
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.15.w,
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
                      SizedBox(height: 15.h),
                      Container(
                        // color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Constant.width*0.5,
                              height: Constant.height * 0.03,
                              padding: EdgeInsets.only(left: 25.h),
                              // color: Colors.green,
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/home/247 support.png",
                                    fit: BoxFit.fitHeight,
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "  24/7 support",
                                        style: TextStyle(
                                          fontSize: 16.sp.clamp(0, 16),
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.15.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: Constant.width*0.5,
                              height: Constant.height * 0.03,
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/home/help.png",
                                    fit: BoxFit.contain
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "  Helped 1k+ students",
                                        style: TextStyle(
                                          fontSize: 16.sp.clamp(0, 16),
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.15.w,
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
                     SizedBox(height: 35.h),
                      Container(
                        margin: EdgeInsets.only(left: 30.h, right: 50.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 30.h),
                              height: Constant.height * 0.045,
                              // width: 130.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: Color(0xFF00EFD1)
                              ),
                              child: Align(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      child: Image.asset(
                                        "assets/home/whatsapp icon.png",
                                        height: 20.h,
                                        width: 20.w,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Constant.height * 0.022,
                                      child: FittedBox(
                                        child: Text(
                                          " Whatsapp Us",
                                          style: TextStyle(
                                            fontFamily: "Plus Jakarta Sans",
                                            fontSize: 14.sp.clamp(0, 14),
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15.h),
                              height: Constant.height * 0.045,
                              // width: 130.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: Color(0xFFEDEDED)
                              ),
                              child: Align(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      child: Image.asset(
                                        "assets/home/customer-service.png",
                                        height: 20.h,
                                        width: 20.w,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Constant.height * 0.02,
                                      child: FittedBox(
                                        child: Text(
                                          " Speak to an Expert",
                                          style: TextStyle(
                                            fontFamily: "Plus Jakarta Sans",
                                            fontSize: 14.sp.clamp(0, 14),
                                            fontWeight: FontWeight.w600,
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
                      SizedBox(
                        height: 180.h,
                        width: MediaQuery.of(context).size.width,
                        // color: Colors.orange
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
