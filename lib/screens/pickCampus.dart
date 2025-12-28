import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/firebase/constants.dart';
import 'package:on_campus/firebase/firestore_db.dart';
import 'package:on_campus/screens/Home%20Page%20Views/home.dart';
import 'package:on_campus/screens/bottom_nav.dart';

class Pickcampus extends StatefulWidget {
  final String username;
  const Pickcampus({super.key, required this.username});

  @override
  State<Pickcampus> createState() => _PickcampusState();
}

class _PickcampusState extends State<Pickcampus> {
  TextEditingController searchController = TextEditingController();
  int selectedIndex = 0;
  bool pop = false;
  List<Regions> regions = [];
  int index = 0;
  bool isLoading = false;

  void getRegions() async {
    setState(() {
      isLoading = true;
    });
    // showLoaderDialog(context);
    List<Regions> awaitRegions = await FirestoreDb.instance.getRegions(context);

    if (awaitRegions.isNotEmpty) {
      setState(() {
        regions = awaitRegions;
        isLoading = false;
      });
    }
    ;
    // Navigator.of(context).pop();
  }

  void initState() {
    super.initState();
    getRegions();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return IntrinsicHeight(
                      child: Container(
                        width: double.infinity,
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
                            Center(
                              child: Text(
                                "Choose hostel category",
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            const Divider(color: Colors.black12),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 80,
                                left: 40,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Get.to(
                                        () => BottomNav(
                                          // username: widget.username,
                                        ),
                                        transition: Transition.fadeIn,
                                        curve: Curves.easeIn,
                                        duration: const Duration(seconds: 1),
                                      );
                                    },
                                    child: Text(
                                      "Male",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.to(
                                        () => BottomNav(
                                          // username: widget.username,
                                        ),
                                        transition: Transition.fadeIn,
                                        curve: Curves.easeIn,
                                        duration: const Duration(seconds: 1),
                                      );
                                    },
                                    child: Text(
                                      "Female",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.to(
                                        () => BottomNav(
                                          // username: widget.username,
                                        ),
                                        transition: Transition.fadeIn,
                                        curve: Curves.easeIn,
                                        duration: const Duration(seconds: 1),
                                      );
                                    },
                                    child: Text(
                                      "No Preference",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search_outlined),
                            prefixIconColor: Colors.grey,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),

                            hintText: "Search by Region, University...",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              // fontWeight: FontWeight.w600,
                              fontSize: 13.sp.clamp(0, 13),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    isLoading
                        ? Center(
                            child: SpinKitThreeBounce(
                              color: const Color.fromARGB(255, 0, 239, 209),
                              size: 50.0,
                            ),
                          )
                        : Padding(
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
                                          debugPrint(
                                            "this is the value of selected :r ${reg.name}",
                                          );
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 600,
                                        ),
                                        margin: EdgeInsets.only(
                                          right: 30,
                                          left: 0,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
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
                          isLoading
                              ? Center(
                                  child: SpinKitThreeBounce(
                                    color: const Color.fromARGB(
                                      255,
                                      0,
                                      239,
                                      209,
                                    ),
                                    size: 50.0,
                                  ),
                                )
                              : Expanded(
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
