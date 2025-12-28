// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:on_campus/firebase/classes.dart';
// import 'package:on_campus/firebase/firestore_db.dart';
// import 'package:on_campus/screens/hostels_detail.dart';
// import 'package:on_campus/screens/search.dart';
// import 'package:on_campus/widgets/homestel_hostel_category.dart';
// import 'package:on_campus/widgets/private_hostel_category.dart';
// import 'package:on_campus/widgets/school_hostel_category.dart';
// import 'package:on_campus/screens/get_icon.dart';

// class Home extends StatefulWidget {
//   final String username;
//   const Home({super.key, required this.username});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   TextEditingController searchController = TextEditingController();

//   bool favorite = false;
//   bool seeAllPopular = false;
//   bool seeAllTop = false;

//   List<Hostels> hostels = [];
//   List<Hostels> topHostels = [];
//   // Map<String, dynamic> myLocations = {};
//   final FirebaseFirestore db = FirebaseFirestore.instance;

//   // List<bool> favoritebool = [];
//   List<bool> viewedFavoritebool = [];
//   bool isLoading = true;
//   int num = 0;

//   Future<void> getPopular() async {
//     setState(() {
//       isLoading = true;
//     });
//     List<Hostels> awaitPopular = await FirestoreDb.instance.getPopular();
//     List<Hostels> awaitTop = await FirestoreDb.instance.getPrivateHostels();
//     awaitPopular.shuffle();
//     awaitTop.shuffle();
//     setState(() {
//       hostels = awaitPopular;
//       topHostels = awaitTop;
//       // myLocations = awaitLocations;
//       isLoading = false;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getPopular();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       child: SafeArea(
//         child: Scaffold(
//           // backgroundColor: const Color(0xFFF5F5F5),
//           body: Stack(
//             children: [
//               Positioned(
//                 top: 0,
//                 right: 0,
//                 left: 0,
//                 bottom: 0,
//                 child: SingleChildScrollView(
//                   child: Container(
//                     color: Colors.white,
//                     padding: EdgeInsets.only(top: 30.h),
//                     child: Column(
//                       // mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           // height: 52,
//                           width: MediaQuery.of(context).size.width,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.only(left: 25),
//                                 child: Column(
//                                   // mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Welcome ${widget.username},",
//                                       style: TextStyle(
//                                         fontSize: 24.sp.clamp(0, 24),
//                                         fontFamily: "Poppins-Bold",
//                                         letterSpacing: 0.15.w,
//                                         // fontWeight: FontWeight.w700
//                                       ),
//                                     ),
//                                     SizedBox(height: 10),
//                                     Text(
//                                       "Find the best hostel that suits you",
//                                       style: TextStyle(
//                                         fontFamily: "Poppins",
//                                         fontSize: 16.sp.clamp(0, 16),
//                                         fontWeight: FontWeight.w500,
//                                         height: 1.5,
//                                         color: const Color.fromARGB(
//                                           200,
//                                           0,
//                                           0,
//                                           0,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Container(
//                                   margin: EdgeInsets.only(right: 15.h),
//                                   child: Image.asset(
//                                     "assets/home/user logo.png",
//                                     height: 50,
//                                     width: 50,
//                                     fit: BoxFit.contain,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         Container(
//                           margin: EdgeInsets.only(left: 25.h, right: 25.h),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     width: 1.5.w,
//                                     color: const Color.fromARGB(
//                                       255,
//                                       0,
//                                       239,
//                                       209,
//                                     ),
//                                   ),
//                                   borderRadius: BorderRadius.circular(50.r),
//                                 ),
//                                 height: 44.h,
//                                 width: 280.w.clamp(0, 280),
//                                 child: Center(
//                                   child: TextField(
//                                     onTap: () {
//                                       Get.to(
//                                         () => Search(),
//                                         transition: Transition.fadeIn,
//                                         duration: const Duration(
//                                           milliseconds: 200,
//                                         ),
//                                         curve: Curves.easeIn,
//                                       );
//                                     },
//                                     controller: searchController,
//                                     decoration: InputDecoration(
//                                       prefixIcon: Icon(
//                                         Icons.search_outlined,
//                                         size: 17.sp.clamp(0, 17),
//                                       ),
//                                       prefixIconColor: Color.fromARGB(
//                                         255,
//                                         0,
//                                         239,
//                                         209,
//                                       ),
//                                       hintText: "Search for hostels",
//                                       hintStyle: TextStyle(
//                                         color: Color.fromARGB(120, 0, 0, 0),
//                                         fontSize: 18.sp.clamp(0, 18),
//                                       ),
//                                       border: OutlineInputBorder(
//                                         borderSide: BorderSide.none,
//                                         // borderRadius: BorderRadius.circular(50.r),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 10),
//                               SizedBox(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                       width: 1.5.w,
//                                       color: const Color.fromARGB(
//                                         255,
//                                         0,
//                                         239,
//                                         209,
//                                       ),
//                                     ),
//                                     borderRadius: BorderRadius.circular(10.r),
//                                   ),
//                                   child: Center(
//                                     // alignment: Alignment.center,
//                                     child: Stack(
//                                       children: [
//                                         Container(
//                                           padding: EdgeInsets.all(2.h),
//                                           child: const Icon(
//                                             Icons.notifications_outlined,
//                                             color: Color.fromARGB(
//                                               255,
//                                               0,
//                                               239,
//                                               209,
//                                             ),
//                                           ),
//                                         ),
//                                         Positioned(
//                                           top: 0.h,
//                                           right: 4.h,
//                                           child: Container(
//                                             decoration: const BoxDecoration(
//                                               color: Color.fromARGB(
//                                                 255,
//                                                 0,
//                                                 239,
//                                                 209,
//                                               ),
//                                               shape: BoxShape.circle,
//                                             ),
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(
//                                                 4.0,
//                                               ),
//                                               child: Text(
//                                                 "1",
//                                                 style: TextStyle(
//                                                   fontSize: 12.sp.clamp(0, 12),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 15.h),
//                         Container(
//                           // color: Colors.yellow,
//                           margin: EdgeInsets.only(left: 25.h, right: 25.h),
//                           // height: 24,
//                           // width: 124.w,
//                           child: Text(
//                             "Categories",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontFamily: "Poppins",
//                               letterSpacing: 0.15,
//                               fontSize: 22.sp.clamp(0, 22),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10.h),
//                         Container(
//                           // color: Colors.yellow,
//                           margin: EdgeInsets.only(right: 25.h, left: 25.h),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     Get.to(
//                                       () => SchoolHostelCategory(
//                                         username: widget.username,
//                                       ),
//                                       transition: Transition.fadeIn,
//                                       duration: const Duration(
//                                         milliseconds: 200,
//                                       ),
//                                       curve: Curves.easeIn,
//                                     );
//                                   },
//                                   child: SizedBox(
//                                     // width: 105.w.clamp(0, 105),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: [
//                                         Image.asset(
//                                           "assets/home/Ellipse 3.png",
//                                           height: 70,
//                                           width: 70.w.clamp(0, 70),
//                                         ),
//                                         SizedBox(height: 4),
//                                         Padding(
//                                           padding: EdgeInsets.only(right: 15.h),
//                                           child: Text(
//                                             "School Hostel",
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                               fontSize: 15.sp.clamp(0, 15),
//                                               fontFamily: "Poppins",
//                                               fontWeight: FontWeight.w500,
//                                               letterSpacing: 0.15,
//                                               color: const Color.fromARGB(
//                                                 180,
//                                                 0,
//                                                 0,
//                                                 0,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     Get.to(
//                                       () => PrivateHostelCategory(
//                                         username: widget.username,
//                                       ),
//                                       transition: Transition.fadeIn,
//                                       duration: const Duration(
//                                         milliseconds: 200,
//                                       ),
//                                       curve: Curves.easeIn,
//                                     );
//                                   },
//                                   child: SizedBox(
//                                     // height: 90.h,
//                                     // width: 105.w.clamp(0, 105),
//                                     // color: Colors.blue,
//                                     child: Column(
//                                       children: [
//                                         Image.asset(
//                                           "assets/home/Ellipse 4.png",
//                                           height: 70,
//                                           width: 70.w,
//                                         ),
//                                         SizedBox(height: 4.h),
//                                         Text(
//                                           "Private Hostel",
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                             fontSize: 15.sp.clamp(0, 15),
//                                             fontWeight: FontWeight.w500,
//                                             fontFamily: "Poppins",
//                                             letterSpacing: 0.15,
//                                             color: const Color.fromARGB(
//                                               180,
//                                               0,
//                                               0,
//                                               0,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     Get.to(
//                                       () => HomestelHostelCategory(
//                                         username: widget.username,
//                                       ),
//                                       transition: Transition.fadeIn,
//                                       duration: const Duration(
//                                         milliseconds: 200,
//                                       ),
//                                       curve: Curves.easeIn,
//                                     );
//                                   },
//                                   child: SizedBox(
//                                     // height: 90.h,
//                                     // width: 105.w.clamp(0, 105),
//                                     // color: Colors.blue,
//                                     child: Column(
//                                       children: [
//                                         Image.asset(
//                                           "assets/home/Ellipse 5.png",
//                                           height: 70,
//                                           width: 70.w,
//                                         ),
//                                         SizedBox(height: 4.h),
//                                         Text(
//                                           "Homestel",
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                             fontSize: 15.sp.clamp(0, 15),
//                                             fontWeight: FontWeight.w500,
//                                             fontFamily: "Poppins",
//                                             letterSpacing: 0.15,
//                                             color: const Color.fromARGB(
//                                               180,
//                                               0,
//                                               0,
//                                               0,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 15),
//                         Container(
//                           margin: EdgeInsets.only(left: 25.h),
//                           // height: 20.h,
//                           width: 361.w,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Popular Hostels",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: 22.sp.clamp(0, 22),
//                                   letterSpacing: 0.15,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(right: 15),
//                                 child: TextButton(
//                                   style: ButtonStyle(
//                                     backgroundColor: WidgetStateProperty.all(
//                                       Color.fromRGBO(0, 239, 209, .07),
//                                     ),
//                                     overlayColor: WidgetStateProperty.all(
//                                       Color.fromRGBO(0, 239, 209, .5),
//                                     ),
//                                     animationDuration: Duration(seconds: 2),
//                                   ),
//                                   isSemanticButton: true,
//                                   child: Text(
//                                     seeAllPopular ? "see less" : "see all",
//                                     style: TextStyle(
//                                       color: const Color.fromARGB(
//                                         255,
//                                         0,
//                                         239,
//                                         209,
//                                       ),
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 16.sp.clamp(0, 16),
//                                     ),
//                                   ),
//                                   onPressed: () {
//                                     setState(() {
//                                       seeAllPopular = !seeAllPopular;
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 15.h),
//                         isLoading
//                             ? Center(
//                                 child: SpinKitThreeBounce(
//                                   color: const Color.fromARGB(255, 0, 239, 209),
//                                   size: 50.0,
//                                 ),
//                               )
//                             : Padding(
//                                 padding: const EdgeInsets.only(left: 15.0),
//                                 child: SizedBox(
//                                   height: 300,
//                                   // width: MediaQuery.of(context).size.width,
//                                   width: 400,
//                                   child: ListView.builder(
//                                     physics: const BouncingScrollPhysics(),
//                                     scrollDirection: Axis.horizontal,
//                                     itemCount: seeAllPopular
//                                         ? hostels.length
//                                         : 5,
//                                     itemBuilder: (context, index) {
//                                       Hostels hostel = hostels[index];
//                                       String? string = hostel.hostel_images?[0];
//                                       return Row(
//                                         children: [
//                                           GestureDetector(
//                                             onTap: () {
//                                               Get.to(
//                                                 () => HostelDetails(
//                                                   username: widget.username,
//                                                   hostel: hostel,
//                                                 ),
//                                                 transition: Transition.fadeIn,
//                                                 duration: const Duration(
//                                                   milliseconds: 800,
//                                                 ),
//                                                 curve: Curves.easeIn,
//                                               );
//                                             },
//                                             child: Container(
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Container(
//                                                     // margin: EdgeInsets.only(right: 10.h),
//                                                     height: 145,
//                                                     width: 330.w.clamp(0, 330),
//                                                     decoration: BoxDecoration(
//                                                       // color: Colors.black,
//                                                       borderRadius:
//                                                           BorderRadius.only(
//                                                             topLeft:
//                                                                 Radius.circular(
//                                                                   12.r,
//                                                                 ),
//                                                             topRight:
//                                                                 Radius.circular(
//                                                                   12.r,
//                                                                 ),
//                                                             bottomLeft:
//                                                                 Radius.circular(
//                                                                   12.r,
//                                                                 ),
//                                                             bottomRight:
//                                                                 Radius.circular(
//                                                                   12.r,
//                                                                 ),
//                                                           ),
//                                                     ),
//                                                     child: Stack(
//                                                       children: [
//                                                         Positioned(
//                                                           top: 0,
//                                                           right: 0,
//                                                           left: 0,
//                                                           child: ClipRRect(
//                                                             borderRadius: BorderRadius.only(
//                                                               topLeft:
//                                                                   Radius.circular(
//                                                                     12.r,
//                                                                   ),
//                                                               topRight:
//                                                                   Radius.circular(
//                                                                     12.r,
//                                                                   ),
//                                                               bottomLeft:
//                                                                   Radius.circular(
//                                                                     12.r,
//                                                                   ),
//                                                               bottomRight:
//                                                                   Radius.circular(
//                                                                     12.r,
//                                                                   ),
//                                                             ),
//                                                             child: CachedNetworkImage(
//                                                               imageUrl:
//                                                                   string ?? "",
//                                                               height: 145,
//                                                               width: 330.w
//                                                                   .clamp(
//                                                                     0,
//                                                                     330,
//                                                                   ),
//                                                               fit: BoxFit.cover,
//                                                               placeholder:
//                                                                   (
//                                                                     context,
//                                                                     url,
//                                                                   ) => SpinKitThreeBounce(
//                                                                     color:
//                                                                         const Color.fromARGB(
//                                                                           255,
//                                                                           0,
//                                                                           239,
//                                                                           209,
//                                                                         ),
//                                                                     size: 50.0,
//                                                                   ),
//                                                               errorWidget:
//                                                                   (
//                                                                     context,
//                                                                     url,
//                                                                     error,
//                                                                   ) => Icon(
//                                                                     Icons.error,
//                                                                   ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Positioned(
//                                                           top: 5.h,
//                                                           right: 5.h,
//                                                           // left: 0,
//                                                           child: GestureDetector(
//                                                             onTap: () {
//                                                               setState(() {});
//                                                             },
//                                                             child: Container(
//                                                               height: 35.h,
//                                                               width: 35.w,
//                                                               decoration:
//                                                                   const BoxDecoration(
//                                                                     color: Colors
//                                                                         .white,
//                                                                     shape: BoxShape
//                                                                         .circle,
//                                                                   ),
//                                                               child: Icon(
//                                                                 size: 20.h,
//                                                                 hostel.ispopular!
//                                                                     ? Icons
//                                                                           .favorite_outlined
//                                                                     : Icons
//                                                                           .favorite_border_outlined,
//                                                                 color:
//                                                                     const Color.fromARGB(
//                                                                       255,
//                                                                       0,
//                                                                       239,
//                                                                       209,
//                                                                     ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Positioned(
//                                                           top: 0,
//                                                           left: 0,
//                                                           child: Container(
//                                                             padding:
//                                                                 EdgeInsets.only(
//                                                                   left: 5,
//                                                                   right: 5,
//                                                                 ),
//                                                             height: 16.h,
//                                                             // width: 45.w,
//                                                             decoration: BoxDecoration(
//                                                               color:
//                                                                   const Color.fromRGBO(
//                                                                     50,
//                                                                     50,
//                                                                     50,
//                                                                     0.5,
//                                                                   ),
//                                                               borderRadius:
//                                                                   BorderRadius.only(
//                                                                     bottomRight:
//                                                                         Radius.circular(
//                                                                           12.r,
//                                                                         ),
//                                                                     topLeft:
//                                                                         Radius.circular(
//                                                                           12.r,
//                                                                         ),
//                                                                   ),
//                                                             ),
//                                                             child: Text(
//                                                               hostel.ispopular!
//                                                                   ? "popular"
//                                                                   : "",
//                                                               style: TextStyle(
//                                                                 fontSize: 12.sp
//                                                                     .clamp(
//                                                                       0,
//                                                                       12,
//                                                                     ),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                                 fontFamily:
//                                                                     "Roboto",
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   SizedBox(height: 20),
//                                                   SizedBox(
//                                                     width: 330.w.clamp(0, 330),
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Text(
//                                                               hostel.name,
//                                                               style: TextStyle(
//                                                                 fontFamily:
//                                                                     "Poppins",
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w600,
//                                                                 fontSize: 20.sp
//                                                                     .clamp(
//                                                                       0,
//                                                                       22,
//                                                                     ),
//                                                               ),
//                                                             ),
//                                                             Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .spaceBetween,
//                                                               children: [
//                                                                 Row(
//                                                                   children: [
//                                                                     Text(
//                                                                       "${hostel.city}, ${hostel.region}",
//                                                                       style: TextStyle(
//                                                                         fontSize: 15
//                                                                             .sp
//                                                                             .clamp(
//                                                                               0,
//                                                                               18,
//                                                                             ),
//                                                                         fontFamily:
//                                                                             "Poppins",
//                                                                         fontWeight:
//                                                                             FontWeight.w500,
//                                                                         letterSpacing:
//                                                                             0.15.w,
//                                                                         color: const Color(
//                                                                           0xFF323232,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                                 SizedBox(
//                                                                   width: 5,
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         Expanded(
//                                                           child: Container(
//                                                             // color: Colors.red,
//                                                             child: Column(
//                                                               crossAxisAlignment:
//                                                                   CrossAxisAlignment
//                                                                       .end,
//                                                               children: [
//                                                                 Align(
//                                                                   alignment:
//                                                                       Alignment
//                                                                           .topRight,
//                                                                   child: Text.rich(
//                                                                     TextSpan(
//                                                                       children: [
//                                                                         TextSpan(
//                                                                           text:
//                                                                               "From\n",
//                                                                           style: TextStyle(
//                                                                             fontWeight:
//                                                                                 FontWeight.w500,
//                                                                             fontSize: 12.sp.clamp(
//                                                                               0,
//                                                                               12,
//                                                                             ),
//                                                                             color: const Color(
//                                                                               0xFF323232,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         TextSpan(
//                                                                           text:
//                                                                               "GHS ${hostel.amt_per_year} ",
//                                                                           style: TextStyle(
//                                                                             fontWeight:
//                                                                                 FontWeight.bold, // Only "GHS" is bold
//                                                                             fontSize: 12.sp.clamp(
//                                                                               0,
//                                                                               12,
//                                                                             ),
//                                                                             color: const Color(
//                                                                               0xFF323232,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         TextSpan(
//                                                                           text:
//                                                                               "\nper year",
//                                                                           style: TextStyle(
//                                                                             fontWeight:
//                                                                                 FontWeight.w500,
//                                                                             fontSize: 12.sp.clamp(
//                                                                               0,
//                                                                               12,
//                                                                             ),
//                                                                             color: const Color(
//                                                                               0xFF323232,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .right, // Aligns all text to the right
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   SizedBox(height: 15),
//                                                   Container(
//                                                     width: 300,
//                                                     height: 25,
//                                                     child: ListView.builder(
//                                                       scrollDirection:
//                                                           Axis.horizontal,
//                                                       itemCount: hostel
//                                                           .amenities!
//                                                           .length,
//                                                       itemBuilder: (context, index) {
//                                                         return Container(
//                                                           child: Padding(
//                                                             padding:
//                                                                 const EdgeInsets.symmetric(
//                                                                   horizontal:
//                                                                       4.0,
//                                                                   vertical: 0,
//                                                                 ),
//                                                             child: OutlinedButton(
//                                                               style: OutlinedButton.styleFrom(
//                                                                 padding:
//                                                                     EdgeInsets.symmetric(
//                                                                       horizontal:
//                                                                           10,
//                                                                       vertical:
//                                                                           3,
//                                                                     ),
//                                                                 foregroundColor:
//                                                                     Colors
//                                                                         .black,
//                                                                 shape: RoundedRectangleBorder(
//                                                                   borderRadius:
//                                                                       BorderRadius.circular(
//                                                                         5,
//                                                                       ),
//                                                                 ),
//                                                               ),
//                                                               onPressed: () {},
//                                                               child: Container(
//                                                                 // width: 40,
//                                                                 // height: 20,
//                                                                 child: Row(
//                                                                   children: [
//                                                                     GetIcon(
//                                                                       text:
//                                                                           hostel
//                                                                               .amenities![index] ??
//                                                                           "noicon",
//                                                                     ),
//                                                                     SizedBox(
//                                                                       width: 3,
//                                                                     ),
//                                                                     Text(
//                                                                       hostel.amenities![index] ??
//                                                                           "none",
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         );
//                                                       },
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(width: 20),
//                                         ],
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                         Container(
//                           margin: EdgeInsets.only(left: 25.h),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Top Best Hostels for you",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: 20.sp.clamp(0, 20),
//                                   letterSpacing: 0.15,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(right: 15.h),
//                                 child: TextButton(
//                                   style: ButtonStyle(
//                                     backgroundColor: WidgetStateProperty.all(
//                                       Color.fromRGBO(0, 239, 209, .07),
//                                     ),
//                                     overlayColor: WidgetStateProperty.all(
//                                       Color.fromRGBO(0, 239, 209, .5),
//                                     ),
//                                     animationDuration: Duration(seconds: 2),
//                                   ),
//                                   isSemanticButton: true,
//                                   child: Text(
//                                     seeAllTop ? "see less" : "see all",
//                                     style: TextStyle(
//                                       color: const Color.fromARGB(
//                                         255,
//                                         0,
//                                         239,
//                                         209,
//                                       ),
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 16.sp.clamp(0, 16),
//                                     ),
//                                   ),
//                                   onPressed: () {
//                                     setState(() {
//                                       seeAllTop = !seeAllTop;
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 15.h),
//                         isLoading
//                             ? Center(
//                                 child: SpinKitThreeBounce(
//                                   color: const Color.fromARGB(255, 0, 239, 209),
//                                   size: 50.0,
//                                 ),
//                               )
//                             : SingleChildScrollView(
//                                 child: Column(
//                                   children: List.generate(seeAllTop ? topHostels.length : 5, (
//                                     index,
//                                   ) {
//                                     Hostels topHostel = topHostels[index];
//                                     String? string =
//                                         topHostels[index].hostel_images?[0];
//                                     return GestureDetector(
//                                       onTap: () {
//                                         Get.to(
//                                           () => HostelDetails(
//                                             username: widget.username,
//                                             hostel: topHostel,
//                                           ),
//                                           transition: Transition.fadeIn,
//                                           duration: const Duration(
//                                             milliseconds: 800,
//                                           ),
//                                           curve: Curves.easeIn,
//                                         );
//                                       },
//                                       child: ListTile(
//                                         title: Center(
//                                           child: Container(
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Container(
//                                                   // margin: EdgeInsets.only(right: 10.h),
//                                                   height: 145,
//                                                   width: 330.w.clamp(0, 330),
//                                                   decoration: BoxDecoration(
//                                                     // color: Colors.black,
//                                                     borderRadius:
//                                                         BorderRadius.only(
//                                                           topLeft:
//                                                               Radius.circular(
//                                                                 12.r,
//                                                               ),
//                                                           topRight:
//                                                               Radius.circular(
//                                                                 12.r,
//                                                               ),
//                                                           bottomLeft:
//                                                               Radius.circular(
//                                                                 12.r,
//                                                               ),
//                                                           bottomRight:
//                                                               Radius.circular(
//                                                                 12.r,
//                                                               ),
//                                                         ),
//                                                   ),
//                                                   child: Stack(
//                                                     children: [
//                                                       Positioned(
//                                                         top: 0,
//                                                         right: 0,
//                                                         left: 0,
//                                                         child: ClipRRect(
//                                                           borderRadius: BorderRadius.only(
//                                                             topLeft:
//                                                                 Radius.circular(
//                                                                   12.r,
//                                                                 ),
//                                                             topRight:
//                                                                 Radius.circular(
//                                                                   12.r,
//                                                                 ),
//                                                             bottomLeft:
//                                                                 Radius.circular(
//                                                                   12.r,
//                                                                 ),
//                                                             bottomRight:
//                                                                 Radius.circular(
//                                                                   12.r,
//                                                                 ),
//                                                           ),
//                                                           child: CachedNetworkImage(
//                                                             imageUrl:
//                                                                 string ?? "",
//                                                             height: 145,
//                                                             width: 330.w.clamp(
//                                                               0,
//                                                               330,
//                                                             ),
//                                                             fit: BoxFit.cover,
//                                                             placeholder:
//                                                                 (
//                                                                   context,
//                                                                   url,
//                                                                 ) => SpinKitThreeBounce(
//                                                                   color:
//                                                                       const Color.fromARGB(
//                                                                         255,
//                                                                         0,
//                                                                         239,
//                                                                         209,
//                                                                       ),
//                                                                   size: 50.0,
//                                                                 ),
//                                                             errorWidget:
//                                                                 (
//                                                                   context,
//                                                                   url,
//                                                                   error,
//                                                                 ) => Icon(
//                                                                   Icons.error,
//                                                                 ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Positioned(
//                                                         top: 5.h,
//                                                         right: 5.h,
//                                                         // left: 0,
//                                                         child: GestureDetector(
//                                                           onTap: () {
//                                                             setState(() {});
//                                                           },
//                                                           child: Container(
//                                                             height: 35.h,
//                                                             width: 35.w,
//                                                             decoration:
//                                                                 const BoxDecoration(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   shape: BoxShape
//                                                                       .circle,
//                                                                 ),
//                                                             child: Icon(
//                                                               size: 20.h,
//                                                               topHostel
//                                                                       .ispopular!
//                                                                   ? Icons
//                                                                         .favorite_outlined
//                                                                   : Icons
//                                                                         .favorite_border_outlined,
//                                                               color:
//                                                                   const Color.fromARGB(
//                                                                     255,
//                                                                     0,
//                                                                     239,
//                                                                     209,
//                                                                   ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Positioned(
//                                                         top: 0,
//                                                         left: 0,
//                                                         child: Container(
//                                                           padding:
//                                                               EdgeInsets.only(
//                                                                 left: 5,
//                                                                 right: 5,
//                                                               ),
//                                                           height: 16.h,
//                                                           // width: 45.w,
//                                                           decoration: BoxDecoration(
//                                                             color:
//                                                                 const Color.fromRGBO(
//                                                                   50,
//                                                                   50,
//                                                                   50,
//                                                                   0.5,
//                                                                 ),
//                                                             borderRadius:
//                                                                 BorderRadius.only(
//                                                                   bottomRight:
//                                                                       Radius.circular(
//                                                                         12.r,
//                                                                       ),
//                                                                   topLeft:
//                                                                       Radius.circular(
//                                                                         12.r,
//                                                                       ),
//                                                                 ),
//                                                           ),
//                                                           child: Text(
//                                                             topHostel.ispopular!
//                                                                 ? "popular"
//                                                                 : "",
//                                                             style: TextStyle(
//                                                               fontSize: 12.sp
//                                                                   .clamp(0, 12),
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w500,
//                                                               fontFamily:
//                                                                   "Roboto",
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 SizedBox(height: 20),
//                                                 SizedBox(
//                                                   width: 330.w.clamp(0, 330),
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                     children: [
//                                                       Column(
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           Text(
//                                                             topHostel.name,
//                                                             style: TextStyle(
//                                                               fontFamily:
//                                                                   "Poppins",
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w600,
//                                                               fontSize: 20.sp
//                                                                   .clamp(0, 22),
//                                                             ),
//                                                           ),
//                                                           Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceBetween,
//                                                             children: [
//                                                               Row(
//                                                                 children: [
//                                                                   Text(
//                                                                     "${topHostel.city}, ${topHostel.region}",
//                                                                     style: TextStyle(
//                                                                       fontSize: 15
//                                                                           .sp
//                                                                           .clamp(
//                                                                             0,
//                                                                             18,
//                                                                           ),
//                                                                       fontFamily:
//                                                                           "Poppins",
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w500,
//                                                                       letterSpacing:
//                                                                           0.15.w,
//                                                                       color: const Color(
//                                                                         0xFF323232,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                               SizedBox(
//                                                                 width: 5,
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       Expanded(
//                                                         child: Container(
//                                                           // color: Colors.red,
//                                                           child: Column(
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .end,
//                                                             children: [
//                                                               Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topRight,
//                                                                 child: Text.rich(
//                                                                   TextSpan(
//                                                                     children: [
//                                                                       TextSpan(
//                                                                         text:
//                                                                             "From\n",
//                                                                         style: TextStyle(
//                                                                           fontWeight:
//                                                                               FontWeight.w500,
//                                                                           fontSize: 12.sp.clamp(
//                                                                             0,
//                                                                             12,
//                                                                           ),
//                                                                           color: const Color(
//                                                                             0xFF323232,
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                       TextSpan(
//                                                                         text:
//                                                                             "GHS ${topHostel.amt_per_year} ",
//                                                                         style: TextStyle(
//                                                                           fontWeight:
//                                                                               FontWeight.bold, // Only "GHS" is bold
//                                                                           fontSize: 12.sp.clamp(
//                                                                             0,
//                                                                             12,
//                                                                           ),
//                                                                           color: const Color(
//                                                                             0xFF323232,
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                       TextSpan(
//                                                                         text:
//                                                                             "\nper year",
//                                                                         style: TextStyle(
//                                                                           fontWeight:
//                                                                               FontWeight.w500,
//                                                                           fontSize: 12.sp.clamp(
//                                                                             0,
//                                                                             12,
//                                                                           ),
//                                                                           color: const Color(
//                                                                             0xFF323232,
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .right, // Aligns all text to the right
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 SizedBox(height: 15),
//                                                 Container(
//                                                   width: 300,
//                                                   height: 25,
//                                                   child: ListView.builder(
//                                                     scrollDirection:
//                                                         Axis.horizontal,
//                                                     itemCount: topHostel
//                                                         .amenities!
//                                                         .length,
//                                                     itemBuilder: (context, index) {
//                                                       return Container(
//                                                         child: Padding(
//                                                           padding:
//                                                               const EdgeInsets.symmetric(
//                                                                 horizontal: 4.0,
//                                                                 vertical: 0,
//                                                               ),
//                                                           child: OutlinedButton(
//                                                             style: OutlinedButton.styleFrom(
//                                                               padding:
//                                                                   EdgeInsets.symmetric(
//                                                                     horizontal:
//                                                                         10,
//                                                                     vertical: 3,
//                                                                   ),
//                                                               foregroundColor:
//                                                                   Colors.black,
//                                                               shape: RoundedRectangleBorder(
//                                                                 borderRadius:
//                                                                     BorderRadius.circular(
//                                                                       5,
//                                                                     ),
//                                                               ),
//                                                             ),
//                                                             onPressed: () {},
//                                                             child: Container(
//                                                               // width: 40,
//                                                               // height: 20,
//                                                               child: Row(
//                                                                 children: [
//                                                                   GetIcon(
//                                                                     text:
//                                                                         topHostel
//                                                                             .amenities![index] ??
//                                                                         "noicon",
//                                                                   ),
//                                                                   SizedBox(
//                                                                     width: 3,
//                                                                   ),
//                                                                   Text(
//                                                                     topHostel
//                                                                             .amenities![index] ??
//                                                                         "none",
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       );
//                                                     },
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   }),

//                                   // if (topHostels[index].gender == "male") {
//                                 ),
//                               ),

//                         // Container(
//                         //   margin: EdgeInsets.symmetric(horizontal: 25.h),
//                         //   width: 380.w,
//                         //   height: 30.h,
//                         //   // color: Colors.amber,
//                         //   child: RichText(
//                         //     text: TextSpan(
//                         //       text: "On Campus",
//                         //       style: TextStyle(
//                         //           color: Colors.black,
//                         //           fontSize: 22.sp.clamp(0, 22),
//                         //           // fontWeight: FontWeight.w700,
//                         //           fontFamily: "Poppins-Bold",
//                         //           letterSpacing: 0.15.w),
//                         //       children: [
//                         //         TextSpan(
//                         //           text: " Connect",
//                         //           style: TextStyle(
//                         //               color: const Color.fromARGB(
//                         //                   255, 0, 239, 209),
//                         //               fontSize: 22.sp.clamp(0, 22),
//                         //               fontFamily: "Poppins-Bold",
//                         //               letterSpacing: 0.15.w),
//                         //         )
//                         //       ],
//                         //     ),
//                         //   ),
//                         // ),
//                         // Container(
//                         //   margin: EdgeInsets.symmetric(horizontal: 25.h),
//                         //   height: 50.h,
//                         //   width: 380.w,
//                         //   // color: Colors.red,
//                         //   child: Row(
//                         //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         //     children: [
//                         //       SizedBox(
//                         //         height: 50.h,
//                         //         width: 50.w,
//                         //         child: const CircleAvatar(
//                         //           backgroundImage: AssetImage(
//                         //             "assets/home/kfcIcon.png",
//                         //           ),
//                         //         ),
//                         //       ),
//                         //       SizedBox(
//                         //         width: 10.w,
//                         //       ),
//                         //       SizedBox(
//                         //         height: 50.h,
//                         //         width: 50.w,
//                         //         child: const CircleAvatar(
//                         //           backgroundImage: AssetImage(
//                         //             "assets/home/uberIcon.png",
//                         //           ),
//                         //         ),
//                         //       ),
//                         //       SizedBox(
//                         //         width: 10.w,
//                         //       ),
//                         //       SizedBox(
//                         //         height: 50.h,
//                         //         width: 50.w,
//                         //         child: const CircleAvatar(
//                         //           backgroundImage: AssetImage(
//                         //             "assets/home/showMaxIcon.png",
//                         //           ),
//                         //         ),
//                         //       ),
//                         //       SizedBox(
//                         //         width: 10.w,
//                         //       ),
//                         //       SizedBox(
//                         //         height: 50.h,
//                         //         width: 50.w,
//                         //         child: const CircleAvatar(
//                         //           backgroundImage: AssetImage(
//                         //             "assets/home/pharmacyIcon.png",
//                         //           ),
//                         //         ),
//                         //       )
//                         //     ],
//                         //   ),
//                         // ),
//                         // // SizedBox(height:10.h),
//                         // Container(
//                         //   // color: Colors.blue,
//                         //   margin: EdgeInsets.symmetric(horizontal: 25.h),
//                         //   height: 50.h,
//                         //   width: 380.w,
//                         //   child: Row(
//                         //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         //     children: [
//                         //       Image.asset(
//                         //         "assets/home/jumiaIcon.png",
//                         //         height: 50.h,
//                         //         width: 50.w,
//                         //       ),
//                         //       SizedBox(
//                         //         width: 10.w,
//                         //       ),
//                         //       Image.asset(
//                         //         "assets/home/uberEatsIcon.png",
//                         //         height: 50.h,
//                         //         width: 50.w,
//                         //         // fit: BoxFit.cover,
//                         //       ),
//                         //       SizedBox(
//                         //         width: 10.w,
//                         //       ),
//                         //       Image.asset(
//                         //         "assets/home/boltIcon.png",
//                         //         height: 50.h,
//                         //         width: 50.w,
//                         //       ),
//                         //       SizedBox(
//                         //         width: 10.w,
//                         //       ),
//                         //       Image.asset(
//                         //         "assets/home/laundryIcon.png",
//                         //         height: 50.h,
//                         //         width: 50.w,
//                         //       )
//                         //     ],
//                         //   ),
//                         // ),
//                         // Container(
//                         //   // color: Colors.green,
//                         //   margin: EdgeInsets.symmetric(horizontal: 25.h),
//                         //   height: 50.h,
//                         //   width: 160.w,
//                         //   child: Row(
//                         //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         //     children: [
//                         //       Image.asset(
//                         //         "assets/home/cheggIcon.png",
//                         //         height: 50.h,
//                         //         width: 50.w,
//                         //       ),
//                         //       SizedBox(
//                         //         width: 10.w,
//                         //       ),
//                         //       Image.asset(
//                         //         "assets/home/moreIcon.png",
//                         //         height: 50.h,
//                         //         width: 50.w,
//                         //       ),
//                         //     ],
//                         //   ),
//                         // ),
//                         Container(
//                           margin: EdgeInsets.symmetric(horizontal: 25.w),
//                           child: RichText(
//                             text: TextSpan(
//                               text: "Previously",
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 22.sp.clamp(0, 22),
//                                 fontFamily: "Poppins-Bold",
//                                 letterSpacing: 0.15.w,
//                               ),
//                               children: [
//                                 TextSpan(
//                                   text: " Viewed",
//                                   style: TextStyle(
//                                     color: const Color.fromARGB(
//                                       255,
//                                       0,
//                                       239,
//                                       209,
//                                     ),
//                                     fontSize: 22.sp.clamp(0, 22),
//                                     fontFamily: "Poppins-Bold",
//                                     letterSpacing: 0.15.w,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         isLoading
//                             ? Center(
//                                 child: SpinKitThreeBounce(
//                                   color: const Color.fromARGB(255, 0, 239, 209),
//                                   size: 50.0,
//                                 ),
//                               )
//                             : SizedBox(
//                                 // margin: EdgeInsets.only(bottom: 5.h),
//                                 // color: Colors.red,
//                                 height: 320,
//                                 // width: 225.w,
//                                 width: MediaQuery.of(context).size.width,
//                                 child: ListView.builder(
//                                   scrollDirection: Axis.horizontal,
//                                   physics: const BouncingScrollPhysics(),
//                                   itemCount: hostels.length,
//                                   itemBuilder: (context, index) {
//                                     return Row(
//                                       children: [
//                                         SizedBox(width: 25.w),
//                                         GestureDetector(
//                                           onTap: () {
//                                             Get.to(
//                                               () => HostelDetails(
//                                                 username: widget.username,
//                                                 hostel: hostels[index],
//                                               ),
//                                               transition: Transition.fadeIn,
//                                               duration: const Duration(
//                                                 milliseconds: 800,
//                                               ),
//                                               curve: Curves.easeIn,
//                                             );
//                                           },
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Container(
//                                               // height: 215.h,
//                                               decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.only(
//                                                   topRight: Radius.circular(
//                                                     28.r,
//                                                   ),
//                                                   topLeft: Radius.circular(
//                                                     28.r,
//                                                   ),
//                                                   bottomLeft: Radius.circular(
//                                                     28.r,
//                                                   ),
//                                                   bottomRight: Radius.circular(
//                                                     28.r,
//                                                   ),
//                                                 ),
//                                                 color: Colors.white,
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     offset: const Offset(0, 1),
//                                                     blurRadius: 4,
//                                                     color: Colors.black
//                                                         .withOpacity(0.25),
//                                                   ),
//                                                 ],
//                                               ),
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   SizedBox(
//                                                     height: 166,
//                                                     width: 245.w.clamp(0, 245),
//                                                     child: Stack(
//                                                       children: [
//                                                         Positioned(
//                                                           top: 0,
//                                                           right: 0,
//                                                           left: 0,
//                                                           child: Container(
//                                                             height: 165,
//                                                             width: 245.w,
//                                                             decoration: BoxDecoration(
//                                                               // color: Colors.brown,
//                                                               borderRadius:
//                                                                   BorderRadius.circular(
//                                                                     12.r,
//                                                                   ),
//                                                             ),
//                                                             child: ClipRRect(
//                                                               borderRadius:
//                                                                   BorderRadius.circular(
//                                                                     12.r,
//                                                                   ),
//                                                               child: Image.network(
//                                                                 hostels[index]
//                                                                         .hostel_images?[0] ??
//                                                                     "",
//                                                                 height: 165,
//                                                                 width: 225.w,
//                                                                 fit: BoxFit
//                                                                     .cover,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Positioned(
//                                                           top: 5.h,
//                                                           right: 5.w,
//                                                           // left: 0,
//                                                           child: GestureDetector(
//                                                             onTap: () {
//                                                               setState(() {
//                                                                 favorite =
//                                                                     !favorite;
//                                                               });
//                                                             },
//                                                             child: Container(
//                                                               height: 35,
//                                                               width: 35,
//                                                               decoration:
//                                                                   const BoxDecoration(
//                                                                     color: Colors
//                                                                         .white,
//                                                                     shape: BoxShape
//                                                                         .circle,
//                                                                   ),
//                                                               child: Icon(
//                                                                 size: 20.h,
//                                                                 favorite
//                                                                     ? Icons
//                                                                           .favorite_outlined
//                                                                     : Icons
//                                                                           .favorite_border_outlined,
//                                                                 color:
//                                                                     const Color.fromARGB(
//                                                                       255,
//                                                                       0,
//                                                                       239,
//                                                                       209,
//                                                                     ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Positioned(
//                                                           child: Text(""),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   const SizedBox(height: 5),
//                                                   Container(
//                                                     // color: Colors.green,
//                                                     padding: EdgeInsets.only(
//                                                       left: 15.h,
//                                                     ),
//                                                     child: Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         Text(
//                                                           hostels[index].name,
//                                                           style: TextStyle(
//                                                             color:
//                                                                 const Color.fromARGB(
//                                                                   150,
//                                                                   0,
//                                                                   0,
//                                                                   0,
//                                                                 ),
//                                                             fontSize: 18.sp
//                                                                 .clamp(0, 18),
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             fontFamily:
//                                                                 "Poppins",
//                                                           ),
//                                                         ),
//                                                         Text(
//                                                           hostels[index].city ??
//                                                               "",
//                                                           style: TextStyle(
//                                                             fontSize: 13.sp
//                                                                 .clamp(0, 18),
//                                                             fontWeight:
//                                                                 FontWeight.w500,
//                                                             fontFamily:
//                                                                 "Poppins",
//                                                             color: const Color(
//                                                               0xFF323232,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         SizedBox(height: 10),
//                                                         Text.rich(
//                                                           TextSpan(
//                                                             children: [
//                                                               TextSpan(
//                                                                 text: "From",
//                                                               ),
//                                                               TextSpan(
//                                                                 text:
//                                                                     "GHS ${hostels[index].amt_per_year}/",
//                                                                 style: TextStyle(
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                 ),
//                                                               ),
//                                                               TextSpan(
//                                                                 text: "year",
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         SizedBox(height: 10),
//                                                         Container(
//                                                           width: 220.w.clamp(
//                                                             0,
//                                                             220,
//                                                           ),
//                                                           height: 25,
//                                                           child: ListView.builder(
//                                                             scrollDirection:
//                                                                 Axis.horizontal,
//                                                             itemCount:
//                                                                 hostels[index]
//                                                                     .amenities!
//                                                                     .length,
//                                                             itemBuilder: (context, index2) {
//                                                               return Container(
//                                                                 child: Padding(
//                                                                   padding:
//                                                                       const EdgeInsets.only(
//                                                                         left: 0,
//                                                                         right:
//                                                                             4.0,
//                                                                       ),
//                                                                   child: OutlinedButton(
//                                                                     style: OutlinedButton.styleFrom(
//                                                                       padding: EdgeInsets.symmetric(
//                                                                         horizontal:
//                                                                             10,
//                                                                         vertical:
//                                                                             3,
//                                                                       ),
//                                                                       foregroundColor:
//                                                                           Colors
//                                                                               .black,
//                                                                       shape: RoundedRectangleBorder(
//                                                                         borderRadius:
//                                                                             BorderRadius.circular(
//                                                                               5,
//                                                                             ),
//                                                                       ),
//                                                                     ),
//                                                                     onPressed:
//                                                                         () {},
//                                                                     child: Container(
//                                                                       // width: 40,
//                                                                       // height: 20,
//                                                                       child: Row(
//                                                                         children: [
//                                                                           GetIcon(
//                                                                             text:
//                                                                                 hostels[index].amenities![index2] ??
//                                                                                 "noicon",
//                                                                           ),
//                                                                           SizedBox(
//                                                                             width:
//                                                                                 3,
//                                                                           ),
//                                                                           Text(
//                                                                             hostels[index].amenities![index2] ??
//                                                                                 "none",
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               );
//                                                             },
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 ),
//                               ),
//                         SizedBox(height: 20),
//                         // Container(
//                         //   margin: EdgeInsets.symmetric(horizontal: 25.h),
//                         //   // width: 380.w,
//                         //   height: 30.h,
//                         //   // color: Colors.amber,
//                         //   child: Row(
//                         //     children: [
//                         //       Text(
//                         //         "On Campus",
//                         //         style: TextStyle(
//                         //             color: Colors.black,
//                         //             fontSize: 22.sp.clamp(0, 22),
//                         //             fontFamily: "Poppins-Bold",
//                         //             letterSpacing: 0.15.w),
//                         //       ),
//                         //       Text(
//                         //         " Smart Find",
//                         //         style: TextStyle(
//                         //             color:
//                         //                 const Color.fromARGB(255, 0, 239, 209),
//                         //             fontSize: 22.sp.clamp(0, 22),
//                         //             fontFamily: "Poppins-Bold",
//                         //             letterSpacing: 0.15.w),
//                         //       )
//                         //     ],
//                         //   ),
//                         // ),
//                         // SizedBox(
//                         //   height: 20.h,
//                         // ),
//                         // Container(
//                         //   margin: EdgeInsets.symmetric(horizontal: 25.h),
//                         //   padding:
//                         //       EdgeInsets.only(right: 20.h, left: 20.h, top: 10.h
//                         //           // vertical : 15.h
//                         //           ),
//                         //   decoration: BoxDecoration(
//                         //     color: const Color(0xFFF5F8FF),
//                         //     borderRadius: BorderRadius.circular(16.r),
//                         //   ),
//                         //   child: Column(
//                         //     crossAxisAlignment: CrossAxisAlignment.start,
//                         //     children: [
//                         //       Container(
//                         //         // padding: EdgeInsets.only(left: 45.h),
//                         //         child: Text(
//                         //           "Get personalized hostel recommendations\nbased on your budget",
//                         //           style: TextStyle(
//                         //             color: const Color.fromARGB(255, 0, 0, 0),
//                         //             fontSize: 15.sp.clamp(0, 15),
//                         //             fontWeight: FontWeight.w500,
//                         //             fontFamily: "Poppins",
//                         //             // letterSpacing: 1.5.w,
//                         //           ),
//                         //         ),
//                         //       ),
//                         //       SizedBox(
//                         //         height: 110.h,
//                         //         // width: 330.w,
//                         //         child: Container(
//                         //           child: Row(
//                         //             children: [
//                         //               Container(
//                         //                 padding: EdgeInsets.symmetric(
//                         //                     horizontal: 10),
//                         //                 height: 35.h,
//                         //                 // width: 116.w,
//                         //                 decoration: BoxDecoration(
//                         //                   color: const Color(0xFF00EFD1),
//                         //                   borderRadius:
//                         //                       BorderRadius.circular(10.r),
//                         //                 ),
//                         //                 child: Row(
//                         //                   children: [
//                         //                     const Icon(
//                         //                       Icons.search,
//                         //                       color: Colors.white,
//                         //                     ),
//                         //                     Text(
//                         //                       "Smart Find",
//                         //                       style: TextStyle(
//                         //                           color: Colors.white,
//                         //                           fontWeight: FontWeight.bold,
//                         //                           fontSize: 14.sp.clamp(0, 14),
//                         //                           fontFamily: "Work Sans"),
//                         //                     ),
//                         //                   ],
//                         //                 ),
//                         //               ),
//                         //               SizedBox(
//                         //                 width: 5.w,
//                         //               ),
//                         //               Expanded(
//                         //                 child: Image.asset(
//                         //                     "assets/home/Undraw.png",
//                         //                     height: 108.h,
//                         //                     width: 159.w),
//                         //               ),
//                         //             ],
//                         //           ),
//                         //         ),
//                         //       ),
//                         //     ],
//                         //   ),
//                         // ),
//                         SizedBox(height: 10.h),
//                         Container(
//                           margin: EdgeInsets.symmetric(horizontal: 25.h),
//                           width: 380.w,
//                           height: 30.h,
//                           // color: Colors.amber,
//                           child: RichText(
//                             text: TextSpan(
//                               text: "Can't find the",
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 22.sp.clamp(0, 22),
//                                 fontFamily: "Poppins-Bold",
//                                 letterSpacing: 0.15.w,
//                               ),
//                               children: [
//                                 TextSpan(
//                                   text: " perfect place ?",
//                                   style: TextStyle(
//                                     color: const Color.fromARGB(
//                                       255,
//                                       0,
//                                       239,
//                                       209,
//                                     ),
//                                     fontSize: 22.sp.clamp(0, 22),
//                                     fontFamily: "Poppins-Bold",
//                                     letterSpacing: 0.15.w,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 5.h),
//                         Container(
//                           margin: EdgeInsets.symmetric(horizontal: 25.h),
//                           // padding: EdgeInsets.symmetric(horizontal: 5.h),
//                           width: 330.w,
//                           height: 256.h,
//                           child: Image.asset(
//                             "assets/home/Undraw-1.png",
//                             height: 256.h,
//                             width: 252.w,
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.symmetric(horizontal: 40.h),
//                           width: 380.w,
//                           // height: 40.h,
//                           // color: Colors.amber,
//                           child: RichText(
//                             text: TextSpan(
//                               text:
//                                   "Our specialists are here to help you discover on",
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 16.sp.clamp(0, 16),
//                                 fontWeight: FontWeight.w600,
//                                 fontFamily: "Poppins",
//                                 // letterSpacing: 1.5.w
//                               ),
//                               children: [
//                                 TextSpan(
//                                   text: " idea accomodation",
//                                   style: TextStyle(
//                                     color: const Color.fromARGB(
//                                       255,
//                                       0,
//                                       239,
//                                       209,
//                                     ),
//                                     fontSize: 16.sp.clamp(0, 16),
//                                     fontWeight: FontWeight.w600,
//                                     fontFamily: "Poppins",
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 15.h),
//                         Container(
//                           margin: EdgeInsets.only(left: 30.h, right: 35.h),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   Image.asset(
//                                     "assets/home/adviceIcon.png",
//                                     height: 22.h,
//                                     width: 22.w,
//                                   ),
//                                   Text(
//                                     "  Free Advice",
//                                     style: TextStyle(
//                                       fontSize: 16.sp.clamp(0, 16),
//                                       fontFamily: "Poppins",
//                                       fontWeight: FontWeight.w500,
//                                       letterSpacing: 0.15.w,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Image.asset(
//                                     "assets/home/Wechat.png",
//                                     height: 30.h,
//                                     width: 30.w,
//                                   ),
//                                   Text(
//                                     "  Quick Response",
//                                     style: TextStyle(
//                                       fontSize: 16.sp.clamp(0, 16),
//                                       fontFamily: "Poppins",
//                                       fontWeight: FontWeight.w500,
//                                       letterSpacing: 0.15.w,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(left: 25.h, right: 25.h),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   Image.asset(
//                                     "assets/home/customer service.png",
//                                     height: 30.h,
//                                     width: 30.w,
//                                   ),
//                                   Text(
//                                     "  24/7 support",
//                                     style: TextStyle(
//                                       fontSize: 16.sp.clamp(0, 16),
//                                       fontFamily: "Poppins",
//                                       fontWeight: FontWeight.w500,
//                                       letterSpacing: 0.15.w,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Image.asset(
//                                     "assets/home/helpIcon.png",
//                                     height: 30.h,
//                                     width: 30.w,
//                                   ),
//                                   Text(
//                                     "  Helped 2M+ students",
//                                     style: TextStyle(
//                                       fontSize: 16.sp.clamp(0, 16),
//                                       fontFamily: "Poppins",
//                                       fontWeight: FontWeight.w500,
//                                       letterSpacing: 0.15.w,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.symmetric(horizontal: 40.h),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.symmetric(horizontal: 7),
//                                 height: 35.h,
//                                 // width: 130.w,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(12.r),
//                                   border: Border.all(
//                                     width: 1.5.w,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 child: Align(
//                                   child: Row(
//                                     children: [
//                                       Image.asset(
//                                         "assets/home/whatsAppIcon.png",
//                                         height: 20.h,
//                                         width: 20.w,
//                                       ),
//                                       Text(
//                                         " whatsapp Us",
//                                         style: TextStyle(
//                                           fontFamily: "Work Sans",
//                                           fontSize: 14.sp.clamp(0, 14),
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(horizontal: 3.h),
//                                 height: 35.h,
//                                 // width: 130.w,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(12.r),
//                                   border: Border.all(
//                                     width: 1.5.w,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 child: Align(
//                                   child: Row(
//                                     children: [
//                                       Image.asset(
//                                         "assets/home/speakIcon.png",
//                                         height: 20.h,
//                                         width: 20.w,
//                                       ),
//                                       Text(
//                                         " Speak to an Expert",
//                                         style: TextStyle(
//                                           fontFamily: "Work Sans",
//                                           fontSize: 14.sp.clamp(0, 14),
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 180.h,
//                           width: MediaQuery.of(context).size.width,
//                           // color: Colors.orange
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
