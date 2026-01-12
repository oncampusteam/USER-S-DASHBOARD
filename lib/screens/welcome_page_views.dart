import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:on_campus/classes/screen_details.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_campus/screens/Welcome%20Screens/welcomeImage_6.dart';
import 'package:on_campus/screens/Welcome%20Screens/welcome_screen_1.dart';
import 'package:on_campus/screens/Welcome%20Screens/welcome_screen_2.dart';
import 'package:on_campus/screens/Welcome%20Screens/welcome_screen_3.dart';
import 'package:on_campus/screens/Welcome%20Screens/signUp%20Screens/loginPage.dart';

// import 'package:on_campus/screens/Welcome%20Screens/welcome_screen_4.dart';
int currentPage = 0;

class WelcomePageViews extends StatefulWidget {
  const WelcomePageViews({super.key});

  @override
  State<WelcomePageViews> createState() => _WelcomePageViewsState();
}

class _WelcomePageViewsState extends State<WelcomePageViews>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  final PageController pageController = PageController();

  bool tapdown = false;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
    // selectedIndex = 0;

    controller.addListener(() {
      if (controller.indexIsChanging) {
        //debugPrint("animation start");
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
    //debugPrint("Initial Value of controller.index : ${controller.index}");
    return Material(
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
                      WelcomeScreen6(),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width,

                  decoration: BoxDecoration(
                    // color: Colors.blue,
                    border: Border.all(width: 0, color: Colors.transparent),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        // Color.fromARGB(0, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0),
                        Color.fromARGB(40, 0, 0, 0),
                        Color.fromARGB(60, 0, 0, 0),
                        Color.fromARGB(80, 0, 0, 0),
                        Color.fromARGB(100, 0, 0, 0),
                        Color.fromARGB(130, 0, 0, 0),
                        Color.fromARGB(150, 0, 0, 0),
                        Color.fromARGB(170, 0, 0, 0),
                        Color.fromARGB(180, 0, 0, 0),
                        Color.fromARGB(190, 0, 0, 0),
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(210, 0, 0, 0),
                        Color.fromARGB(220, 0, 0, 0),
                        Color.fromARGB(230, 0, 0, 0),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: Container(
                  margin: EdgeInsets.only(
                    top: ScreenDetails.ScreenHeight * 0.065,
                  ),
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
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.07,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      //debugPrint("${controller.index}");

                      if (controller.index <= 3) {
                        if (controller.index == 3) {
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(builder: (context) {
                          //   return const Loginpage();
                          // }));
                          Get.to(
                            () => const LoginPage(index: 0),
                            transition: Transition.fadeIn,
                            curve: Curves.easeIn,
                            duration: const Duration(milliseconds: 600),
                          );
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
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                          color: Color(0xFF00EFD1),
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Align(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                            child: FittedBox(
                              child: Text(
                                "Start Exploring",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  // fontSize: ScreenDetails.ScreenHeight * 0.0250,
                                  fontSize: 16.sp.clamp(0, 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Positioned(
              //   bottom: ScreenDetails.ScreenHeight * 0.06,
              //   child: GestureDetector(
              //     onTap: () {
              //       setState(() {
              //         debug//debugPrint("${controller.index}");

              //         if (controller.index <= 3) {
              //           if (controller.index == 3) {
              //             // Navigator.of(context)
              //             //     .push(MaterialPageRoute(builder: (context) {
              //             //   return const Loginpage();
              //             // }));
              //             Get.to(
              //               () => const LoginPage(index: 0),
              //               transition: Transition.fadeIn,
              //               curve: Curves.easeIn,
              //               duration: const Duration(milliseconds: 600),
              //             );
              //             return;
              //           }
              //           controller.index++;
              //         }

              //         pageController.animateToPage(
              //           controller.index,
              //           duration: const Duration(milliseconds: 300),
              //           curve: Curves.easeInOut,
              //         );
              //       });
              //     },
              //     child: SizedBox(
              //       width: ScreenDetails.ScreenWidth * 0.8,
              //       child: FittedBox(
              //         child: Container(
              //           // decoration:
              //           //     BoxDecoration(borderRadius: BorderRadius.circular(1)),

              //           height: ScreenDetails.ScreenHeight * 0.05332,
              //           width: ScreenDetails.ScreenWidth,
              //           foregroundDecoration: BoxDecoration(
              //             color: tapdown ? Colors.black.withOpacity(0.5) : null,
              //           ),
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(15.r),
              //             color: const Color.fromARGB(255, 0, 239, 209),
              //           ),
              //           child: Align(
              //             child: SizedBox(
              //               height: MediaQuery.of(context).size.height * 0.03,
              //               child: FittedBox(
              //                 child: Text(
              //                   "Start Exploring",
              //                   style: TextStyle(
              //                     fontFamily: "Poppins",
              //                     color: Colors.white,
              //                     fontWeight: FontWeight.w600,
              //                     // fontSize: ScreenDetails.ScreenHeight * 0.0250,
              //                     fontSize: 16.sp.clamp(0, 16),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.135,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomeLoginPageController extends StatefulWidget {
  const WelcomeLoginPageController({super.key});

  @override
  State<WelcomeLoginPageController> createState() =>
      _WelcomeLoginPageControllerState();
}

class _WelcomeLoginPageControllerState
    extends State<WelcomeLoginPageController> {
  final PageController pageController = PageController();
  int welcomeLoginPage = 0;

  @override
  void initState() {
    super.initState();
    // controller = TabController(length: 4, vsync: this);
    // selectedIndex = 0;

    pageController.addListener(() {
      if (currentPage == 3) {
        pageController.animateToPage(
          welcomeLoginPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      onPageChanged: (int page) {
        // if (currentPage == 3) {
        //debugPrint("currentPage = 3");
        setState(() {
          welcomeLoginPage = page;
          // controller.animateTo(page);
        });
        // }
      },
      children: [
        WelcomePageViews(),
        // Placeholder(),
        LoginPage(index: 0),
      ],
    );
  }
}
