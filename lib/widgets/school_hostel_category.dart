// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:on_campus/classes/screen_details.dart';
// import 'package:on_campus/firebase/classes.dart';
// import 'package:on_campus/firebase/firestore_db.dart';
// import 'package:on_campus/screens/hostels_detail.dart';
// import 'package:on_campus/widgets/home_page_widgets.dart';

// class SchoolHostelCategory extends StatefulWidget {
//   const SchoolHostelCategory({super.key});

//   @override
//   State<SchoolHostelCategory> createState() => _SchoolHostelCategoryState();
// }

// class _SchoolHostelCategoryState extends State<SchoolHostelCategory> {
//   bool favorite = false;
//   bool isLoading = true;

//   List<Hostels> allSchoolHostels = [];
//   List<Hostels> searchList = [];

//   Future<void> getSchoolHostels() async {
//     setState(() {
//       isLoading = true;
//     });
//     List<Hostels> awaitSchoolHostels = await FirestoreDb.instance
//         .getSchoolHostels();
//     awaitSchoolHostels.shuffle();
//     if (awaitSchoolHostels.isNotEmpty) {
//       setState(() {
//         allSchoolHostels = awaitSchoolHostels;
//         isLoading = false;
//       });
//     }
//   }

//   void search(String value) {
//     searchList = allSchoolHostels
//         .where((item) => item.name.toLowerCase().contains(value.toLowerCase()))
//         .toList();

//     setState(() {});
//   }

//   TextEditingController searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     getSchoolHostels();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           child: Container(
//             margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   width: ScreenDetails.ScreenWidth,
//                   child: Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: Container(
//                           height: 30.h,
//                           width: 35.w,
//                           foregroundDecoration: BoxDecoration(
//                             color: Colors.black.withOpacity(0.03),
//                             borderRadius: BorderRadius.circular(8.r),
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(8.r),
//                           ),
//                           child: Icon(
//                             Icons.chevron_left,
//                             color: Colors.black,
//                             size: 24.w,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 60.w),
//                       SizedBox(
//                         height: 24.h,
//                         child: Text(
//                           "School Hostels",
//                           style: TextStyle(
//                             fontFamily: "Poppins-Bold",
//                             fontSize: 22.sp,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20.h),
//                 SizedBox(
//                   height: 50.h,
//                   child: TextField(
//                     onChanged: (value) {
//                       search(value);
//                     },
//                     obscureText: false,
//                     enableSuggestions: true,
//                     autocorrect: true,
//                     cursorColor: Colors.black,
//                     controller: searchController,
//                     decoration: InputDecoration(
//                       hintText: "Search by hostel's name or location",
//                       hintStyle: TextStyle(
//                         fontFamily: "Inter",
//                         fontWeight: FontWeight.bold,
//                         color: const Color(0xFFBBBBBB),
//                         fontSize: 15.sp,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16.r),
//                         borderSide: const BorderSide(color: Color(0xFFBBBBBB)),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16.r),
//                         borderSide: const BorderSide(color: Color(0xFFB7B7B7)),
//                       ),
//                       prefixIcon: SizedBox(
//                         // color: Colors.red,
//                         width: 70.w,
//                         height: 40.h,
//                         child: Stack(
//                           children: [
//                             Positioned(
//                               bottom: 7.h,
//                               left: 20.h,
//                               child: Icon(
//                                 Icons.search,
//                                 color: Colors.black.withOpacity(0.1),
//                                 size: 20.h,
//                               ),
//                             ),
//                             Positioned(
//                               bottom: 10.h,
//                               left: 20.h,
//                               child: Icon(
//                                 Icons.search,
//                                 color: const Color(0xFFB7B7B7),
//                                 size: 20.h,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 (isLoading)
//                     ? Container(
//                         child: Center(
//                           child: Center(
//                             child: SpinKitThreeBounce(
//                               color: const Color.fromARGB(255, 0, 239, 209),
//                               size: 50.0,
//                             ),
//                           ),
//                         ),
//                       )
//                     : (searchController.text.isEmpty)
//                     ? Container(
//                         decoration: BoxDecoration(),
//                         height: 620,
//                         child: ListView.builder(
//                           physics: const BouncingScrollPhysics(),
//                           scrollDirection: Axis.vertical,
//                           itemCount: allSchoolHostels.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             Hostels hostel = allSchoolHostels[index];

//                             return hostelCardVariant(
//                               hostel: allSchoolHostels[index],
//                               favorite: true,
//                               variant : true,
//                               triggerRebuild: () {
//                                 setState(() {

//                                 });
//                               },
//                             );
//                             // GestureDetector(
//                             //   onTap: () {
//                             //     try {
//                             //       Get.to(
//                             //         () => HostelDetails(hostel: hostel),
//                             //         transition: Transition.fadeIn,
//                             //         duration: const Duration(milliseconds: 800),
//                             //         curve: Curves.easeIn,
//                             //       );
//                             //     } catch (e) {
//                             //       Get.snackbar(
//                             //         "Error",
//                             //         "An unknown error occurred. Please try again later. \n ${e.toString()}\n ${e.toString()}",
//                             //         snackPosition: SnackPosition.BOTTOM,
//                             //       );
//                             //     }
//                             //   },
//                             //   child: Padding(
//                             //     padding: const EdgeInsets.symmetric(
//                             //       horizontal: 2.0,
//                             //     ),
//                             //     child: Column(
//                             //       children: [
//                             //         Container(
//                             //           // width: double.infinity,
//                             //           height: 110,
//                             //           padding: EdgeInsets.symmetric(
//                             //             horizontal: 10,
//                             //             vertical: 5.h,
//                             //           ),
//                             //           decoration: BoxDecoration(
//                             //             color: const Color(0xFFF5F8FF),
//                             //             // color: Colors.red,
//                             //             borderRadius: BorderRadius.circular(
//                             //               12.r,
//                             //             ),
//                             //             boxShadow: [
//                             //               BoxShadow(
//                             //                 offset: const Offset(0, 1),
//                             //                 blurRadius: 3,
//                             //                 spreadRadius: 1,
//                             //                 color: Colors.black.withOpacity(
//                             //                   0.15,
//                             //                 ),
//                             //               ),
//                             //               BoxShadow(
//                             //                 offset: const Offset(0, 1),
//                             //                 blurRadius: 2,
//                             //                 spreadRadius: 0,
//                             //                 color: Colors.black.withOpacity(
//                             //                   0.30,
//                             //                 ),
//                             //               ),
//                             //             ],
//                             //           ),
//                             //           child: Row(
//                             //             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             //             crossAxisAlignment:
//                             //                 CrossAxisAlignment.start,
//                             //             children: [
//                             //               SizedBox(
//                             //                 // color: Colors.red,
//                             //                 height: 80.h,
//                             //                 width: 80.w,
//                             //                 child: Image.asset(
//                             //                   'assets/hostel_category_widget/media.png',
//                             //                 ),
//                             //               ),
//                             //               SizedBox(width: 10.h),
//                             //               Container(
//                             //                 // color: Colors.red,
//                             //                 height: 80.h,
//                             //                 padding: EdgeInsets.only(top: 5.h),
//                             //                 child: Column(
//                             //                   crossAxisAlignment:
//                             //                       CrossAxisAlignment.start,
//                             //                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             //                   children: [
//                             //                     SizedBox(
//                             //                       height: 16.h,
//                             //                       child: FittedBox(
//                             //                         alignment:
//                             //                             Alignment.centerLeft,
//                             //                         child: Text(
//                             //                           hostel.name,
//                             //                           style: TextStyle(
//                             //                             fontFamily: "Roboto",
//                             //                             fontWeight:
//                             //                                 FontWeight.w500,
//                             //                             fontSize: 16.sp,
//                             //                             letterSpacing: 0.15.w,
//                             //                             color: const Color(
//                             //                               0xFF1D1B20,
//                             //                             ),
//                             //                           ),
//                             //                         ),
//                             //                       ),
//                             //                     ),
//                             //                     SizedBox(
//                             //                       height: 12.h,
//                             //                       child: FittedBox(
//                             //                         alignment:
//                             //                             Alignment.centerLeft,
//                             //                         child: Row(
//                             //                           crossAxisAlignment:
//                             //                               CrossAxisAlignment
//                             //                                   .start,
//                             //                           children: [
//                             //                             Image.asset(
//                             //                               "assets/hostel_category_widget/location.png",
//                             //                               height: 12.h,
//                             //                               width: 8.77.w,
//                             //                             ),
//                             //                             Text(
//                             //                               "${hostel.university}, ${hostel.region} region",
//                             //                               style: TextStyle(
//                             //                                 fontFamily:
//                             //                                     "Roboto",
//                             //                                 // fontWeight: FontWeight.w500,
//                             //                                 fontSize: 10.sp,
//                             //                                 // letterSpacing: 0.15.w,
//                             //                                 color: const Color(
//                             //                                   0xFF333333,
//                             //                                 ),
//                             //                               ),
//                             //                             ),
//                             //                           ],
//                             //                         ),
//                             //                       ),
//                             //                     ),
//                             //                     FittedBox(
//                             //                       child: SizedBox(
//                             //                         // color: Colors.red,
//                             //                         height: 20.h,
//                             //                         // width: 120.w,
//                             //                         child: Text(
//                             //                           "Wifi • Kitchen • Security • Parking •\nBalcony • Friendly Environment",
//                             //                           overflow:
//                             //                               TextOverflow.visible,
//                             //                           style: TextStyle(
//                             //                             fontFamily: "Roboto",
//                             //                             // fontWeight: FontWeight.w500,
//                             //                             fontSize: 9.sp,
//                             //                             letterSpacing: 0.25.w,
//                             //                             color: const Color(
//                             //                               0xFF1D1B20,
//                             //                             ),
//                             //                           ),
//                             //                         ),
//                             //                       ),
//                             //                     ),
//                             //                     SizedBox(height: 5.h),
//                             //                     SizedBox(
//                             //                       height: 12.h,
//                             //                       child: FittedBox(
//                             //                         child: Row(
//                             //                           children: [
//                             //                             Text(
//                             //                               "${hostel.rate}",
//                             //                               style: TextStyle(
//                             //                                 fontFamily:
//                             //                                     "Roboto",
//                             //                                 fontWeight:
//                             //                                     FontWeight.w500,
//                             //                                 fontSize: 10.sp,
//                             //                                 color: const Color(
//                             //                                   0xFF333333,
//                             //                                 ),
//                             //                               ),
//                             //                             ),
//                             //                             SizedBox(width: 5.h),
//                             //                             SizedBox(
//                             //                               height: 10,
//                             //                               width: 60,
//                             //                               child: ListView.builder(
//                             //                                 itemCount:
//                             //                                     hostel.rate,
//                             //                                 scrollDirection:
//                             //                                     Axis.horizontal,
//                             //                                 itemBuilder:
//                             //                                     (
//                             //                                       context,
//                             //                                       index,
//                             //                                     ) {
//                             //                                       return Icon(
//                             //                                         Icons.star,
//                             //                                         color: const Color(
//                             //                                           0xFF00EFD1,
//                             //                                         ),
//                             //                                         size: 10.h,
//                             //                                       );
//                             //                                     },
//                             //                               ),
//                             //                             ),
//                             //                             Row(
//                             //                               children: [
//                             //                                 // Image.asset("warning.png", height: 12, width: 10,),
//                             //                                 Transform.flip(
//                             //                                   flipY: true,
//                             //                                   child: Icon(
//                             //                                     Icons.info,
//                             //                                     color:
//                             //                                         Colors.red,
//                             //                                     size: 10.h,
//                             //                                   ),
//                             //                                 ),
//                             //                                 Text(
//                             //                                   hostel.available_rooms !=
//                             //                                           null
//                             //                                       ? "$hostel.available_rooms} Slots available"
//                             //                                       : " No Slots available",
//                             //                                   style: TextStyle(
//                             //                                     color:
//                             //                                         const Color.fromARGB(
//                             //                                           180,
//                             //                                           0,
//                             //                                           0,
//                             //                                           0,
//                             //                                         ),
//                             //                                     fontFamily:
//                             //                                         "Roboto",
//                             //                                     fontSize: 10.sp,
//                             //                                   ),
//                             //                                 ),
//                             //                               ],
//                             //                             ),
//                             //                           ],
//                             //                         ),
//                             //                       ),
//                             //                     ),
//                             //                   ],
//                             //                 ),
//                             //               ),
//                             //               // SizedBox(
//                             //               //   width: ScreenDetails.percentage(percent: 2, quantityToScale: "width"),
//                             //               // ),
//                             //               Expanded(
//                             //                 child: Container(
//                             //                   // padding:EdgeInsets.only(right: 10.h),
//                             //                   // color: Colors.blue,
//                             //                   // width: 60.w,
//                             //                   padding: EdgeInsets.only(
//                             //                     top: 5.h,
//                             //                     right: 10.h,
//                             //                   ),
//                             //                   child: Align(
//                             //                     alignment: Alignment.topRight,
//                             //                     child: GestureDetector(
//                             //                       onTap: () {
//                             //                         setState(() {
//                             //                           favorite = !favorite;
//                             //                         });
//                             //                       },
//                             //                       child: favorite
//                             //                           ? Icon(
//                             //                               Icons.favorite,
//                             //                               color: const Color(
//                             //                                 0xFF00EFD1,
//                             //                               ),
//                             //                               size: 25.h,
//                             //                             )
//                             //                           : Icon(
//                             //                               Icons
//                             //                                   .favorite_border_outlined,
//                             //                               color: const Color(
//                             //                                 0xFF00EFD1,
//                             //                               ),
//                             //                               size: 25.h,
//                             //                             ),
//                             //                     ),
//                             //                   ),
//                             //                 ),
//                             //               ),
//                             //             ],
//                             //           ),
//                             //         ),
//                             //         SizedBox(height: 20),
//                             //       ],
//                             //     ),
//                             //   ),
//                             // );
//                           },
//                         ),
//                       )
//                     : (searchList.isEmpty)
//                     ? Center(
//                         child: Text("Couldnt find... ${searchController.text}"),
//                       )
//                     : Container(
//                         decoration: BoxDecoration(),
//                         height: 620,
//                         child: ListView.builder(
//                           physics: const BouncingScrollPhysics(),
//                           scrollDirection: Axis.vertical,
//                           itemCount: searchList.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             Hostels searchHostel = searchList[index];
//                             //debugPrint(searchHostel.name);
//                             return GestureDetector(
//                               onTap: () {
//                                 Get.to(
//                                   () => HostelDetails(hostel: searchHostel),
//                                   transition: Transition.fadeIn,
//                                   duration: const Duration(milliseconds: 800),
//                                   curve: Curves.easeIn,
//                                 );
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 2.0,
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       // width: double.infinity,
//                                       height: 110,
//                                       padding: EdgeInsets.symmetric(
//                                         horizontal: 10,
//                                         vertical: 5.h,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         color: const Color(0xFFF5F8FF),
//                                         // color: Colors.red,
//                                         borderRadius: BorderRadius.circular(
//                                           12.r,
//                                         ),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             offset: const Offset(0, 1),
//                                             blurRadius: 3,
//                                             spreadRadius: 1,
//                                             color: Colors.black.withOpacity(
//                                               0.15,
//                                             ),
//                                           ),
//                                           BoxShadow(
//                                             offset: const Offset(0, 1),
//                                             blurRadius: 2,
//                                             spreadRadius: 0,
//                                             color: Colors.black.withOpacity(
//                                               0.30,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Row(
//                                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           SizedBox(
//                                             // color: Colors.red,
//                                             height: 80.h,
//                                             width: 80.w,
//                                             child: Image.asset(
//                                               'assets/hostel_category_widget/media.png',
//                                             ),
//                                           ),
//                                           SizedBox(width: 10.h),
//                                           Container(
//                                             // color: Colors.red,
//                                             height: 80.h,
//                                             padding: EdgeInsets.only(top: 5.h),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               children: [
//                                                 SizedBox(
//                                                   height: 16.h,
//                                                   child: FittedBox(
//                                                     alignment:
//                                                         Alignment.centerLeft,
//                                                     child: Text(
//                                                       searchHostel.name,
//                                                       style: TextStyle(
//                                                         fontFamily: "Roboto",
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                         fontSize: 16.sp,
//                                                         letterSpacing: 0.15.w,
//                                                         color: const Color(
//                                                           0xFF1D1B20,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 12.h,
//                                                   child: FittedBox(
//                                                     alignment:
//                                                         Alignment.centerLeft,
//                                                     child: Row(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         Image.asset(
//                                                           "assets/hostel_category_widget/location.png",
//                                                           height: 12.h,
//                                                           width: 8.77.w,
//                                                         ),
//                                                         Text(
//                                                           "${searchHostel.university}, ${searchHostel.region} region",
//                                                           style: TextStyle(
//                                                             fontFamily:
//                                                                 "Roboto",
//                                                             // fontWeight: FontWeight.w500,
//                                                             fontSize: 10.sp,
//                                                             // letterSpacing: 0.15.w,
//                                                             color: const Color(
//                                                               0xFF333333,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 FittedBox(
//                                                   child: SizedBox(
//                                                     // color: Colors.red,
//                                                     height: 20.h,
//                                                     // width: 120.w,
//                                                     child: Text(
//                                                       "Wifi • Kitchen • Security • Parking •\nBalcony • Friendly Environment",
//                                                       overflow:
//                                                           TextOverflow.visible,
//                                                       style: TextStyle(
//                                                         fontFamily: "Roboto",
//                                                         // fontWeight: FontWeight.w500,
//                                                         fontSize: 9.sp,
//                                                         letterSpacing: 0.25.w,
//                                                         color: const Color(
//                                                           0xFF1D1B20,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 SizedBox(height: 5.h),
//                                                 SizedBox(
//                                                   height: 12.h,
//                                                   child: FittedBox(
//                                                     child: Row(
//                                                       children: [
//                                                         Text(
//                                                           "${searchHostel.rate}",
//                                                           style: TextStyle(
//                                                             fontFamily:
//                                                                 "Roboto",
//                                                             fontWeight:
//                                                                 FontWeight.w500,
//                                                             fontSize: 10.sp,
//                                                             color: const Color(
//                                                               0xFF333333,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         SizedBox(width: 5.h),
//                                                         SizedBox(
//                                                           height: 10,
//                                                           width: 60,
//                                                           child: ListView.builder(
//                                                             itemCount:
//                                                                 searchHostel
//                                                                     .rate,
//                                                             scrollDirection:
//                                                                 Axis.horizontal,
//                                                             itemBuilder:
//                                                                 (
//                                                                   context,
//                                                                   index,
//                                                                 ) {
//                                                                   return Icon(
//                                                                     Icons.star,
//                                                                     color: const Color(
//                                                                       0xFF00EFD1,
//                                                                     ),
//                                                                     size: 10.h,
//                                                                   );
//                                                                 },
//                                                           ),
//                                                         ),
//                                                         Row(
//                                                           children: [
//                                                             // Image.asset("warning.png", height: 12, width: 10,),
//                                                             Transform.flip(
//                                                               flipY: true,
//                                                               child: Icon(
//                                                                 Icons.info,
//                                                                 color:
//                                                                     Colors.red,
//                                                                 size: 10.h,
//                                                               ),
//                                                             ),
//                                                             Text(
//                                                               searchHostel.available_rooms !=
//                                                                       null
//                                                                   ? "${searchHostel.available_rooms} Slots available"
//                                                                   : " No Slots available",
//                                                               style: TextStyle(
//                                                                 color:
//                                                                     const Color.fromARGB(
//                                                                       180,
//                                                                       0,
//                                                                       0,
//                                                                       0,
//                                                                     ),
//                                                                 fontFamily:
//                                                                     "Roboto",
//                                                                 fontSize: 10.sp,
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           // SizedBox(
//                                           //   width: ScreenDetails.percentage(percent: 2, quantityToScale: "width"),
//                                           // ),
//                                           Expanded(
//                                             child: Container(
//                                               // padding:EdgeInsets.only(right: 10.h),
//                                               // color: Colors.blue,
//                                               // width: 60.w,
//                                               padding: EdgeInsets.only(
//                                                 top: 5.h,
//                                                 right: 10.h,
//                                               ),
//                                               child: Align(
//                                                 alignment: Alignment.topRight,
//                                                 child: GestureDetector(
//                                                   onTap: () {
//                                                     setState(() {
//                                                       favorite = !favorite;
//                                                     });
//                                                   },
//                                                   child: favorite
//                                                       ? Icon(
//                                                           Icons.favorite,
//                                                           color: const Color(
//                                                             0xFF00EFD1,
//                                                           ),
//                                                           size: 25.h,
//                                                         )
//                                                       : Icon(
//                                                           Icons
//                                                               .favorite_border_outlined,
//                                                           color: const Color(
//                                                             0xFF00EFD1,
//                                                           ),
//                                                           size: 25.h,
//                                                         ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(height: 20),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
