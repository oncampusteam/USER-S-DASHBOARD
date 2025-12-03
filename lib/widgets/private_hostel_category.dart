import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:on_campus/classes/screen_details.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/firebase/firestore_db.dart';
import 'package:on_campus/screens/get_icon.dart';
import 'package:on_campus/screens/hostels_detail.dart';

class PrivateHostelCategory extends StatefulWidget {
  const PrivateHostelCategory({super.key});

  @override
  State<PrivateHostelCategory> createState() => _PrivateHostelCategoryState();
}

class _PrivateHostelCategoryState extends State<PrivateHostelCategory> {
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
        isLoading = false;
      });
    }
  }

  void search(String value) {
    searchList = allPrivateHostels
        .where((item) => item.name.toLowerCase().contains(value.toLowerCase()))
        .toList();

    setState(() {});
  }

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getPrivateHostels();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 30.h,
                          width: 35.w,
                          foregroundDecoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.03),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.chevron_left,
                            color: Colors.black,
                            size: 24.w,
                          ),
                        ),
                      ),
                      SizedBox(width: 60.w),
                      SizedBox(
                        height: 24.h,
                        child: Text(
                          "Private Hostels",
                          style: TextStyle(
                            fontFamily: "Poppins-Bold",
                            fontSize: 22.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 50.h,
                  child: TextField(
                    onChanged: (value) {
                      search(value);
                    },
                    obscureText: false,
                    enableSuggestions: true,
                    autocorrect: true,
                    cursorColor: Colors.black,
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search by hostel's name or location",
                      hintStyle: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFBBBBBB),
                        fontSize: 15.sp,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: const BorderSide(color: Color(0xFFBBBBBB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: const BorderSide(color: Color(0xFFB7B7B7)),
                      ),
                      prefixIcon: SizedBox(
                        // color: Colors.red,
                        width: 70.w,
                        height: 40.h,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 7.h,
                              left: 20.h,
                              child: Icon(
                                Icons.search,
                                color: Colors.black.withOpacity(0.1),
                                size: 20.h,
                              ),
                            ),
                            Positioned(
                              bottom: 10.h,
                              left: 20.h,
                              child: Icon(
                                Icons.search,
                                color: const Color(0xFFB7B7B7),
                                size: 20.h,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
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
                    ? Container(
                        decoration: BoxDecoration(),
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: allPrivateHostels.length,
                          itemBuilder: (BuildContext context, int index) {
                            Hostels hostel = allPrivateHostels[index];
                            String? string = hostel.hostel_images?[0];
                            print(hostel.name);
                            return GestureDetector(
                              onTap: () async {
                                Get.to(
                                  () => HostelDetails(
                                    hostel: hostel,
                                  ),
                                  transition: Transition.fadeIn,
                                  duration: const Duration(milliseconds: 800),
                                  curve: Curves.easeIn,
                                );
                                await FirestoreDb.instance.roomTypes(hostel);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 2.0,
                                ),
                                child: Column(
                                  children: [
                                    Card(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 30,
                                        ),
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                // margin: EdgeInsets.only(right: 10.h),
                                                height: 200,
                                                width: 330.w.clamp(0, 330),
                                                decoration: BoxDecoration(
                                                  // color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                              12.r,
                                                            ),
                                                        topRight:
                                                            Radius.circular(
                                                              12.r,
                                                            ),
                                                        bottomLeft:
                                                            Radius.circular(
                                                              12.r,
                                                            ),
                                                        bottomRight:
                                                            Radius.circular(
                                                              12.r,
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
                                                        borderRadius:
                                                            BorderRadius.only(
                                                              topLeft:
                                                                  Radius.circular(
                                                                    12.r,
                                                                  ),
                                                              topRight:
                                                                  Radius.circular(
                                                                    12.r,
                                                                  ),
                                                            ),
                                                        child: CachedNetworkImage(
                                                          imageUrl:
                                                              string ?? "",
                                                          height: 200,
                                                          width: 330.w.clamp(
                                                            0,
                                                            330,
                                                          ),
                                                          fit: BoxFit.cover,
                                                          placeholder:
                                                              (
                                                                context,
                                                                url,
                                                              ) => SpinKitThreeBounce(
                                                                color:
                                                                    const Color.fromARGB(
                                                                      255,
                                                                      0,
                                                                      239,
                                                                      209,
                                                                    ),
                                                                size: 50.0,
                                                              ),
                                                          errorWidget:
                                                              (
                                                                context,
                                                                url,
                                                                error,
                                                              ) => Icon(
                                                                Icons.error,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 5.h,
                                                      right: 5.h,
                                                      // left: 0,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          height: 35.h,
                                                          width: 35.w,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                          child: Icon(
                                                            size: 20.h,
                                                            hostel.ispopular!
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
                                                      bottom: 10,
                                                      left: 12,
                                                      child: SizedBox(
                                                        height: 20,
                                                        // width: 70,
                                                        child: ElevatedButton(
                                                          onPressed: () {},
                                                          style: ElevatedButton.styleFrom(
                                                            padding:
                                                                EdgeInsets.all(
                                                                  0,
                                                                ),
                                                          ),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .star_outline,
                                                                  size: 15,
                                                                  color:
                                                                      Color.fromARGB(
                                                                        255,
                                                                        0,
                                                                        239,
                                                                        209,
                                                                      ),
                                                                ),
                                                                SizedBox(
                                                                  width: 3,
                                                                ),
                                                                Text(
                                                                  "${hostel.rate}",
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 0,
                                                      left: 0,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                              left: 5,
                                                              right: 5,
                                                            ),
                                                        height: 16.h,
                                                        // width: 45.w,
                                                        decoration: BoxDecoration(
                                                          color:
                                                              const Color.fromRGBO(
                                                                50,
                                                                50,
                                                                50,
                                                                0.5,
                                                              ),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                bottomRight:
                                                                    Radius.circular(
                                                                      12.r,
                                                                    ),
                                                                topLeft:
                                                                    Radius.circular(
                                                                      12.r,
                                                                    ),
                                                              ),
                                                        ),
                                                        child: Text(
                                                          hostel.ispopular!
                                                              ? "popular"
                                                              : "",
                                                          style: TextStyle(
                                                            fontSize: 12.sp
                                                                .clamp(0, 12),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                "Roboto",
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Container(
                                                // color: Colors.green,
                                                padding: EdgeInsets.only(
                                                  left: 15.h,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      hostel.name,
                                                      style: TextStyle(
                                                        color:
                                                            const Color.fromARGB(
                                                              150,
                                                              0,
                                                              0,
                                                              0,
                                                            ),
                                                        fontSize: 18.sp.clamp(
                                                          0,
                                                          18,
                                                        ),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: "Poppins",
                                                      ),
                                                    ),
                                                    Text(
                                                      hostel.city ?? "",
                                                      style: TextStyle(
                                                        fontSize: 13.sp.clamp(
                                                          0,
                                                          18,
                                                        ),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: "Poppins",
                                                        color: const Color(
                                                          0xFF323232,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: "From ",
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                " GHS ${hostel.amt_per_year}/",
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
                                                    SizedBox(height: 7),
                                                    Container(
                                                      width: 300.w.clamp(
                                                        0,
                                                        300,
                                                      ),
                                                      height: 25,
                                                      child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: hostel
                                                            .amenities!
                                                            .length,
                                                        itemBuilder: (context, index) {
                                                          return Container(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets.only(
                                                                    left: 0.0,
                                                                    right: 8,
                                                                    top: 0,
                                                                    bottom: 0,
                                                                  ),
                                                              child: OutlinedButton(
                                                                style: OutlinedButton.styleFrom(
                                                                  padding:
                                                                      EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            3,
                                                                      ),
                                                                  foregroundColor:
                                                                      Colors
                                                                          .black,
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          5,
                                                                        ),
                                                                  ),
                                                                ),
                                                                onPressed:
                                                                    () {},
                                                                child: Container(
                                                                  // width: 40,
                                                                  // height: 20,
                                                                  child: Row(
                                                                    children: [
                                                                      GetIcon(
                                                                        text:
                                                                            hostel.amenities![index] ??
                                                                            "noicon",
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            3,
                                                                      ),
                                                                      Text(
                                                                        hostel.amenities![index] ??
                                                                            "none",
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
                                    SizedBox(height: 15),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : (searchList.isEmpty)
                    ? Center(
                        child: Text("Couldnt find... ${searchController.text}"),
                      )
                    : Container(
                        decoration: BoxDecoration(),
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: searchList.length,
                          itemBuilder: (BuildContext context, int index) {
                            Hostels search_hostel = searchList[index];
                            String? string = search_hostel.hostel_images?[0];
                            print(string);
                            print(search_hostel.name);
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => HostelDetails(
                                    hostel: search_hostel,
                                  ),
                                  transition: Transition.fadeIn,
                                  duration: const Duration(milliseconds: 800),
                                  curve: Curves.easeIn,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 2.0,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      // width: double.infinity,
                                      height: 110,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF5F8FF),
                                        // color: Colors.red,
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(0, 1),
                                            blurRadius: 3,
                                            spreadRadius: 1,
                                            color: Colors.black.withOpacity(
                                              0.15,
                                            ),
                                          ),
                                          BoxShadow(
                                            offset: const Offset(0, 1),
                                            blurRadius: 2,
                                            spreadRadius: 0,
                                            color: Colors.black.withOpacity(
                                              0.30,
                                            ),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            // color: Colors.red,
                                            height: 80.h,
                                            width: 80.w,
                                            child: CachedNetworkImage(
                                              imageUrl: string ?? "",
                                              placeholder: (context, url) =>
                                                  SpinKitThreeBounce(
                                                    color: const Color.fromARGB(
                                                      255,
                                                      0,
                                                      239,
                                                      209,
                                                    ),
                                                    size: 30.0,
                                                  ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                          SizedBox(width: 10.h),
                                          Container(
                                            // color: Colors.red,
                                            height: 80.h,
                                            padding: EdgeInsets.only(top: 5.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  height: 16.h,
                                                  child: FittedBox(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      search_hostel.name,
                                                      style: TextStyle(
                                                        fontFamily: "Roboto",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp,
                                                        letterSpacing: 0.15.w,
                                                        color: const Color(
                                                          0xFF1D1B20,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 12.h,
                                                  child: FittedBox(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.asset(
                                                          "assets/hostel_category_widget/location.png",
                                                          height: 12.h,
                                                          width: 8.77.w,
                                                        ),
                                                        Text(
                                                          "1995 Broadway, Kenyasi",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Roboto",
                                                            // fontWeight: FontWeight.w500,
                                                            fontSize: 10.sp,
                                                            // letterSpacing: 0.15.w,
                                                            color: const Color(
                                                              0xFF333333,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                FittedBox(
                                                  child: Container(
                                                    // color: Colors.red,
                                                    height: 20.h,
                                                    // width: 120.w,
                                                    child: Text(
                                                      "Wifi • Kitchen • Security • Parking •\nBalcony • Friendly Environment",
                                                      overflow:
                                                          TextOverflow.visible,
                                                      style: TextStyle(
                                                        fontFamily: "Roboto",
                                                        // fontWeight: FontWeight.w500,
                                                        fontSize: 9.sp,
                                                        letterSpacing: 0.25.w,
                                                        color: const Color(
                                                          0xFF1D1B20,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 5.h),
                                                Container(
                                                  height: 12.h,
                                                  child: FittedBox(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "${search_hostel.rate}.0",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Roboto",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 10.sp,
                                                            color: const Color(
                                                              0xFF333333,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 5.h),
                                                        SizedBox(
                                                          height: 10,
                                                          width: 60,
                                                          child: ListView.builder(
                                                            itemCount:
                                                                search_hostel
                                                                    .rate,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemBuilder:
                                                                (
                                                                  context,
                                                                  index,
                                                                ) {
                                                                  return Icon(
                                                                    Icons.star,
                                                                    color: const Color(
                                                                      0xFF00EFD1,
                                                                    ),
                                                                    size: 10.h,
                                                                  );
                                                                },
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            // Image.asset("warning.png", height: 12, width: 10,),
                                                            Transform.flip(
                                                              flipY: true,
                                                              child: Icon(
                                                                Icons.info,
                                                                color:
                                                                    Colors.red,
                                                                size: 10.h,
                                                              ),
                                                            ),
                                                            Text(
                                                              " ${search_hostel.available_rooms} Slots available",
                                                              style: TextStyle(
                                                                color:
                                                                    const Color.fromARGB(
                                                                      180,
                                                                      0,
                                                                      0,
                                                                      0,
                                                                    ),
                                                                fontFamily:
                                                                    "Roboto",
                                                                fontSize: 10.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // SizedBox(
                                          //   width: ScreenDetails.percentage(percent: 2, quantityToScale: "width"),
                                          // ),
                                          Expanded(
                                            child: Container(
                                              // padding:EdgeInsets.only(right: 10.h),
                                              // color: Colors.blue,
                                              // width: 60.w,
                                              padding: EdgeInsets.only(
                                                top: 5.h,
                                                right: 10.h,
                                              ),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      favorite = !favorite;
                                                    });
                                                  },
                                                  child: favorite
                                                      ? Icon(
                                                          Icons.favorite,
                                                          color: const Color(
                                                            0xFF00EFD1,
                                                          ),
                                                          size: 25.h,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .favorite_border_outlined,
                                                          color: const Color(
                                                            0xFF00EFD1,
                                                          ),
                                                          size: 25.h,
                                                        ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
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
    );
  }
}
