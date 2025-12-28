import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:on_campus/firebase/firestore_db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:on_campus/classes/classes.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/screens/booking/book_modal.dart';
import 'package:on_campus/screens/enquire.dart';
import 'package:on_campus/screens/get_icon.dart';

class HostelDetails extends StatefulWidget {
  final Hostels hostel;
  const HostelDetails({super.key, required this.hostel});

  @override
  State<HostelDetails> createState() => _HostelDetailsState();
}

class _HostelDetailsState extends State<HostelDetails> {
  int selectedIndex = 0;
  List<RoomTypes> roomTypes = [];
  bool isLoading = false;
  bool isChecked = false;
  User? user = FirebaseAuth.instance.currentUser;

  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {};
  final _formkey = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();

  Future<void> getRoomTypes() async {
    setState(() {
      isLoading = true;
    });
    roomTypes = await FirestoreDb.instance.roomTypes(widget.hostel);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getRoomTypes().then((_) {
      for (var room in roomTypes) {
        _sectionKeys[room.type ?? "null"] = GlobalKey();
      }
      for (final tile in tileList) {
        _sectionKeys[tile.name ?? "null"] = GlobalKey();
      }
    });
    // occupantFields(1);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String? sectionString) {
    final context = _sectionKeys[sectionString]?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.1,
      );
    }
  }

  List<Photos> tileList = [
    Photos(name: "Overview"),
    Photos(name: "Description"),
    Photos(name: "Amenities"),
    Photos(name: "Room type"),
    Photos(name: "Policies"),
    Photos(name: "Faqs"),
  ];
  List<Swipper> swipers = [
    Swipper(image: "assets/search/search_imgs.jpeg"),
    Swipper(image: "assets/search/search_imgs_1.jpeg"),
    Swipper(image: "assets/search/search_imgs_2.jpeg"),
    Swipper(image: "assets/search/search_imgs_3.jpeg"),
    Swipper(image: "assets/search/search_imgs_4.jpeg"),
  ];

  int duration = 1;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 400.h,
                            width: MediaQuery.of(context).size.width,
                            color: const Color(0xFFF5F8FF),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: Swiper(
                                controller: SwiperController(),
                                autoplay: true,
                                curve: Curves.easeIn,
                                autoplayDelay: 5000,
                                itemCount: widget.hostel.hostel_images!.length,
                                itemBuilder: (BuildContext, index) {
                                  // Swipper swiper = swipers[index];
                                  String? string =
                                      widget.hostel.hostel_images![index];
                                  return CachedNetworkImage(
                                    imageUrl: string ?? "",
                                    width: MediaQuery.sizeOf(context).width,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        SpinKitThreeBounce(
                                          color: const Color.fromARGB(
                                            255,
                                            0,
                                            239,
                                            209,
                                          ),
                                          size: 50.0,
                                        ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 400.h,
                            child: Column(
                              children: [
                                SizedBox(height: 16.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 20.h),
                                        height: 40.h,
                                        width: 40,
                                        foregroundDecoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.chevron_left,
                                          color: Colors.black,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 20.h),
                                      foregroundDecoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      height: 40.h,
                                      width: 40.w,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            right: 0,
                                            bottom: 0,
                                            child: Container(
                                              child: const Icon(
                                                Icons.favorite,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            right: 0,
                                            bottom: 0,
                                            child: Container(
                                              child: const Icon(
                                                Icons.favorite_border,
                                                color: Color(0xFF00EFD1),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  // height: 160.h,
                                  margin: EdgeInsets.symmetric(
                                    vertical: 5.h,
                                    horizontal: 15.h,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 50.h,
                                          left: 10.h,
                                        ),
                                        // color: Colors.red,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.hostel.name,
                                              style: TextStyle(
                                                fontFamily: "Poppins",
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 24.sp.clamp(0, 24),
                                                letterSpacing: 0.1.w,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 2.w,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 5.h),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                          left: 2.h,
                                                        ),
                                                        child: Image.asset(
                                                          "assets/hostels_detail/location_white.png",
                                                          height: 15.h,
                                                          width: 15.w.clamp(
                                                            0,
                                                            15,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "${widget.hostel.city}, ${widget.hostel.region} Region",
                                                        style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                          fontSize: 12.sp.clamp(
                                                            0,
                                                            12,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .directions_walk_sharp,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        // " 1 hour 08 min",
                                                        "${widget.hostel.distance_walk} mins",
                                                        style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                          fontSize: 12.sp.clamp(
                                                            0,
                                                            12,
                                                          ),
                                                        ),
                                                      ),
                                                      5.horizontalSpace,
                                                      Image.asset(
                                                        "assets/hostels_detail/Steering Wheel.png",
                                                        width: 15.w,
                                                        height: 15.h,
                                                      ),
                                                      Text(
                                                        " ${widget.hostel.distance_car} mins",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 11.sp.clamp(
                                                            0,
                                                            11,
                                                          ),
                                                        ),
                                                      ),
                                                      5.horizontalSpace,
                                                      Image.asset(
                                                        "assets/hostels_detail/Bus_white.png",
                                                        height: 15.h,
                                                        width: 15.w,
                                                      ),
                                                      Text(
                                                        " ${widget.hostel.distance_car} mins",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 11.sp.clamp(
                                                            0,
                                                            11,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 130.h,
                                        // color: Colors.blue,
                                        margin: EdgeInsets.only(
                                          right: 10.h,
                                          top: 15.h,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                child: Image.asset(
                                                  'assets/hostels_detail/hostel-2.png',
                                                  height: 35.h,
                                                  width: 40.w.clamp(0, 40),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            // SizedBox(height: 10.h),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                child: Image.asset(
                                                  'assets/hostels_detail/hostel-2.png',
                                                  height: 35.h,
                                                  width: 40.w.clamp(0, 40),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            // SizedBox(height: 10.h),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2.w,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                child: Image.asset(
                                                  'assets/hostels_detail/hostel-2.png',
                                                  height: 35.h,
                                                  width: 40.w.clamp(0, 40),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: const Color(0xFFF5F8FF),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: SizedBox(
                                height: 70.h,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          5,
                                        ).r,
                                      ),
                                      child: OutlinedButton(
                                        onPressed: () {},
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.black87,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10.r,
                                            ),
                                          ),
                                          side: BorderSide(
                                            width: 1.w,
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/hostels_detail/photos.png",
                                              height: 15.h,
                                              width: 15.w,
                                            ),
                                            Text(
                                              " Photos",
                                              style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13.sp.clamp(0, 13),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          5,
                                        ).r,
                                      ),
                                      child: OutlinedButton(
                                        onPressed: () {},
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.black87,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10.r,
                                            ),
                                          ),
                                          side: const BorderSide(
                                            width: 1,
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/hostels_detail/videocam.png",
                                              height: 24.h,
                                              width: 24.w,
                                            ),
                                            Text(
                                              " Videos",
                                              style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13.sp.clamp(0, 13),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          5,
                                        ).r,
                                      ),
                                      child: OutlinedButton(
                                        onPressed: () {},
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.black87,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10.r,
                                            ),
                                          ),
                                          side: BorderSide(
                                            width: 1.w,
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/hostels_detail/360 View.png",
                                              height: 24.h,
                                              width: 24.w,
                                            ),
                                            Text(
                                              " View",
                                              style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13.sp.clamp(0, 13),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F8FF),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3.r,
                                    blurRadius: 8.r,
                                    // offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              height: 36.h,
                              width: 600.w,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: tileList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Photos tile = tileList[index];
                                  return Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                        _scrollToSection(tile.name);
                                      },
                                      child: AnimatedContainer(
                                        height: 36.h,
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          // color: Colors.blue,
                                          border: selectedIndex == index
                                              ? Border(
                                                  bottom: BorderSide(
                                                    color: const Color(
                                                      0xFF00EFD1,
                                                    ),
                                                    width: 1.5.w,
                                                  ),
                                                )
                                              : null,
                                        ),
                                        child: Container(
                                          child: Text(
                                            tile.name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: selectedIndex == index
                                                  ? null
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Container(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 20.w,
                                  right: 20.w,
                                  top: 5.h,
                                  bottom: 10.h,
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      key: _sectionKeys['Description'],
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Description",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20.sp.clamp(0, 20),
                                          letterSpacing: 0.15.w,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Welcome to resort paradise we ensure the best service during your stay in bali with an emphasis on customer comfort. Enjoy Balinese specialties, dance and music every saturday for free at competitve prices you can...",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: const Color(0xFF787878),
                                        fontSize: 12.sp.clamp(0, 12),
                                      ),
                                    ),
                                    const Divider(
                                      color: Color.fromRGBO(120, 120, 120, 0.7),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Read More",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          letterSpacing: 0.15.w,
                                          color: const Color(0xFF00EFD1),
                                          fontSize: 15.sp.clamp(0, 15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Container(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30.w,
                                  vertical: 10.h,
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      key: _sectionKeys["Amenities"],
                                      child: Text(
                                        "Amenities",
                                        style: TextStyle(
                                          fontSize: 20.sp.clamp(0, 20),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    // Row()
                                    SingleChildScrollView(
                                      child: GridView.count(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 1,
                                        childAspectRatio: 4.0,
                                        children: [
                                          ...List.generate(3, (index) {
                                            return Row(
                                              children: [
                                                GetIcon(
                                                  text:
                                                      widget
                                                          .hostel
                                                          .amenities![index] ??
                                                      "noicon",
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  widget
                                                          .hostel
                                                          .amenities![index] ??
                                                      "",
                                                ),
                                              ],
                                            );
                                          }),
                                          GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Container(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                          context,
                                                        ).viewInsets.bottom,
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Container(
                                                            height: 4,
                                                            width: 30,
                                                            margin:
                                                                EdgeInsets.symmetric(
                                                                  vertical: 15,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  const Color.fromARGB(
                                                                    255,
                                                                    75,
                                                                    74,
                                                                    74,
                                                                  ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    2,
                                                                  ),
                                                            ),
                                                          ),
                                                          Text(
                                                            "Amenities",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  vertical: 8.0,
                                                                  horizontal:
                                                                      30,
                                                                ),
                                                            child: Divider(
                                                              height: 10,
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        30.0,
                                                                    vertical:
                                                                        10,
                                                                  ),
                                                              child: GridView.count(
                                                                crossAxisCount:
                                                                    2,
                                                                mainAxisSpacing:
                                                                    1,
                                                                physics:
                                                                    NeverScrollableScrollPhysics(),
                                                                shrinkWrap:
                                                                    true,
                                                                childAspectRatio:
                                                                    4.0,
                                                                children: List.generate(
                                                                  widget
                                                                      .hostel
                                                                      .amenities!
                                                                      .length,
                                                                  (index) {
                                                                    return Row(
                                                                      children: [
                                                                        getIcon(
                                                                          text:
                                                                              widget.hostel.amenities![index] ??
                                                                              "noicon",
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          widget.hostel.amenities![index] ??
                                                                              "",
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/user_interface_icons/Hostel_detail_screens/ic_add.svg',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                                SizedBox(width: 5),
                                                Text("More"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Bills & Utilities",
                                        style: TextStyle(
                                          letterSpacing: 0.15.w,
                                          fontSize: 16.sp.clamp(0, 16),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 10.h),
                                    SingleChildScrollView(
                                      child: GridView.count(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 1,
                                        childAspectRatio: 4.0,
                                        // padding: EdgeInsets.zero,
                                        children: [
                                          ...List.generate(3, (index) {
                                            return Row(
                                              children: [
                                                GetIcon(
                                                  text:
                                                      widget
                                                          .hostel
                                                          .bills_utilities![index] ??
                                                      "noicon",
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  widget
                                                          .hostel
                                                          .bills_utilities![index] ??
                                                      "",
                                                ),
                                              ],
                                            );
                                          }),
                                          GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Container(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                          context,
                                                        ).viewInsets.bottom,
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Container(
                                                            height: 4,
                                                            width: 30,
                                                            margin:
                                                                EdgeInsets.symmetric(
                                                                  vertical: 15,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  const Color.fromARGB(
                                                                    255,
                                                                    75,
                                                                    74,
                                                                    74,
                                                                  ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    2,
                                                                  ),
                                                            ),
                                                          ),
                                                          Text(
                                                            "Bills & Utilities",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  vertical: 8.0,
                                                                  horizontal:
                                                                      30,
                                                                ),
                                                            child: Divider(
                                                              height: 10,
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        30.0,
                                                                    vertical:
                                                                        10,
                                                                  ),
                                                              child: GridView.count(
                                                                crossAxisCount:
                                                                    2,
                                                                mainAxisSpacing:
                                                                    1,
                                                                physics:
                                                                    NeverScrollableScrollPhysics(),
                                                                shrinkWrap:
                                                                    true,
                                                                childAspectRatio:
                                                                    4.0,
                                                                children: List.generate(
                                                                  widget
                                                                      .hostel
                                                                      .bills_utilities!
                                                                      .length,
                                                                  (index) {
                                                                    return Row(
                                                                      children: [
                                                                        getIcon(
                                                                          text:
                                                                              widget.hostel.bills_utilities![index] ??
                                                                              "noicon",
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          widget.hostel.bills_utilities![index] ??
                                                                              "",
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/user_interface_icons/Hostel_detail_screens/ic_add.svg',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                                SizedBox(width: 5),
                                                Text("More"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 10.h),

                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Security & Safety",
                                        style: TextStyle(
                                          fontSize: 16.sp.clamp(0, 16),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    SingleChildScrollView(
                                      child: GridView.count(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 1,
                                        childAspectRatio: 4.0,
                                        // padding: EdgeInsets.zero,
                                        children: [
                                          ...List.generate(3, (index) {
                                            return Row(
                                              children: [
                                                GetIcon(
                                                  text:
                                                      widget
                                                          .hostel
                                                          .security_safety![index] ??
                                                      "noicon",
                                                ),
                                                SizedBox(width: 5),
                                                Expanded(
                                                  child: Text(
                                                    widget
                                                            .hostel
                                                            .security_safety![index] ??
                                                        "",
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                          GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Container(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                          context,
                                                        ).viewInsets.bottom,
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Container(
                                                            height: 4,
                                                            width: 30,
                                                            margin:
                                                                EdgeInsets.symmetric(
                                                                  vertical: 15,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  const Color.fromARGB(
                                                                    255,
                                                                    75,
                                                                    74,
                                                                    74,
                                                                  ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    2,
                                                                  ),
                                                            ),
                                                          ),
                                                          Text(
                                                            "Security & Safety",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  vertical: 8.0,
                                                                  horizontal:
                                                                      30,
                                                                ),
                                                            child: Divider(
                                                              height: 10,
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        30.0,
                                                                    vertical:
                                                                        10,
                                                                  ),
                                                              child: GridView.count(
                                                                crossAxisCount:
                                                                    2,
                                                                mainAxisSpacing:
                                                                    1,
                                                                physics:
                                                                    NeverScrollableScrollPhysics(),
                                                                shrinkWrap:
                                                                    true,
                                                                childAspectRatio:
                                                                    4.0,
                                                                children: List.generate(
                                                                  widget
                                                                      .hostel
                                                                      .security_safety!
                                                                      .length,
                                                                  (index) {
                                                                    return Row(
                                                                      children: [
                                                                        getIcon(
                                                                          text:
                                                                              widget.hostel.security_safety![index] ??
                                                                              "noicon",
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Expanded(
                                                                          child: Text(
                                                                            widget.hostel.security_safety![index] ??
                                                                                "",
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/user_interface_icons/Hostel_detail_screens/ic_add.svg',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                                SizedBox(width: 5),
                                                Text("More"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 10.h),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Container(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.only(left: 30.w, top: 20.h),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  key: _sectionKeys['Room type'],
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Room Types(${roomTypes.length})",
                                        style: TextStyle(
                                          fontSize: 20.sp.clamp(0, 20),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        physics: BouncingScrollPhysics(),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 4,
                                                    vertical: 8,
                                                  ),
                                              child: Container(
                                                height: 30,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                        elevation: 0,
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal: 15,
                                                              vertical: 4,
                                                            ),
                                                        foregroundColor:
                                                            Colors.white,
                                                        backgroundColor: Color(
                                                          0xFF00EFD1,
                                                        ),
                                                      ),
                                                  onPressed: () {
                                                    _scrollToSection(
                                                      "Room type",
                                                    );
                                                  },
                                                  child: Text("All"),
                                                ),
                                              ),
                                            ),
                                            ...List.generate(roomTypes.length, (
                                              index,
                                            ) {
                                              bool isRoomAvailable = true;
                                              RoomTypes rooms =
                                                  roomTypes[index];
                                              if (rooms.availableRooms ==
                                                      null ||
                                                  rooms.availableRooms == 0) {
                                                setState(() {
                                                  isRoomAvailable = false;
                                                });
                                              }
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 8,
                                                    ),
                                                child: Container(
                                                  height: 30,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      elevation: 0,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 15,
                                                            vertical: 4,
                                                          ),
                                                      foregroundColor:
                                                          Colors.black,
                                                      backgroundColor:
                                                          Color.fromARGB(
                                                            255,
                                                            223,
                                                            224,
                                                            224,
                                                          ).withOpacity(0.4),
                                                    ),
                                                    onPressed: () {
                                                      _scrollToSection(
                                                        rooms.type,
                                                      );
                                                    },
                                                    child: Text(
                                                      "${rooms.type} Room",
                                                    ),
                                                  ),
                                                ),
                                              );
                                              ;
                                            }),
                                          ],
                                        ),
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            isLoading
                                ? CircularProgressIndicator()
                                : SingleChildScrollView(
                                    controller: _scrollController,
                                    child: Column(
                                      children: List.generate(roomTypes.length, (
                                        index,
                                      ) {
                                        bool isRoomAvailable = true;
                                        RoomTypes room = roomTypes[index];
                                        if (room.availableRooms == null ||
                                            room.availableRooms == 0) {
                                          setState(() {
                                            isRoomAvailable = false;
                                          });
                                        }
                                        return Column(
                                          children: [
                                            Container(
                                              key: _sectionKeys[room.type],
                                              color: Colors.white,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 30.w,
                                                  vertical: 20.h,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                5,
                                                              ).r,
                                                          child: Image.asset(
                                                            "assets/hostels_detail/roomTypeImage.png",
                                                            height: 70.h,
                                                            width: 90.w.clamp(
                                                              0,
                                                              90,
                                                            ),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "${room.type} Room Bedroom Apartment",
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                  fontSize: 16
                                                                      .sp
                                                                      .clamp(
                                                                        0,
                                                                        16,
                                                                      ),
                                                                  // letterSpacing: 0.2.w,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        "From ",
                                                                        style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "GHS${room.price}/",
                                                                        style: TextStyle(
                                                                          fontSize: 16.sp.clamp(
                                                                            0,
                                                                            16,
                                                                          ),
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    "year",
                                                                    style: TextStyle(
                                                                      fontSize: 12
                                                                          .sp
                                                                          .clamp(
                                                                            0,
                                                                            12,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Available Rooms:",
                                                                    style: TextStyle(
                                                                      fontSize: 12
                                                                          .sp
                                                                          .clamp(
                                                                            0,
                                                                            12,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10.w,
                                                                  ),
                                                                  isRoomAvailable
                                                                      ? Text(
                                                                          "${room.availableRooms}",
                                                                          style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: const Color(
                                                                              0xFF23A26D,
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          decoration: BoxDecoration(
                                                                            color:
                                                                                const Color(
                                                                                  0xFF23A26D,
                                                                                ).withOpacity(
                                                                                  0.1,
                                                                                ),
                                                                            borderRadius: BorderRadius.circular(
                                                                              15.r,
                                                                            ),
                                                                          ),
                                                                          width:
                                                                              55.w,
                                                                          height:
                                                                              25.h,
                                                                          child: Center(
                                                                            child: Text(
                                                                              "Sold out",
                                                                              style: TextStyle(
                                                                                fontSize: 10.sp.clamp(
                                                                                  0,
                                                                                  10,
                                                                                ),
                                                                                fontWeight: FontWeight.w500,
                                                                                color: const Color(
                                                                                  0xFF00EFD1,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        // Image.asset("assets/hostels_detail/bed.jpeg"),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10.h),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                context,
                                                              ).width *
                                                              0.4,
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                "assets/hostels_detail/home.png",
                                                                height: 24.h,
                                                                width: 24.w,
                                                              ),
                                                              Container(
                                                                margin:
                                                                    EdgeInsets.only(
                                                                      top: 5.h,
                                                                    ),
                                                                child: Text(
                                                                  " Bedroom 1",
                                                                  style: TextStyle(
                                                                    fontFamily:
                                                                        "Work Sans",
                                                                    fontSize: 14
                                                                        .sp
                                                                        .clamp(
                                                                          0,
                                                                          14,
                                                                        ),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: const Color(
                                                                      0xFF323232,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Image.asset(
                                                              "assets/hostels_detail/bathtub.png",
                                                              height: 24.h,
                                                              width: 24.w,
                                                            ),
                                                            Container(
                                                              margin:
                                                                  EdgeInsets.only(
                                                                    top: 5.h,
                                                                  ),
                                                              child: Text(
                                                                " Bathroom 1",
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      "Work Sans",
                                                                  fontSize: 14
                                                                      .sp
                                                                      .clamp(
                                                                        0,
                                                                        14,
                                                                      ),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: const Color(
                                                                    0xFF323232,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 20.h),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                context,
                                                              ).width *
                                                              0.4,
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                "assets/hostels_detail/bed.png",
                                                                height: 24.h,
                                                                width: 24.w,
                                                              ),
                                                              Text(
                                                                " 2 Beds",
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      "Work Sans",
                                                                  color: const Color(
                                                                    0xFF323232,
                                                                  ),
                                                                  fontSize: 14
                                                                      .sp
                                                                      .clamp(
                                                                        0,
                                                                        14,
                                                                      ),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Image.asset(
                                                              "assets/hostels_detail/home.png",
                                                              height: 24.h,
                                                              width: 24.w,
                                                            ),
                                                            Container(
                                                              margin:
                                                                  EdgeInsets.only(
                                                                    top: 5.h,
                                                                  ),
                                                              child: Text(
                                                                " Private Bedroom",
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      "Work Sans",
                                                                  fontSize: 14
                                                                      .sp
                                                                      .clamp(
                                                                        0,
                                                                        14,
                                                                      ),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 20.h),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                context,
                                                              ).width *
                                                              0.3,
                                                          child: Container(
                                                            height: 40.h,
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    10.r,
                                                                  ),
                                                              border: Border.all(
                                                                width: 1,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            child: const Center(
                                                              child: Text(
                                                                "View more details",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 40.h),
                                                        Row(
                                                          children: [
                                                            Image.asset(
                                                              "assets/hostels_detail/kitchen.png",
                                                              height: 24.h,
                                                              width: 24.w,
                                                            ),
                                                            Text(
                                                              " Private Kitchen",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Work Sans",
                                                                fontSize: 14.sp
                                                                    .clamp(
                                                                      0,
                                                                      14,
                                                                    ),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 20.h),
                                                    Divider(
                                                      color:
                                                          const Color.fromRGBO(
                                                            120,
                                                            120,
                                                            120,
                                                            0.7,
                                                          ),
                                                      height: .2.h,
                                                    ),
                                                    SizedBox(height: 20.h),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  MediaQuery.sizeOf(
                                                                    context,
                                                                  ).width *
                                                                  0.4,
                                                              child: Text(
                                                                "Academic Year",
                                                                style: TextStyle(
                                                                  fontSize: 15
                                                                      .sp
                                                                      .clamp(
                                                                        0,
                                                                        15,
                                                                      ),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                "Price Estimate",
                                                                style: TextStyle(
                                                                  fontSize: 12
                                                                      .sp
                                                                      .clamp(
                                                                        0,
                                                                        12,
                                                                      ),
                                                                  letterSpacing:
                                                                      0.2.w,
                                                                  color: const Color(
                                                                    0xFF787878,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "GHS${room.price}/",
                                                                  style: TextStyle(
                                                                    fontSize: 18
                                                                        .sp
                                                                        .clamp(
                                                                          0,
                                                                          16,
                                                                        ),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "year",
                                                                  style: TextStyle(
                                                                    fontSize: 12
                                                                        .sp
                                                                        .clamp(
                                                                          0,
                                                                          12,
                                                                        ),
                                                                    color: const Color(
                                                                      0xFF787878,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Move in: 08 Aug 2024",
                                                              style: TextStyle(
                                                                fontSize: 13.sp
                                                                    .clamp(
                                                                      0,
                                                                      13,
                                                                    ),
                                                                color:
                                                                    const Color(
                                                                      0xFF323232,
                                                                    ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            SizedBox(
                                                              child: Center(
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: SizedBox(
                                                                    // height:
                                                                    // 35.h,
                                                                    child: ElevatedButton(
                                                                      onPressed: () {
                                                                        try {
                                                                          TextEditingController
                                                                          num_people =
                                                                              TextEditingController();
                                                                          TextEditingController
                                                                          name =
                                                                              TextEditingController();
                                                                          TextEditingController
                                                                          phone_num =
                                                                              TextEditingController();
                                                                          TextEditingController
                                                                          email_address =
                                                                              TextEditingController();
                                                                          List<
                                                                            TextEditingController
                                                                          >
                                                                          occupantNames = [
                                                                            TextEditingController(),
                                                                          ];
                                                                          List<
                                                                            TextEditingController
                                                                          >
                                                                          occupantPhones = [
                                                                            TextEditingController(),
                                                                          ];
                                                                          List<
                                                                            TextEditingController
                                                                          >
                                                                          occupantEmails = [
                                                                            TextEditingController(),
                                                                          ];

                                                                          if (user !=
                                                                              null) {
                                                                            Get.snackbar(
                                                                              'Success',
                                                                              'Task saved!',
                                                                            );
                                                                            showModalBottomSheet(
                                                                              context: context,
                                                                              isScrollControlled: true,
                                                                              builder:
                                                                                  (
                                                                                    _,
                                                                                  ) => Padding(
                                                                                    padding: EdgeInsets.only(
                                                                                      bottom: MediaQuery.of(
                                                                                        context,
                                                                                      ).viewInsets.bottom,
                                                                                    ),
                                                                                    child: IntrinsicHeight(
                                                                                      child: BookModal(
                                                                                        hostel: widget.hostel,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                            );
                                                                          } else {
                                                                            Get.snackbar(
                                                                              'Error',
                                                                              'Please sign in to continue.',
                                                                            );
                                                                          }
                                                                        } catch (
                                                                          e
                                                                        ) {
                                                                          print(
                                                                            e.toString(),
                                                                          );
                                                                          Get.snackbar(
                                                                            "error",
                                                                            "${e.toString()}",
                                                                          );
                                                                        }
                                                                      },
                                                                      style: ElevatedButton.styleFrom(
                                                                        elevation:
                                                                            0,
                                                                        shape: ContinuousRectangleBorder(
                                                                          side:
                                                                              BorderSide.none,
                                                                          borderRadius: BorderRadius.circular(
                                                                            30.r,
                                                                          ),
                                                                        ),
                                                                        backgroundColor: const Color.fromARGB(
                                                                          255,
                                                                          33,
                                                                          243,
                                                                          201,
                                                                        ),
                                                                      ),
                                                                      child: Center(
                                                                        child: Text(
                                                                          "Book now",
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontSize: 14.sp.clamp(
                                                                              0,
                                                                              14,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 20.h),
                                          ],
                                        );
                                      }),
                                    ),
                                  ),
                            SizedBox(height: 10.h),
                            Container(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(20.r),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      key: _sectionKeys['Policies'],
                                      child: Text(
                                        "Cancellation Policies",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20.sp.clamp(0, 20),
                                          letterSpacing: 0.2.w,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Cooling off period",
                                          style: TextStyle(
                                            fontSize: 15.sp.clamp(0, 15),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                              fontSize: 15.sp.clamp(0, 15),
                                              color: const Color(0xFF00EFD1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Container(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(20.r),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Payment Details",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20.sp.clamp(0, 20),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Booking deposit",
                                          style: TextStyle(
                                            fontSize: 15.sp.clamp(0, 15),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                              fontSize: 15.sp.clamp(0, 15),
                                              color: const Color(0xFF00EFD1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Divider(height: .2.h),
                                    SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Payment Iinstallment plan",
                                          style: TextStyle(
                                            fontSize: 15.sp.clamp(0, 15),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                              fontSize: 15.sp.clamp(0, 15),
                                              color: const Color(0xFF00EFD1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Divider(height: .2.h),
                                    SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Mode of payment",
                                          style: TextStyle(
                                            fontSize: 15.sp.clamp(0, 15),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                              fontSize: 15.sp.clamp(0, 15),
                                              color: const Color(0xFF00EFD1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Divider(height: .2.h),
                                    SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Guarantor requirement",
                                          style: TextStyle(
                                            fontSize: 15.sp.clamp(0, 15),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                              fontSize: 15.sp.clamp(0, 15),
                                              color: const Color(0xFF00EFD1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Container(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(20.r),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Location",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20.sp.clamp(0, 20),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.0.w,
                                      ),
                                      child: SizedBox(
                                        width: MediaQuery.sizeOf(
                                          context,
                                        ).width.w,
                                        height: 400.h,
                                        // color: Colors.red,
                                        child: Image.asset(
                                          "assets/hostels_detail/screenshot.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Container(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(20.r),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      key: _sectionKeys["Faqs"],
                                      child: Text(
                                        "Frequently Asked Questions (FAQs)",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20.sp.clamp(0, 20),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Can i bring a TV?",
                                          style: TextStyle(
                                            fontSize: 15.sp.clamp(0, 15),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                              fontSize: 15.sp.clamp(0, 15),
                                              color: const Color(0xFF00EFD1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Divider(height: .2.h),
                                    SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Can i make a group booking?",
                                          style: TextStyle(
                                            fontSize: 15.sp.clamp(0, 15),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                              fontSize: 15.sp.clamp(0, 15),
                                              color: const Color(0xFF00EFD1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Divider(height: .2.h),
                                    SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Can i have friends stay over?",
                                          style: TextStyle(
                                            fontSize: 15.sp.clamp(0, 15),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                              fontSize: 15.sp.clamp(0, 15),
                                              color: const Color(0xFF00EFD1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Divider(height: .2.h),
                                    SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Do i have a cleaner?",
                                          style: TextStyle(
                                            fontSize: 15.sp.clamp(0, 15),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                              fontSize: 15.sp.clamp(0, 15),
                                              color: const Color(0xFF00EFD1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Divider(height: .2.h),
                                    SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Is beddings and linens provided?",
                                          style: TextStyle(
                                            fontSize: 15.sp.clamp(0, 15),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                              fontSize: 15.sp.clamp(0, 15),
                                              color: const Color(0xFF00EFD1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Divider(height: .2.h),
                                    SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "What are our rents covered?",
                                          style: TextStyle(
                                            fontSize: 15.sp.clamp(0, 15),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                              fontSize: 15.sp.clamp(0, 15),
                                              color: const Color(0xFF00EFD1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Divider(height: .2.h),
                                    SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Do i need a guarantor?",
                                          style: TextStyle(
                                            fontSize: 15.sp.clamp(0, 15),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                              fontSize: 15.sp.clamp(0, 15),
                                              color: const Color(0xFF00EFD1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 45.h),
                                  ],
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
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3.r,
                        blurRadius: 12.r,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      bottom: 15,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 150.w,
                          height: 40,
                          child: OutlinedButton(
                            onPressed: () async {
                              // await FirestoreDb.instance.createVariables();
                              _scrollToSection("Room type");
                            },
                            child: Text(
                              "View Rooms",
                              style: TextStyle(color: Color(0xFF00EFD1)),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Color(
                                0xFF00EFD1,
                              ).withOpacity(0.1),
                              side: BorderSide(
                                color: Color(0xFF00EFD1).withOpacity(0.5),
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150.w,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () async {
                              Get.to(
                                () => Enquire(hostel: widget.hostel),
                                transition: Transition.fadeIn,
                                duration: const Duration(milliseconds: 800),
                                curve: Curves.easeIn,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                side: BorderSide.none,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              backgroundColor: const Color(0xFF00EFD1),
                            ),
                            child: Center(
                              child: Text(
                                "Enquire now",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp.clamp(0, 14),
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
      ),
    );
  }
}

Widget customTextField({
  required TextEditingController controller,
  required String labelText,
}) {
  return TextField(
    //   onChanged: (){},
    //   focusNode:,
    controller: controller,
    obscureText: false,
    enableSuggestions: true,
    autocorrect: false,
    cursorColor: Colors.white,
    style: const TextStyle(color: Colors.grey),
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      filled: true,
      fillColor: Colors.white,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          width: 1,
          style: BorderStyle.none,
          color: Colors.grey.withOpacity(0.3),
        ),
      ),
    ),
    keyboardType: TextInputType.visiblePassword,
  );
}
