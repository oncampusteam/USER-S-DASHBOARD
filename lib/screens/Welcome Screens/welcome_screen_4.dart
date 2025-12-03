import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_campus/screens/Welcome%20Screens/welcome_screen_5.dart';

class WelcomeScreen4 extends StatefulWidget {
  const WelcomeScreen4({super.key});

  @override
  State<WelcomeScreen4> createState() => _WelcomeScreen4State();
}

// List<String> name = [];

class _WelcomeScreen4State extends State<WelcomeScreen4> {
  TextEditingController nameTextEditingController = TextEditingController();

  bool userNameEmpty = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
          child: SizedBox(
        child: Stack(
          children: [
            Positioned(
                top: 0,
                child: Image.asset(
                  "assets/welcome_screen_4/welcomeImage4.jpg",
                  fit: BoxFit.cover,
                  height: 700.h,
                  width: MediaQuery.of(context).size.width,
                )),
            Positioned(
                top: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        // Color.fromARGB(0, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0),
                        Color.fromARGB(80, 0, 0, 0),
                        // Color.fromARGB(60, 0, 0, 0),
                        // Color.fromARGB(80, 0, 0, 0),
                        // Color.fromARGB(120, 0, 0, 0),
                        // Color.fromARGB(140, 0, 0, 0),
                        // Color.fromARGB(160, 0, 0, 0),
                        // Color.fromARGB(180, 0, 0, 0),
                        // Color.fromARGB(200, 0, 0, 0),
                      ])),
                  // color: Colors.green,

                  // child:
                )),
            Positioned(
                top: 0,
                child: Container(
                  margin: EdgeInsets.only(top: 25.h),
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/welcome_screen_4/transparent_logo-removebg.png",
                      fit: BoxFit.cover,
                      height: 50.h,
                      width: 120.h,
                    ),
                  ),
                )),
            Positioned(
                top: 160.h,
                left: 0,
                child: Container(
                  margin: EdgeInsets.only(left: 10.h),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10.h),
                        child: Text("Name",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.sp.clamp(0, 30),
                              fontFamily: "Poppins-Bold",
                              // fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none,
                            )),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.h),
                        padding: EdgeInsets.only(left: 15.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.r),
                          ),
                          border: Border.all(
                              width: 2.w,
                              color: const Color.fromARGB(255, 255, 255, 255)),
                        ),
                        width: 340.w,
                        child: TextField(
                          cursorColor: Colors.black,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 25.sp.clamp(0, 25),
                          ),
                          textCapitalization: TextCapitalization.words,
                          controller: nameTextEditingController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              // fillColor: Colors.white,
                              hintText: userNameEmpty
                                  ? "Please Provide Entry"
                                  : "Type Here",
                              hintStyle: TextStyle(
                                fontFamily: "Inter",
                                color: Colors.grey[400],
                                fontWeight: FontWeight.bold,
                                fontSize: 25.sp.clamp(0, 25),
                              )),
                        ),
                      )
                    ],
                  ),
                )),
            Positioned(
              left: 10.h,
              right: 10.h,
              bottom: 10.h,
              child: GestureDetector(
                onTap: () {
                  if (nameTextEditingController.text.isEmpty) {
                    setState(() {
                      userNameEmpty = true;  
                    });
                    return;
                  }
                      Get.to(
                        () => WelcomeScreen5(username: nameTextEditingController.text,),
                        transition: Transition.fadeIn,
                        curve: Curves.easeIn,
                        duration: const Duration(milliseconds: 600)
                        );
                },
                child: Container(
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 239, 209),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.r),
                      ),
                    ),
                    // padding: EdgeInsets.only(left: 10.w),
                    width: 330.w,
                    child: Align(
                        child: Text("Submit",
                            style: TextStyle(
                              fontSize: 18.sp.clamp(0, 18),
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),),),),
              ),
            )
          ],
        ),
      )),
    ));
  }
}
