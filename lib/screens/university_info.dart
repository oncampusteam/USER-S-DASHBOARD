import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_campus/screens/guardian_info.dart';

class UniversityInfo extends StatefulWidget {
  final String username;
  const UniversityInfo({super.key, required this.username});

  @override
  State<UniversityInfo> createState() => _UniversityInfoState();
}

class _UniversityInfoState extends State<UniversityInfo> {
  TextEditingController school = TextEditingController();
  TextEditingController course = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40.h,
            width: 40.w,
            foregroundDecoration: BoxDecoration(
                color: Colors.black.withOpacity(0.03),
                borderRadius: BorderRadius.circular(8.r)),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r)),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.chevron_left, color: Colors.black, size: 24.w),
            ),
          ),
          Align(
              child: Image.asset("assets/university_info/user logo.png",
                  height: 110.h, width: 100.w)),
          Align(
            child: Text(widget.username,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Poppins-Bold",
                    fontSize: 22.sp,
                    letterSpacing: 0.15.w,
                    color: const Color(0xFF323232))),
          ),
          SizedBox(height: 5.h),
          Align(
            child: Text("Registration",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: const Color(0xFF323232)
                    // letterSpacing: 0.15.w,
                    )),
          ),
          SizedBox(height: 10.h),
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 24.h,
                    width: 24.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // color: Color(0xFFDADADA),
                        border: Border.all(color: const Color(0xFF00EFD1))),
                    child: Align(
                      child: Text(
                        "1",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF7A7A7A)),
                      ),
                    )),
                Container(
                  height: 1.h,
                  width: 75.w,
                  color: const Color(0xFFDADADA),
                  // color:const Color(0xFF7A7A7A) ,
                ),
                //// 2 ////
                Container(
                    height: 24.h,
                    width: 24.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF00EFD1))
                        // color: Color(0xFFDADADA),
                        // border: Border.all(color: const Color(0xFF00EFD1))
                        ),
                    child: Align(
                      child: Text(
                        "2",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF7A7A7A)),
                      ),
                    )),
                Container(
                  height: 1.h,
                  width: 75.w,
                  color: const Color(0xFFDADADA),
                ),

                /// 3 ////
                Container(
                    height: 24.h,
                    width: 24.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFDADADA),
                      // border: Border.all(color: const Color(0xFF00EFD1))
                    ),
                    child: Align(
                      child: Text(
                        "3",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF7A7A7A)),
                      ),
                    )),
                Container(
                  height: 1.h,
                  width: 75.w,
                  color: const Color(0xFFDADADA),
                ),

                //// 4 /////

                Container(
                    height: 24.h,
                    width: 24.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFDADADA),
                      // border: Border.all(color: const Color(0xFF00EFD1))
                    ),
                    child: Align(
                      child: Text(
                        "4",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF7A7A7A)),
                      ),
                    )),
                // Container(
                //   height: 1.h,
                //   width: 15.w,
                //   color:const Color(0xFF7A7A7A) ,
                //   )
              ],
            ),
          ),
          Container(
            // margin: EdgeInsets.only(left: 7.h),
            child: Row(
              children: [
                Text("Personal Info",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF323232))),
                const SizedBox(
                  width: 50,
                ),
                Text("University Info",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF323232))),
                const SizedBox(
                  width: 50,
                ),
                Text("Guardian Info",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF323232))),
                const SizedBox(
                  width: 57,
                ),
                Text("Confirm",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF323232)))
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text("School*",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.65))),
          SizedBox(
            height: 5.h,
          ),
          TextField(
            controller: school,
            decoration: InputDecoration(
              fillColor: Colors.white,
              hintText: "Type Here",
              hintStyle: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.bold,
                color: const Color(0xFFB7B7B7),
                fontSize: 20.sp,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(color: Color(0xFFBBBBBB))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(color: Color(0xFFB7B7B7))),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text("Year of Study*",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.65))),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 5.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("First Year",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: const Color(0xFF323232),
                              fontWeight: FontWeight.w500,
                              fontSize: 21.sp,
                              letterSpacing: 1.15.w,
                            )),
                    Image.asset("assets/university_info/Component 10.png", height: 18.h, width: 18.w,)
                          ],),
                /////////////
                SizedBox(height: 5.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Second Year",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: const Color(0xFF323232),
                              fontWeight: FontWeight.w500,
                              fontSize: 21.sp,
                              letterSpacing: 1.15.w,
                            )),
                    Image.asset("assets/university_info/Component 10.png", height: 18.h, width: 18.w,)
                          ],),
                ////////////////
                SizedBox(height: 5.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Third Year",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: const Color(0xFF323232),
                              fontWeight: FontWeight.w500,
                              fontSize: 21.sp,
                              letterSpacing: 1.15.w,
                            )),
                    Image.asset("assets/university_info/Component 10.png", height: 18.h, width: 18.w,)
                          ],),
              ///////////
                SizedBox(height: 5.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Fourth Year",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: const Color(0xFF323232),
                              fontWeight: FontWeight.w500,
                              fontSize: 21.sp,
                              letterSpacing: 1.15.w,
                            )),
                    Image.asset("assets/university_info/Component 10.png", height: 18.h, width: 18.w,)
                          ],),
                /////////////
                SizedBox(height: 5.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Post Graduate",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: const Color(0xFF323232),
                              fontWeight: FontWeight.w500,
                              fontSize: 21.sp,
                              letterSpacing: 1.15.w,
                            )),
                    Image.asset("assets/university_info/Component 10.png", height: 18.h, width: 18.w,)
                          ],),
                /////////
                SizedBox(height: 5.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Internship",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: const Color(0xFF323232),
                              fontWeight: FontWeight.w500,
                              fontSize: 21.sp,
                              letterSpacing: 1.15.w,
                            )),
                    Image.asset("assets/university_info/Component 10.png", height: 18.h, width: 18.w,)
                          ],),
                ////////
                SizedBox(height: 5.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Exchange Program",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: const Color(0xFF323232),
                              fontWeight: FontWeight.w500,
                              fontSize: 21.sp,
                              letterSpacing: 1.15.w,
                            )),
                    Image.asset("assets/university_info/Component 10.png", height: 18.h, width: 18.w,)
                          ],),
                ///////////////
                SizedBox(height: 5.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("other",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: const Color(0xFF323232),
                              fontWeight: FontWeight.w500,
                              fontSize: 21.sp,
                              letterSpacing: 1.15.w,
                            )),
                    Image.asset("assets/university_info/Component 10.png", height: 18.h, width: 18.w,)
                          ],),
                SizedBox(height: 5.h,)
              ],
            ),),
          Text("Course of Study*",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.65))),
          SizedBox(
            height: 5.h,
          ),
          TextField(
            controller: course,
            decoration: InputDecoration(
              fillColor: Colors.white,
              hintText: "Type Here",
              hintStyle: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.bold,
                color: const Color(0xFFB7B7B7),
                fontSize: 20.sp,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(color: Color(0xFFBBBBBB))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(color: Color(0xFFB7B7B7))),
            ),
          ),
          SizedBox(height: 10.h,),
                      SizedBox(
                        height: 50.h,
                        width: double.infinity,
                        child: FilledButton(
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            // side: const BorderSide(color: Color(0xFF00EFD1), width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r)))),
                        backgroundColor:
                            const WidgetStatePropertyAll(Color(0xFF00EFD1))),
                    onPressed: () {
                      Navigator.pop(context);
                      Get.to(() => GuardianInfo(username: widget.username),
                          transition: Transition.fadeIn,
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeIn);
                      // _receit = false;
                    },
                    child: Text("Next",
                        style: TextStyle(
                          fontFamily: "Inter",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp,
                        )),
                  ),
                      ),
        ],
      ),
    ))));
  }
}
