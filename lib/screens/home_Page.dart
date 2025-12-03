// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:on_campus/screens/Home%20Page%20Views/apartment.dart';
// import 'package:on_campus/screens/Home%20Page%20Views/apartment_history.dart';
// import 'package:on_campus/screens/Home%20Page%20Views/compare.dart';
// import 'package:on_campus/screens/Home%20Page%20Views/home.dart';
// import 'package:on_campus/screens/Home%20Page%20Views/profile.dart';
// import 'package:on_campus/temps/temp1.dart';

// class Homepage extends StatefulWidget {
//   final String username;
//   const Homepage({super.key, required this.username});

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   @override
//   void initState() {
//     super.initState();
//     selectedIndex = 4;
//   }

//   int selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       // backgroundColor:  const Color(0xFFF5F5F5),
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Stack(
//           children: [
//             // Positioned(
//             //     top: 0,
//             //     left: 0,
//             //     right: 0,
//             //     bottom: 0.h,
//             //     child: Container(
//             //       // color: Colors.green,
//             //       // child: Container(),
//             //       child: IndexedStack(
//             //         index: selectedIndex,
//             //         children: [
//             //           const Apartment(),
//             //           ApartmentHistory(),
//             //           const Compare(),
//             //           Profile(username: widget.username),
//             //           Home(username: widget.username),
//             //         ],
//             //       ),
//             //     )),
//             Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: SizedBox(
//                   // color: Colors.white,
//                   // color: Colors.blue,
//                   height: 45.h,
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         //// left container///////////////////////////////////////////////////////////////////////////
//                         Container(
//                             decoration: BoxDecoration(
//                                 color: const Color.fromARGB(255, 0, 239, 209),
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(12.r),
//                                     topRight: Radius.circular(37.r))),
//                             height: 45.h,
//                             width: 170.w,
//                             child: SizedBox(
//                                 height: 45.h,
//                                 child: Row(
//                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(
//                                       // color: Colors.red,
//                                       width: 85.w,
//                                       child: Column(
//                                         children: [
//                                           selectedIndex == 0
//                                               ? GestureDetector(
//                                                   onTap: () {
//                                                     setState(() {
//                                                       selectedIndex = 0;
//                                                       Get.to(
//                                                         () => const Apartment(),
//                                                         transition:
//                                                             Transition.fade,
//                                                         curve:
//                                                             Curves.easeIn,
//                                                         duration:
//                                                             const Duration(
//                                                                 milliseconds:
//                                                                     600),
//                                                       );
//                                                     });
//                                                   },
//                                                   child: Container(
//                                                     // color: Colors.red,
//                                                     // padding: EdgeInsets.only(left: 10.h),
//                                                     child: ColorFiltered(
//                                                       colorFilter:
//                                                           const ColorFilter
//                                                               .mode(
//                                                         Color.fromARGB(
//                                                             255,
//                                                             0,
//                                                             183,
//                                                             185), // The color you want to apply
//                                                         BlendMode
//                                                             .modulate, // The blend mode
//                                                       ),
//                                                       child: Image.asset(
//                                                         "assets/my apartment.png",
//                                                         height: 45.h,
//                                                         width: 100.w,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )
//                                               : GestureDetector(
//                                                   onTap: () {
//                                                     setState(() {
//                                                       selectedIndex = 0;
//                                                       Get.to(
//                                                         () => const Apartment(),
//                                                         transition:
//                                                             Transition.fade,
//                                                         curve:
//                                                             Curves.easeIn,
//                                                         duration:
//                                                             const Duration(
//                                                                 milliseconds:
//                                                                     600),
//                                                       );
//                                                     });
//                                                   },
//                                                   child: Image.asset(
//                                                     "assets/my apartment.png",
//                                                     height: 45.h,
//                                                     width: 100.w,
//                                                   ),
//                                                 ),
//                                           // Text("My Apartment")
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5.w,
//                                     ),
//                                     selectedIndex == 1
//                                         ? GestureDetector(
//                                             onTap: () {
//                                               setState(() {
//                                                 selectedIndex = 1;
//                                                 Get.to(
//                                                   () =>
//                                                       const ApartmentHistory(),
//                                                   transition:
//                                                       Transition.circularReveal,
//                                                   curve: Curves.easeIn,
//                                                   duration: const Duration(
//                                                       milliseconds: 600),
//                                                 );
//                                               });
//                                             },
//                                             child: ColorFiltered(
//                                               colorFilter:
//                                                   const ColorFilter.mode(
//                                                 Color.fromARGB(255, 0, 183,
//                                                     185), // The color you want to apply
//                                                 BlendMode
//                                                     .modulate, // The blend mode
//                                               ),
//                                               child: SizedBox(
//                                                 // color: Colors.blue,
//                                                 width: 75.w,
//                                                 child: Column(
//                                                   children: [
//                                                     Image.asset(
//                                                       "assets/payment.png",
//                                                       height: 40.h,
//                                                       width: 65.w,
//                                                     ),
//                                                     // Text("Payment")
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           )
//                                         : GestureDetector(
//                                             onTap: () {
//                                               setState(() {
//                                                 selectedIndex = 1;
//                                                 Get.to(
//                                                   () =>
//                                                       const ApartmentHistory(),
//                                                   transition: Transition.fadeIn,
//                                                   curve: Curves.easeIn,
//                                                   duration: const Duration(
//                                                       milliseconds: 600),
//                                                 );
//                                               });
//                                             },
//                                             child: Image.asset(
//                                               "assets/payment.png",
//                                               height: 40.h,
//                                               width: 65.w,
//                                             ),
//                                           ),
//                                   ],
//                                 ))),
//                         ////////////right container
//                         Container(
//                             decoration: BoxDecoration(
//                                 color: const Color.fromARGB(255, 0, 239, 209),
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(37.r),
//                                     topRight: Radius.circular(12.r))),
//                             height: 45.h,
//                             width: 170.w,
//                             child: SizedBox(
//                                 height: 45.h,
//                                 child: Row(
//                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     selectedIndex == 2
//                                         ? GestureDetector(
//                                             onTap: () {
//                                               setState(() {
//                                                 selectedIndex = 2;
//                                                 Get.to(
//                                                   () => const Compare(),
//                                                   transition:
//                                                       Transition.upToDown,
//                                                   curve: Curves.easeIn,
//                                                   duration: const Duration(
//                                                       milliseconds: 600),
//                                                 );
//                                               });
//                                             },
//                                             child: ColorFiltered(
//                                               colorFilter:
//                                                   const ColorFilter.mode(
//                                                 Color.fromARGB(255, 0, 183,
//                                                     185), // The color you want to apply
//                                                 BlendMode
//                                                     .modulate, // The blend mode
//                                               ),
//                                               child: Container(
//                                                 margin:
//                                                     EdgeInsets.only(left: 10.h),
//                                                 // color: Colors.red,
//                                                 width: 70.w,
//                                                 child: Column(
//                                                   children: [
//                                                     Image.asset(
//                                                       "assets/compare.png",
//                                                       height: 40.h,
//                                                       width: 65.w,
//                                                     ),
//                                                     // Text("My Apartment")
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           )
//                                         : GestureDetector(
//                                             onTap: () {
//                                               setState(() {
//                                                 selectedIndex = 2;
//                                                 Get.to(
//                                                   () => const Compare(),
//                                                   transition:
//                                                       Transition.upToDown,
//                                                   curve: Curves.easeIn,
//                                                   duration: const Duration(
//                                                       milliseconds: 600),
//                                                 );
//                                               });
//                                             },
//                                             child: Container(
//                                               margin:
//                                                   EdgeInsets.only(left: 10.h),
//                                               child: Image.asset(
//                                                 "assets/compare.png",
//                                                 height: 40.h,
//                                                 width: 65.w,
//                                               ),
//                                             ),
//                                           ),
//                                     SizedBox(
//                                       width: 10.w,
//                                     ),
//                                     selectedIndex == 3
//                                         ? GestureDetector(
//                                             onTap: () {
//                                               setState(() {
//                                                 selectedIndex = 3;
//                                                 Get.to(
//                                                   () => const Compare(),
//                                                   transition:
//                                                       Transition.downToUp,
//                                                   curve: Curves.easeIn,
//                                                   duration: const Duration(
//                                                       milliseconds: 600),
//                                                 );
//                                               });
//                                             },
//                                             child: ColorFiltered(
//                                               colorFilter:
//                                                   const ColorFilter.mode(
//                                                 Color.fromARGB(255, 0, 183,
//                                                     185), // The color you want to apply
//                                                 BlendMode
//                                                     .modulate, // The blend mode
//                                               ),
//                                               child: SizedBox(
//                                                 // margin:
//                                                 //   EdgeInsets.only(left: 10.h),
//                                                 // color: Colors.blue,
//                                                 width: 70.w,
//                                                 child: Column(
//                                                   children: [
//                                                     Image.asset(
//                                                       "assets/profile.png",
//                                                       height: 40.h,
//                                                       width: 65.w,
//                                                     ),
//                                                     // Text("Payment")
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           )
//                                         : GestureDetector(
//                                             onTap: () {
//                                               setState(() {
//                                                 selectedIndex = 3;
//                                                 Get.to(
//                                                   () => const Compare(),
//                                                   transition:
//                                                       Transition.downToUp,
//                                                   curve: Curves.easeIn,
//                                                   duration: const Duration(
//                                                       milliseconds: 600),
//                                                 );
//                                               });
//                                             },
//                                             child: Image.asset(
//                                               "assets/profile.png",
//                                               height: 40.h,
//                                               width: 65.w,
//                                             ),
//                                           ),
//                                   ],
//                                 )))
//                       ]),
//                 )),
//             Positioned(
//                 bottom: 0.h,
//                 left: 160.w,
//                 right: 160.w,
//                 child: ClipPath(
//                   clipper: Clipper(),
//                   child: Container(
//                     height: 65.h,
//                     // width: 10.w,
//                     decoration: const BoxDecoration(
//                       // color: Colors.blue,
//                       color: Color.fromARGB(255, 0, 239, 209),
//                     ),
//                   ),
//                 )),
//             // Positioned(
//             //     bottom: 35.h,
//             //     left: 160.w,
//             //     right: 160.w,
//             //     child: Container(
//             //       height: 55.h,
//             //       decoration: const BoxDecoration(
//             //         shape: BoxShape.circle,
//             //         color: Colors.white,
//             //       ),
//             //     )),
//             Positioned(
//                 bottom: 25.h,
//                 left: 160.w,
//                 right: 160.w,
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedIndex = 4;
//                       Get.to(
//                         () => const Home(username: "Godfred",),
//                         transition: Transition.fadeIn,
//                         curve: Curves.easeIn,
//                         duration: const Duration(milliseconds: 600),
//                       );
//                     });
//                     // Navigator.push(context,
//                     //     MaterialPageRoute(builder: (context) {
//                     //   return Home();
//                     // }));
//                   },
//                   child: Container(
//                       height: 55.h,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(
//                             width: 1.w,
//                             color: const Color.fromARGB(20, 0, 0, 0)),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Container(
//                           padding: EdgeInsets.all(10.h),
//                           child: Image.asset(
//                             "assets/HomeIcon.png",
//                           ))),
//                 )),
//           ],
//         ),
//       ),
//     ));
//   }
// }
