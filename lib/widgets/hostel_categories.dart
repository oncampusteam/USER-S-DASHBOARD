import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/screens/get_icon.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:on_campus/firebase/firestore_db.dart';
import 'package:on_campus/classes/screen_details.dart';
import 'package:on_campus/screens/hostels_detail.dart';
import 'package:on_campus/firebase/hostelController.dart';
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
  // bool isLoading = true;
  final HostelController hostelController = Get.put(HostelController());

  List<Hostels> searchList = [];

  void search(String value) {
    List<Hostels> allPrivateHostels = hostelController.privateHostels;
    searchList = allPrivateHostels
        .where((item) => item.name.toLowerCase().contains(value.toLowerCase()))
        .toList();

    setState(() {});
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
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
                            child: IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: Icon(
                                Icons.chevron_left,
                                color: Colors.black,
                                size: 30.w,
                              ),
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
                                    widget.categoryType,
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

                  // isLoading
                  //     ? Container(
                  //         child: Center(
                  //           child: Center(
                  //             child: SpinKitThreeBounce(
                  //               color: const Color.fromARGB(255, 0, 239, 209),
                  //               size: 50.0,
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //     :
                  (searchController.text.isEmpty)
                      ? SizedBox(
                          height: Constant.height * 0.75,
                          child: Obx(() {
                            List<Hostels> allPrivateHostels =
                                hostelController.privateHostels;
                            print(
                              "all private hostels are ${allPrivateHostels} length ${allPrivateHostels.length} ",
                            );
                            return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: allPrivateHostels.length,
                              itemBuilder: (BuildContext context, int index) {
                                Hostels hostel = allPrivateHostels[index];
                                return Column(
                                  children: [
                                    if (index == 0) SizedBox(height: 12.h),
                                    hostelCardVariant(
                                      hostel: hostel,
                                      variant: true,
                                      type: "search",
                                    ),
                                    if (index + 1 == allPrivateHostels.length)
                                      SizedBox(height: Constant.height * 0.1),
                                  ],
                                );
                              },
                            );
                          }),
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
                              // //debugPrint(string);
                              // //debugPrint(searchHostel.name);
                              return Column(
                                children: [
                                  if (index == 0) SizedBox(height: 12.h),
                                  hostelCardVariant(
                                    hostel: searchHostel,
                                    variant: true,
                                    type: "search",
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
