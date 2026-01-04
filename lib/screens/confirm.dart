// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:on_campus/screens/Home%20Page%20Views/home.dart';

// class Confirm extends StatefulWidget {
//   final String username;
//   const Confirm({super.key, required this.username});

//   @override
//   State<Confirm> createState() => _ConfirmState();
// }

// class _ConfirmState extends State<Confirm> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
//           color: Colors.white,
//           child: Stack(
//             children: [
//               Positioned(
//                 top: MediaQuery.of(context).size.height * 0.2,
//                 right: 0.h,
//                 left: 0.h,
//                 child: Column(
//                   children: [
//                     Image.asset(
//                       "assets/confirm/check_circle.png",
//                       height: 200.h,
//                       width: 200.w,
//                     ),
//                     SizedBox(height: 10.h),
//                     Text(
//                       "Congrats!",
//                       style: TextStyle(
//                         fontFamily: "Noto Serif",
//                         fontWeight: FontWeight.bold,
//                         fontSize: 55.sp,
//                         color: const Color(0xFF00EFD1),
//                       ),
//                     ),
//                     Text(
//                       "Account Registered",
//                       style: TextStyle(
//                         fontFamily: "Poppins",
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16.sp,
//                       ),
//                     ),
//                     Text(
//                       "Successfully",
//                       style: TextStyle(
//                         fontFamily: "Poppins",
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16.sp,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               Positioned(
//                 bottom: 0.h,
//                 right: 0.h,
//                 left: 0.h,
//                 child: SizedBox(
//                   height: 50.h,
//                   width: double.infinity,
//                   child: FilledButton(
//                     style: ButtonStyle(
//                       shape: WidgetStatePropertyAll(
//                         RoundedRectangleBorder(
//                           // side: const BorderSide(color: Color(0xFF00EFD1), width: 1),
//                           borderRadius: BorderRadius.all(Radius.circular(20.r)),
//                         ),
//                       ),
//                       backgroundColor: const WidgetStatePropertyAll(
//                         Color(0xFF00EFD1),
//                       ),
//                     ),
//                     onPressed: () {
//                       Navigator.pop(context);
//                       Get.to(
//                         () => Home(),
//                         transition: Transition.fadeIn,
//                         duration: const Duration(milliseconds: 800),
//                         curve: Curves.easeIn,
//                       );
//                       // _receit = false;
//                     },
//                     child: Text(
//                       "Next",
//                       style: TextStyle(
//                         fontFamily: "Inter",
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 25.sp,
//                       ),
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
