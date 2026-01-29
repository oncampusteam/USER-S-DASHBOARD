import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:on_campus/screens/filter.dart';
import 'package:on_campus/classes/classes.dart';
import 'package:on_campus/screens/receipt.dart';
import 'package:on_campus/screens/get_icon.dart';
import 'package:on_campus/screens/map_page.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:on_campus/screens/bottom_nav.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:on_campus/firebase/firestore_db.dart';
import 'package:on_campus/firebase/hostelController.dart';
import 'package:on_campus/widgets/home_page_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
// import 'package:on_campus/screens/Home%20Page%20Views/home.dart';
// import 'package:on_campus/screens/get_icon.dart';
// import 'package:on_campus/screens/hostels_detail.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

TextEditingController searchController = TextEditingController();

class _SearchState extends State<Search> {
  final HostelController hostelController = Get.find();
  List<Hostels> filteredHostels = [];
  List<Hostels> searchList = [];

  List<Hostels> recommendedHostels = [];
  List<Swipper> swipers = [
    Swipper(image: "assets/search/search_imgs.jpeg"),
    Swipper(image: "assets/search/search_imgs_1.jpeg"),
    Swipper(image: "assets/search/search_imgs_2.jpeg"),
    Swipper(image: "assets/search/search_imgs_3.jpeg"),
    Swipper(image: "assets/search/search_imgs_4.jpeg"),
  ];

  void search(String value) {
    final hostels = hostelController.popularHostels;
    searchList = hostels
        .where((item) => item.name.toLowerCase().contains(value.toLowerCase()))
        .toList();

    setState(() {
      filteredHostels = searchList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final hostels = hostelController.popularHostels;
      final recommendedHostels = hostelController.privateHostels;
      return Scaffold(
        body: SizedBox(
          height: Constant.height,
          width: Constant.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  width: MediaQuery.sizeOf(context).width,
                  height: Constant.height + (Constant.height * 0.1),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: Constant.height * 0.3,
                        child: Swiper(
                          controller: SwiperController(),
                          autoplay: true,
                          curve: Curves.easeIn,
                          pagination: SwiperPagination(
                            margin: EdgeInsets.only(
                              bottom: Constant.height * 0.04,
                            ),
                          ),
                          autoplayDelay: 5000,
                          itemCount: swipers.length,
                          itemBuilder: (context, index) {
                            Swipper swiper = swipers[index];
                            return Image.asset(
                              swiper.image,
                              width: MediaQuery.sizeOf(context).width,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      Container(
                        height: Constant.height * 0.3,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            end: Alignment.bottomCenter,
                            begin: Alignment.topCenter,
                            colors: [Colors.black12, Colors.black87],
                          ),
                        ),
                        child: SizedBox(
                          height: Constant.height * 0.3,
                          width: MediaQuery.sizeOf(context).width,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      height: 40.h,
                                      width: 40.w,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.chevron_left,
                                          size: 24.sp.clamp(0, 24),
                                        ),
                                        color: Colors.black38,
                                        onPressed: () {
                                          // setState(() {
                                          //   bottomNav.currentPage.value = 2;
                                          // });
                                          Get.to(
                                            () => const BottomNav(
                                              username: "",
                                              subindex: 2,
                                            ),
                                            transition: Transition.fadeIn,
                                            curve: Curves.easeIn,
                                            duration: const Duration(
                                              milliseconds: 600,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Image.asset(
                                      "assets/welcome_page_views/transparent_logo-removebg.png",
                                      height: 45.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          () => Filter(
                                            hostels: hostels,
                                            onApply: (filtered) {
                                              setState(() {
                                                filteredHostels = filtered;
                                                print(
                                                  "filteredHostels:${filteredHostels}",
                                                );
                                              });
                                            },
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                            255,
                                            255,
                                            255,
                                            .4,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        height: 30.h,
                                        width: 30.w,
                                        child: Image.asset(
                                          "assets/search/menu.png",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                SizedBox(
                                  // color: Colors.red,
                                  width: Constant.width * 0.85,
                                  height: Constant.height * 0.08,
                                  child: Align(
                                    child: Container(
                                      height: Constant.height * 0.055,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          24.r,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          24.r,
                                        ),
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
                                                  height:
                                                      Constant.height * 0.025,
                                                  child: FittedBox(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Search by hostel's name or location",
                                                      style: TextStyle(
                                                        fontFamily: "Inter",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color(
                                                          0xFFBBBBBB,
                                                        ),
                                                        fontSize: 15.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: 20,
                                              child: SizedBox(
                                                // color: Colors.red,
                                                height: Constant.height * 0.045,
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
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: Constant.height * 0.28,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(28.r),
                              topRight: Radius.circular(23.r),
                            ),
                          ),
                          // height: Constant.height,
                          child: Column(
                            children: [
                              SizedBox(height: 25.h),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 25.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: Constant.height * 0.03,
                                      width: Constant.width * 0.6,
                                      child: Text(
                                        "Most searched hostels",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF323232),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Constant.height * 0.025,
                                      width: Constant.width * 0.2,
                                      child: Text(
                                        "View all",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF00EFD1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),

                              searchController.text.isNotEmpty &&
                                      searchList.isEmpty
                                  ? Center(
                                      child: Text(
                                        "Couldnt find... ${searchController.text}",
                                      ),
                                    )
                                  : filteredHostels.isNotEmpty
                                  ? SizedBox(
                                      height: 300,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: filteredHostels.length,
                                        itemBuilder: (BuildContext, index) {
                                          Hostels filteredHostel =
                                              filteredHostels[index];
                                          return Row(
                                            children: [
                                              if (index == 0)
                                                SizedBox(width: 20.w),
                                              hostelCardVariant(
                                                type: "mostSearch",
                                                hostel: filteredHostel,
                                                variant2: true,
                                              ),
                                              if (index + 1 == hostels.length)
                                                SizedBox(width: 20.w),
                                            ],
                                          );
                                        },
                                      ),
                                    )
                                  : SizedBox(
                                      height: 300,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: hostels.length,
                                        itemBuilder: (BuildContext, index) {
                                          Hostels hostel = hostels[index];
                                          return Row(
                                            children: [
                                              if (index == 0)
                                                SizedBox(width: 20.w),
                                              hostelCardVariant(
                                                type: "mostSearch",
                                                hostel: hostel,
                                                variant2: true,
                                              ),
                                              if (index + 1 == hostels.length)
                                                SizedBox(width: 20.w),
                                            ],
                                          );
                                        },
                                      ),
                                    ),

                              SizedBox(height: 15.h),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 25.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: Constant.height * 0.03,
                                      width: Constant.width * 0.6,
                                      child: Text(
                                        "Recommend for you",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF323232),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Constant.height * 0.025,
                                      width: Constant.width * 0.2,
                                      child: Text(
                                        "View all",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF00EFD1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                height: Constant.height * 0.335,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: recommendedHostels.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        if (index == 0) SizedBox(width: 20.w),
                                        hostelCardVariant(
                                          type: "recommended",
                                          hostel: recommendedHostels[index],

                                          variant2: true,
                                        ),
                                        if (index + 1 ==
                                            recommendedHostels.length)
                                          SizedBox(width: 20.w),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 150.h)
              ],
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          width: 90,
          child: ElevatedButton(
            onPressed: () {
              Get.to(() => MapPage(hostels: hostels));
            },

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
    });
  }
}
