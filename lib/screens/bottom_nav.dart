import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:on_campus/widgets/custompainter.dart';
import 'package:on_campus/classes/network_service.dart';
import 'package:on_campus/widgets/hostel_categories.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_campus/screens/empty_states/empty_state.dart';
import 'package:on_campus/screens/Home%20Page%20Views/home.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:on_campus/screens/Home%20Page%20Views/profile.dart';
import 'package:on_campus/screens/Home%20Page%20Views/apartment.dart';
import 'package:on_campus/screens/Home%20Page%20Views/coming_soon.dart';

class BottomNav extends StatefulWidget {
  final String username;
  final int? subindex;
  const BottomNav({super.key, required this.username, this.subindex});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

int currentpage = 2;
String hostelCategory = "";
final ValueNotifier<int> currentPage = ValueNotifier<int>(2);

class _BottomNavState extends State<BottomNav> {
  // List<Widget> getPages() {
  //   return [
  //     Apartment(),
  //     const ComingSoon(),
  //     Home(username: widget.username),
  //     const ComingSoon(),
  //     Profile(),
  //   ];
  // }

  // void navigateBottomBar(int index) {
  //   setState(() {
  //     currentpage = index;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    currentPage.addListener(() {
      //debugPrint("It's changed");
     
    });
    currentpage = widget.subindex ?? 2;
  }

  final networkService = NetworkService();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: StreamBuilder<bool>(
          stream: networkService.connectionStream,
          builder: (context, snapshot) {
            final connected = snapshot.data ?? true;
            if (!connected) {
              return EmptyState(
                title: "No Connection",
                content: "Oops! It seems you're currently offline.",
                imagePath: "assets/empty_state/no_internet.png",
                buttonText: "Retry",
                buttonTap: ()async{
                  bool connected = await networkService.checkNow();
                  setState(() {
                    if(!connected){
                      Get.snackbar("No Internet", "Check your connection",
                      snackPosition: SnackPosition.BOTTOM);
                    }
                    // if(connected){
                    //   setState(() {
                        
                    //   });
                    // }
                  });
                },
              );
            }
            return Stack(
              children: [
                Positioned(
                  child: IndexedStack(
                    index: currentpage,
                    children: [
                      Apartment(),
                      const ComingSoon(),
                      Home(username: widget.username),
                      const ComingSoon(),
                      Profile(),
                      HostelCategory(categoryType: hostelCategory),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CustomBottomNavBar(height: Constant.height * 0.06),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: Constant.height * 0.06,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Constant.width * 0.48,
                          padding: EdgeInsets.symmetric(
                            vertical: Constant.height * 0.005,
                          ),

                          // color: const Color.fromRGBO(244, 67, 54, 0.7),
                          child: SizedBox(
                            // color: Colors.yellow,
                            width: (Constant.width * 0.48) * 0.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentpage = 0;
                                    });
                                  },
                                  child: SizedBox(
                                    width: Constant.width * 0.48 * 0.5,
                                    // color: Colors.blue,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          height:
                                              (Constant.height * 0.06) * 0.47,
                                          width: Constant.width * 0.48 * 0.5,
                                          // width: ((Constant.width * 0.48) * 0.48)* 0.5,
                                          child: FittedBox(
                                            child: Image.asset(
                                              "assets/home/apartment.png",
                                              color: currentpage == 0
                                                  ? Color(0xFF35AD9E)
                                                  : null,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          // color: Colors.red,
                                          height:
                                              (Constant.height * 0.06) * 0.35,
                                          width: Constant.width * 0.48 * 0.5,
                                          // width: ((Constant.width * 0.48) * 0.48)* 0.5,
                                          child: FittedBox(
                                            child: Text(
                                              "My Apartment",
                                              style: TextStyle(
                                                color: currentpage == 0
                                                    ? Color(0xFF35AD9E)
                                                    : Colors.white,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentpage = 1;
                                    });
                                  },
                                  child: SizedBox(
                                    width: Constant.width * 0.48 * 0.5,
                                    // color: Colors.green,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height:
                                              (Constant.height * 0.06) * 0.43,
                                          // width: ((Constant.width * 0.48) * 0.48)* 0.5,
                                          child: FittedBox(
                                            child: Image.asset(
                                              "assets/home/connect.png",
                                              color: currentpage == 1
                                                  ? Color(0xFF35AD9E)
                                                  : null,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              (Constant.height * 0.06) * 0.4,
                                          // width: ((Constant.width * 0.48) * 0.48)* 0.5,
                                          child: FittedBox(
                                            child: Text(
                                              "Connect+",
                                              style: TextStyle(
                                                color: currentpage == 1
                                                    ? Color(0xFF35AD9E)
                                                    : Colors.white,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
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
                        SizedBox(
                          width: Constant.width * 0.48,
                          // color: const Color.fromRGBO(33, 150, 243, 0.4),
                          child: Container(
                            // color: Colors.yellow,
                            padding: EdgeInsets.symmetric(
                              vertical: Constant.height * 0.005,
                            ),
                            width: (Constant.width * 0.48) * 0.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentpage = 3;
                                    });
                                  },
                                  child: SizedBox(
                                    width: Constant.width * 0.48 * 0.5,
                                    // color: Colors.blue,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          height:
                                              (Constant.height * 0.06) * 0.47,
                                          width: Constant.width * 0.48 * 0.5,
                                          // width: ((Constant.width * 0.48) * 0.48)* 0.5,
                                          child: FittedBox(
                                            child: Image.asset(
                                              "assets/home/ai.png",
                                              color: currentpage == 3
                                                  ? Color(0xFF35AD9E)
                                                  : null,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          // color: Colors.red,
                                          height:
                                              (Constant.height * 0.06) * 0.35,
                                          width: Constant.width * 0.48 * 0.5,
                                          // width: ((Constant.width * 0.48) * 0.48)* 0.5,
                                          child: FittedBox(
                                            child: Text(
                                              "Oncampus AI",
                                              style: TextStyle(
                                                color: currentpage == 3
                                                    ? Color(0xFF35AD9E)
                                                    : Colors.white,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentpage = 4;
                                    });
                                  },
                                  child: SizedBox(
                                    width: Constant.width * 0.48 * 0.5,
                                    // color: Colors.green,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height:
                                              (Constant.height * 0.06) * 0.43,
                                          // width: ((Constant.width * 0.48) * 0.48)* 0.5,
                                          child: FittedBox(
                                            child: Image.asset(
                                              "assets/home/profile.png",
                                              color: currentpage == 4
                                                  ? Color(0xFF35AD9E)
                                                  : null,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              (Constant.height * 0.06) * 0.4,
                                          // width: ((Constant.width * 0.48) * 0.48)* 0.5,
                                          child: FittedBox(
                                            child: Text(
                                              "Profile",
                                              style: TextStyle(
                                                color: currentpage == 4
                                                    ? Color(0xFF35AD9E)
                                                    : Colors.white,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
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
                      ],
                    ),
                  ),
                ),

                Positioned(
                  bottom: Constant.height * 0.035,
                  left: Constant.width * 0.44,
                  right: Constant.width * 0.44,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentpage = 2;
                      });
                    },
                    child: Image.asset("assets/home/home.png"),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
