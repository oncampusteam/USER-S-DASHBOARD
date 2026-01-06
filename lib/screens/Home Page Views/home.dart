import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:on_campus/screens/search.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:on_campus/firebase/firestore_db.dart';
import 'package:on_campus/widgets/home_page_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_campus/screens/bottom_nav.dart' as bottomNav;
// import 'package:on_campus/screens/hostels_detail.dart';
// import 'package:on_campus/widgets/homestel_hostel_category.dart';
// import 'package:on_campus/widgets/hostel_categories.dart';
// import 'package:on_campus/widgets/school_hostel_category.dart';
// import 'package:on_campus/screens/get_icon.dart';

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
      //   debugdebugPrint("");
      // }
      // myLocations = awaitLocations;
      isLoading = false;
    });
  }

  // List<bool> favoritebools = [];
  // FocusNode search = FocusNode();
  @override
  void initState() {
    super.initState();
    setState(() {
      user = FirebaseAuth.instance.currentUser;
    });

    getPopular();
  }

  String getFirstName() {
    debugPrint(widget.username);
    String text = widget.username ?? "${user?.displayName}";
    if (text.trim().isEmpty) return '';
    return text.trim().split(' ').first;
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
                                        "Welcome ${getFirstName()},",
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
                                    width: Constant.width * 0.8,
                                    child: FittedBox(
                                      alignment: Alignment.centerLeft,
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
                      SizedBox(
                        // color: Colors.red,
                        width: Constant.width,
                        child: Align(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                // color: Colors.red,
                                width: Constant.width * 0.8,
                                height: Constant.height * 0.08,
                                child: Align(
                                  child: Container(
                                    height: Constant.height * 0.065,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24.r),
                                      border: Border.all(
                                        color: Color(0xFF00EFD1),
                                      ),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     offset: Offset(0, 1),
                                      //     blurRadius: 4,
                                      //     spreadRadius: 0,
                                      //     color: Color.fromRGBO(0, 0, 0, 0.25),
                                      //   ),
                                      // ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(24.r),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            right: 0,
                                            bottom: 0,
                                            child: TextField(
                                              // decoration: TextDecoration.none,
                                              style: TextStyle(
                                                decoration: TextDecoration.none,
                                              ),
                                              obscureText: false,
                                              enableSuggestions: true,
                                              autocorrect: true,
                                              cursorColor: Colors.black,
                                              controller: searchController,
                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                prefixIcon: SizedBox(
                                                  width: 30.w,
                                                  height: 40.h,
                                                ),
                                                hint: SizedBox(
                                                  // color: Colors.blue,
                                                  height:
                                                      Constant.height * 0.065,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: SizedBox(
                                                      height:
                                                          Constant.height *
                                                          0.025,
                                                      child: FittedBox(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "   Search for hostels",
                                                          style: TextStyle(
                                                            fontFamily: "Inter",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: const Color(
                                                              0xFFBBBBBB,
                                                            ),
                                                            fontSize: 15.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        24.r,
                                                      ),
                                                  // borderSide: const BorderSide(color: Color(0xFF00EFD1)),
                                                  borderSide: BorderSide.none,
                                                ),
                                                contentPadding: EdgeInsets.zero,
                                                //   focusedBorder: OutlineInputBorder(
                                                //     borderRadius: BorderRadius.circular(16.r),
                                                //     borderSide: const BorderSide(color: Colors.white),),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            left: 15,
                                            // top: 0,
                                            child: Container(
                                              // color: Colors.red,
                                              height: Constant.height * 0.06,
                                              width: 45.w,
                                              child: Image.asset(
                                                height: 60.h,
                                                width: 50.w,
                                                "assets/hostel_category_widget/ic-search@4x.png",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            right: 0,
                                            bottom: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.to(() => Search());
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                child: Container(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                height: 40.h,
                                width: 40.w,
                                // padding: EdgeInsets.all(5.r),
                                decoration: BoxDecoration(
                                  // color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Color(0xFF00EFD1)),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      height: 30.h,
                                      width: 30.w,
                                      "assets/home/hugeicons--notification-01 (1).svg",
                                      // colorFilter: ColorFilter.mode(Color(0xFF00EFD1), blend),
                                      // fit: BoxFit.cover
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        padding: EdgeInsets.all(2.5),
                                        width: 20.w,
                                        height: 20.h,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Align(
                                          child: Container(
                                            width: 15.w,
                                            height: 15.h,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF00EFD1),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Align(
                                              child: Text(
                                                "1",
                                                style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white,
                                                  fontSize: 7.sp,
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
                      ),
                      SizedBox(height: 20.h),
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
                                // onTap: () => Get.to(
                                //   () => SchoolHostelCategory(),
                                //   transition: Transition.fadeIn,
                                //   duration: const Duration(milliseconds: 200),
                                //   curve: Curves.easeIn,
                                // ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/home/Ellipse 3.png",
                                      height: 60,
                                      width: 60,
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
                                onTap: () {
                                  bottomNav.currentPage.value = 5;

                                  bottomNav.hostelCategory = "Private";
                                  // setState(() {
                                  //   Get.to(
                                  //     () => BottomNav(
                                  //       username: widget.username ?? "",
                                  //       subindex: 5,
                                  //     ),
                                  //     transition: Transition.fadeIn,
                                  //     duration: const Duration(
                                  //       milliseconds: 200,
                                  //     ),
                                  //     curve: Curves.easeIn,
                                  //   );
                                  // });
                                  setState(() {});
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/home/Ellipse 4.png",
                                      height: 60,
                                      width: 60,
                                    ),
                                    SizedBox(height: 15),
                                    SizedBox(
                                      height: Constant.height * 0.025,
                                      child: FittedBox(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "   Private Hostel",
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  bottomNav.currentPage.value = 5;
                                  bottomNav.hostelCategory = "Private";
                                  // () => Get.to(
                                  //   () => BottomNav(
                                  //     username: widget.username ?? "",
                                  //   ),
                                  //   transition: Transition.fadeIn,
                                  //   duration: const Duration(milliseconds: 200),
                                  //   curve: Curves.easeIn,
                                  // );
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/home/Ellipse 5.png",
                                      height: 60,
                                      width: 60,
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
                      SizedBox(height: 20),
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
                                  // backgroundColor: WidgetStateProperty.all(
                                  //   Color.fromRGBO(0, 239, 209, .07),
                                  // ),
                                  // overlayColor: WidgetStateProperty.all(
                                  //   Color.fromRGBO(0, 239, 209, .5),
                                  // ),
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
                                  // backgroundColor: WidgetStateProperty.all(
                                  //   Color.fromRGBO(0, 239, 209, .07),
                                  // ),
                                  // overlayColor: WidgetStateProperty.all(
                                  //   Color.fromRGBO(0, 239, 209, .5),
                                  // ),
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
                                      hostelCardVariant(
                                        hostel: hostels[index],
                                        favorite: favorite,
                                        triggerRebuild: () {
                                          setState(() {});
                                        },
                                      ),
                                      if (index + 1 == hostels.length)
                                        SizedBox(width: 20.w),
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
                        // color: Colors.red,
                        margin: EdgeInsets.symmetric(horizontal: 25.h),
                        // padding: EdgeInsets.symmetric(horizontal: 5.h),
                        height: Constant.height * 0.3,
                        width: Constant.width,
                        child: Image.asset(
                          "assets/home/Undraw-1.png",
                          // height: Constant.height * 0.15,
                          // width: Constant.width,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 20.h),
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
                              width: Constant.width * 0.5,
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
                              width: Constant.width * 0.5,
                              height: Constant.height * 0.03,
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/home/quick response.png",
                                    fit: BoxFit.contain,
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
                              width: Constant.width * 0.5,
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
                              width: Constant.width * 0.5,
                              height: Constant.height * 0.03,
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/home/help.png",
                                    fit: BoxFit.contain,
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
                        margin: EdgeInsets.only(left: 30.h, right: 30.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 30.h),
                              height: Constant.height * 0.045,
                              // width: 130.w,
                              width: Constant.width * 0.39,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: Color(0xFF00EFD1),
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
                              width: Constant.width * 0.39,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: Color(0xFFEDEDED),
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
