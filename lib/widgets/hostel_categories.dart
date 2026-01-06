import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/screens/get_icon.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:on_campus/firebase/firestore_db.dart';
import 'package:on_campus/classes/screen_details.dart';
import 'package:on_campus/screens/hostels_detail.dart';
import 'package:on_campus/widgets/home_page_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:on_campus/screens/bottom_nav.dart' as bottomNav;

class HostelCategory extends StatefulWidget {
  final String categoryType;
  const HostelCategory({super.key, required this.categoryType});

  @override
  State<HostelCategory> createState() => _HostelCategoryState();
}

class _HostelCategoryState extends State<HostelCategory> {
  bool favorite = false;
  bool isLoading = true;

  List<Hostels> allPrivateHostels = [];
  List<Hostels> searchList = [];

  Future<void> getPrivateHostels() async {
    setState(() {
      isLoading = true;
    });
    List<Hostels> awaitPrivateHostels = await FirestoreDb.instance
        .getPrivateHostels();
    awaitPrivateHostels.shuffle();
    if (awaitPrivateHostels.isNotEmpty) {
      setState(() {
        allPrivateHostels = awaitPrivateHostels;
        favoriteBools = List.generate(allPrivateHostels.length, (index) {
          return false;
        });
        isLoading = false;
      });
    }
  }

  void search(String value) {
    searchList = allPrivateHostels
        .where((item) => item.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    searchFavoriteBools = List.generate(searchList.length, (index) {
      return false;
    });
    setState(() {});
  }

  List<bool> favoriteBools = [];
  List<bool> searchFavoriteBools = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getPrivateHostels();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(top: Constant.height * 0.06),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: ScreenDetails.ScreenWidth,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            bottomNav.currentPage.value = 2;
                            // Navigator.pop(context);
                            // BottomNav(username: username)
                          },
                          child: Container(
                            height: 40.h,
                            width: 45.w,
                            foregroundDecoration: BoxDecoration(
                              color: const Color.fromRGBO(0, 0, 0, 0.03),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            // decoration: BoxDecoration(
                            //   color: Colors.white.withOpacity(0.1),
                            //   borderRadius: BorderRadius.circular(8.r),
                            // ),
                            child: Icon(
                              Icons.chevron_left,
                              color: Colors.black,
                              size: 30.w,
                            ),
                          ),
                        ),
                        // SizedBox(width: 60.w),
                        Expanded(
                          child: SizedBox(
                            height: Constant.height * 0.05,
                            child: Align(
                              child: SizedBox(
                                // color: Colors.red,
                                height: Constant.height * 0.04,
                                width: Constant.width * 0.85,
                                child: FittedBox(
                                  child: Text(
                                    "Private Hostels",
                                    style: TextStyle(
                                      fontFamily: "Poppins-Bold",
                                      fontSize: 22.sp,
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
                  SizedBox(height: 20.h),

                  Container(
                    // color: Colors.red,
                    height: Constant.height * 0.08,
                    child: Align(
                      child: Container(
                        height: Constant.height * 0.055,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.r),
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
                              TextField(
                                onChanged: (value) {
                                  search(value);
                                },
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
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Search by hostel's name or location",
                                        style: TextStyle(
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFFBBBBBB),
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  // OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(24.r),
                                  //   borderSide: const BorderSide(color: Colors.white),
                                  //   ),
                                  //   focusedBorder: OutlineInputBorder(
                                  //     borderRadius: BorderRadius.circular(16.r),
                                  //     borderSide: const BorderSide(color: Colors.white),),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 20,
                                child: Container(
                                  // color: Colors.red,
                                  height: Constant.height * 0.05,
                                  width: 30.w,
                                  child: Image.asset(
                                    "assets/hostel_category_widget/ic-search@4x.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 30.h),
                  // Container(
                  //   color: Colors.white,
                  //   height: Constant.height * 0.06,
                  //   width: Constant.width,
                  //   child: Container(child: Text("HI")),
                  // ),
                  // SizedBox(height: 30.h),
                  (isLoading)
                      ? Container(
                          child: Center(
                            child: Center(
                              child: SpinKitThreeBounce(
                                color: const Color.fromARGB(255, 0, 239, 209),
                                size: 50.0,
                              ),
                            ),
                          ),
                        )
                      : (searchController.text.isEmpty)
                      ? SizedBox(
                          height: Constant.height * 0.75,
                          // decoration: BoxDecoration(),
                          // margin: EdgeInsets.only(bottom: 450.h),
                          // height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: allPrivateHostels.length,
                            itemBuilder: (BuildContext context, int index) {
                              Hostels hostel = allPrivateHostels[index];
                              // String? string = hostel.hostel_images?[0];
                              // debugPrint(hostel.name);
                              return Column(
                                children: [
                                  if (index == 0) SizedBox(height: 12.h),
                                  hostelCardVariant(
                                    hostel: hostel,
                                    favorite: favoriteBools[index],
                                    variant: true,
                                    triggerRebuild: () {
                                      setState(() {
                                        favoriteBools[index] =
                                            !favoriteBools[index];
                                      });
                                    },
                                    index: index,
                                  ),
                                  if (index + 1 == allPrivateHostels.length)
                                    SizedBox(height: Constant.height * 0.1),
                                ],
                              );
                            },
                          ),
                        )
                      : (searchList.isEmpty)
                      ? Center(
                          child: Text(
                            "Couldnt find... ${searchController.text}",
                          ),
                        )
                      : SizedBox(
                          // decoration: BoxDecoration(),
                          height: MediaQuery.of(context).size.height * 0.75,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: searchList.length,
                            itemBuilder: (BuildContext context, int index) {
                              Hostels searchHostel = searchList[index];
                              // String? string = searchHostel.hostel_images?[0];
                              // debugPrint(string);
                              // debugPrint(searchHostel.name);
                              return Column(
                                children: [
                                  if (index == 0) SizedBox(height: 12.h),
                                  hostelCardVariant(
                                    hostel: searchHostel,
                                    favorite: true,
                                    variant: true,
                                    triggerRebuild: () {
                                      setState(() {});
                                    },
                                    index: index,
                                  ),
                                  if (index + 1 == searchList.length &&
                                      searchList.length > 1)
                                    SizedBox(height: Constant.height * 0.1),
                                ],
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
