import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_campus/classes/screen_details.dart';
import 'package:on_campus/screens/Welcome%20Screens/signUp%20Screens/loginPage.dart';
import 'package:on_campus/screens/Welcome%20Screens/welcomeImage_6.dart';
import 'package:on_campus/screens/Welcome%20Screens/welcome_screen_1.dart';
import 'package:on_campus/screens/Welcome%20Screens/welcome_screen_2.dart';
import 'package:on_campus/screens/Welcome%20Screens/welcome_screen_3.dart';
// import 'package:on_campus/screens/Welcome%20Screens/welcome_screen_4.dart';

class WelcomePageViews extends StatefulWidget {
  const WelcomePageViews({super.key});

  @override
  State<WelcomePageViews> createState() => _WelcomePageViewsState();
}

class _WelcomePageViewsState extends State<WelcomePageViews>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  final PageController pageController = PageController();
  int currentPage = 0;

  bool tapdown = false;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
    // selectedIndex = 0;

    controller.addListener(() {
      if (controller.indexIsChanging) {
        pageController.animateToPage(
          controller.index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  int selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    // controller.index = selectedIndex;
    debugPrint("Initial Value of controller.index : ${controller.index}");
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          currentPage = page;
                          controller.animateTo(page);
                        });
                      },
                      children: const [
                        WelcomeScreen1(),
                        WelcomeScreen2(),
                        WelcomeScreen3(),
                        WelcomeScreen6()
                      ],
                    ),
                  )),
              Positioned(
                  bottom: 0,
                  child: Container(
                    height: 150.h,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.blue,
                    decoration: BoxDecoration(
                        border: Border.all(width: 0, color: Colors.transparent),
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(0, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0),
                              Color.fromARGB(40, 0, 0, 0),
                              Color.fromARGB(60, 0, 0, 0),
                              Color.fromARGB(80, 0, 0, 0),
                              Color.fromARGB(120, 0, 0, 0),
                              Color.fromARGB(140, 0, 0, 0),
                              Color.fromARGB(160, 0, 0, 0),
                              Color.fromARGB(180, 0, 0, 0),
                              Color.fromARGB(200, 0, 0, 0),
                            ])),
                  )),
              Positioned(
                  top: 0,
                  child: Container(
                    margin: EdgeInsets.only(top: 25.h),
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        "assets/welcome_page_views/transparent_logo-removebg.png",
                        fit: BoxFit.cover,
                        height: 50.h,
                        width: 120.h,
                      ),
                    ),
                  )),
              Positioned(
                  bottom: ScreenDetails.ScreenHeight * 0.0119,
                  child: GestureDetector(
                    onLongPress: () {
                      setState(() {
                        debugPrint("Long Press");
                        tapdown = false;
                      });
                    },
                    onTap: () {
                      setState(() {
                        debugPrint("${controller.index}");

                        if (controller.index <= 3) {
                          if (controller.index == 3) {
                            // Navigator.of(context)
                            //     .push(MaterialPageRoute(builder: (context) {
                            //   return const Loginpage();
                            // }));
                            Get.to(() => const LoginPage(index: 0),
                                transition: Transition.fadeIn,
                                curve: Curves.easeIn,
                                duration: const Duration(milliseconds: 600));
                            return;
                          }
                          controller.index++;
                        }

                        pageController.animateToPage(
                          controller.index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
                    onTapDown: (details) {
                      setState(() {
                        setState(() {
                          debugPrint("Tapdown is executed");
                          tapdown = true;
                        });
                      });
                    },
                    onTapUp: (details) {
                      setState(() {
                        setState(() {
                          debugPrint("Tapup is executed");
                          tapdown = false;
                        });
                      });
                    },
                    child: Container(
                      // decoration:
                      //     BoxDecoration(borderRadius: BorderRadius.circular(1)),
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenDetails.ScreenHeight * 0.02540),
                      height: ScreenDetails.ScreenHeight * 0.05332,
                      width: 350.w,
                      foregroundDecoration: BoxDecoration(
                          color:
                              tapdown ? Colors.black.withOpacity(0.5) : null),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: const Color.fromARGB(255, 0, 239, 209)),
                      child: SizedBox(
                        height: 16.h,
                        child: Align(
                          child: Text("Start Exploring",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                // fontSize: ScreenDetails.ScreenHeight * 0.0250,
                                fontSize: 16.sp.clamp(0, 16),
                              )),
                        ),
                      ),
                    ),
                  )),
              Positioned(
                  bottom: ScreenDetails.ScreenHeight * 0.08,
                  child: SizedBox(
                    height: ScreenDetails.ScreenHeight * 0.0350,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      // color: Colors.yellow,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: TabPageSelector(
                          indicatorSize: ScreenDetails.ScreenHeight * 0.0119,
                          borderStyle: BorderStyle.none,
                          controller: controller,
                          color: const Color.fromARGB(200, 117, 112, 112),
                          selectedColor: Colors.white,
                        ),
                      ),
                    ),
                  )),
              // Positioned(
              //     top: 0,
              //     right: 5.h,
              //     child: TextButton(
              //       onPressed: null,
              //       child: Text(
              //         "Skip",
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 18.sp.clamp(0,16),
              //             fontWeight: FontWeight.w600),
              //       ),
              //     ))
            ],
          )),
    ));
  }
}
