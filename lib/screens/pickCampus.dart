import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:on_campus/screens/bottom_nav.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:on_campus/firebase/firestore_db.dart';
import 'package:on_campus/firebase/hostelController.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Pickcampus extends StatefulWidget {
  final String username;
  const Pickcampus({super.key, required this.username});

  @override
  State<Pickcampus> createState() => _PickcampusState();
}

class _PickcampusState extends State<Pickcampus> {
  final HostelController hostelController = Get.find();
  TextEditingController searchController = TextEditingController();
  int selectedIndex = 0;
  bool pop = false;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final regions = hostelController.regions;
      return Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.white,
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.33,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.03,
                            child: FittedBox(
                              child: Text(
                                "Choose category",
                                style: TextStyle(
                                  fontSize: 19,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 40,
                              left: 40,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.to(
                                      () =>
                                          BottomNav(username: widget.username),
                                      transition: Transition.fadeIn,
                                      curve: Curves.easeIn,
                                      duration: const Duration(seconds: 1),
                                    );
                                  },
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.03,
                                    child: FittedBox(
                                      child: Text(
                                        "Male Hostel",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "Poppins",
                                          color: Color(0xFF323232),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.to(
                                      () =>
                                          BottomNav(username: widget.username),
                                      transition: Transition.fadeIn,
                                      curve: Curves.easeIn,
                                      duration: const Duration(seconds: 1),
                                    );
                                  },
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.03,
                                    child: FittedBox(
                                      child: Text(
                                        "Female Hostel",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF323232),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.to(
                                      () =>
                                          BottomNav(username: widget.username),
                                      transition: Transition.fadeIn,
                                      curve: Curves.easeIn,
                                      duration: const Duration(seconds: 1),
                                    );
                                  },
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.03,
                                    child: FittedBox(
                                      child: Text(
                                        "Mixed / Any Hostel",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF323232),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Poppins,",
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
                    );
                  },
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 50.h, left: 20.w, right: 20.w),
                height: 50,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 239, 209),
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                ),
                width: 330.w,
                child: Align(
                  child: SizedBox(
                    height: Constant.height * 0.03,
                    child: FittedBox(
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 20.sp.clamp(0, 20),
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 60),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: FittedBox(
                          child: Text(
                            "Pick Your Campus",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 31.sp.clamp(0, 31),
                              fontFamily: "Poppins-Bold",
                              // fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      // color: Colors.red,
                      width: Constant.width,
                      height: Constant.height * 0.09,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: Constant.height * 0.065,
                          width: Constant.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.r),
                            // border: Border.all(
                            //   color: Color(0xFF00EFD1),
                            // ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 1),
                                blurRadius: 4,
                                spreadRadius: 0,
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                              ),
                            ],
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
                                        height: Constant.height * 0.065,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: SizedBox(
                                            height: Constant.height * 0.025,
                                            child: FittedBox(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Search by hostel's name or location",
                                                style: TextStyle(
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.bold,
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
                                        borderRadius: BorderRadius.circular(
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
                                      // Get.to(() => Search());
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
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: regions.length,
                          itemBuilder: (BuildContext context, int index) {
                            Regions reg = regions[index];
                            return Center(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    //debugPrint(
                                    // "this is the value of selected :r ${reg.name}",
                                    // );
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 600),
                                  margin: EdgeInsets.only(right: 30, left: 0),
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    border: selectedIndex == index
                                        ? Border(
                                            bottom: BorderSide(
                                              color: const Color.fromARGB(
                                                255,
                                                0,
                                                239,
                                                209,
                                              ),
                                              width: 2,
                                            ),
                                          )
                                        : null,
                                  ),
                                  child: SizedBox(
                                    child: Text(
                                      reg.name,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp.clamp(0, 12),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/pickCampus/University.png",
                            height: 35,
                            width: 40,
                          ),
                          SizedBox(width: 5.w),
                          Expanded(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  child: FittedBox(
                                    child: Text(
                                      "Popular Universities in ${regions[selectedIndex].name}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontSize: 19.sp.clamp(0, 19),
                                        fontWeight: FontWeight.w600,
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
          ),
        ],
      );
    });
  }
}
