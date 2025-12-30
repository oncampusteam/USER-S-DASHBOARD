import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:on_campus/widgets/custompainter.dart';
// import 'package:on_campus/screens/Home/homepage_body.dart';
// import 'package:on_campus/widgets/bottomNavIndicator.dart';
// import 'package:on_campus/widgets/widget.dart';
// import 'package:on_campus/screens/Listings/listings.dart' as listing;

ValueNotifier<bool> inProgress = ValueNotifier<bool>(false);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 0;

  @override
  void initState() {
    inProgress.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: PopScope(
        canPop: false,
        child: SafeArea(
          child: Stack(
            children: [
              // body //
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  color: Colors.blue,
                  child: Placeholder(),
                ),
              ),

              // body //

              // Bottom Nav Bar //
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CustomBottomNavBar(height: 60,),
              ),
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: CustomBottomNavBar(height: 49),
                ),
              ),
              // Bottom Nav Bar //

              // Circular-Icon //
              Positioned(
                right: 0,
                left: 0,
                bottom: 40,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = 4;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 400,
                    color: Colors.transparent,
                    child: Align(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: selected == 4
                              ? Color(0xFF2B6F71)
                              : Color(0xFF00EFD1),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset.zero,
                              blurRadius: 2,
                              spreadRadius: 0,
                              color: const Color.fromRGBO(0, 0, 0, 0.25),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            "assets/Screens/Home/homeIcon.png",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Circular-Icon

              // Bottom Nav Icons //
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  // color: Colors.red,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Dashboard
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = 0;
                          });
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              height: 20,
                              width: 23,
                              selected == 0
                                  ? "assets/Screens/Home/dashboard_coloured.png"
                                  : "assets/Screens/Home/dashboard.png",
                            ),
                            const Spacer(),
                            Text(
                              "Dashboard",
                              style: TextStyle(
                                fontFamily: "Outfit-Regular",
                                color: selected == 0
                                    ? const Color(0xFF2B6F71)
                                    : Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Dashboard //

                      // Booking //
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = 1;
                          });
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              height: 20,
                              width: 23,
                              selected == 1
                                  ? "assets/Screens/Home/booking_coloured.png"
                                  : "assets/Screens/Home/booking.png",
                            ),
                            const Spacer(),
                            Text(
                              "Booking",
                              style: TextStyle(
                                fontFamily: "Outfit-Regular",
                                color: selected == 1
                                    ? const Color(0xFF2B6F71)
                                    : Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Booking //

                      // Space //
                      const SizedBox(width: 45),
                      // Space //

                      // Payment //
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = 2;
                          });
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              height: 20,
                              width: 23,
                              selected == 2
                                  ? "assets/Screens/Home/payment_coloured.png"
                                  : "assets/Screens/Home/payment.png",
                            ),
                            const Spacer(),
                            Text(
                              "Payment",
                              style: TextStyle(
                                fontFamily: "Outfit-Regular",
                                color: selected == 2
                                    ? const Color(0xFF2B6F71)
                                    : Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Payment //

                      // Account //
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = 3;
                          });
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              height: 20,
                              width: 23,
                              selected == 3
                                  ? "assets/Screens/Home/account_coloured.png"
                                  : "assets/Screens/Home/account.png",
                            ),
                            const Spacer(),
                            Text(
                              "Account",
                              style: TextStyle(
                                fontFamily: "Outfit-Regular",
                                color: selected == 3
                                    ? const Color(0xFF2B6F71)
                                    : Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Account //
                    ],
                  ),
                ),
              ),

              Positioned(
                child: GestureDetector(
                  onTap: () {
                    if (inProgress.value) {
                      setState(() {
                        inProgress.value = false;
                      });
                    }
                  },
                  child: Container(
                    height: inProgress.value ? Constant.height : 0,
                    width: Constant.width,
                    color: inProgress.value
                        ? const Color.fromRGBO(0, 0, 0, 0.5)
                        : Colors.transparent,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedContainer(
                  padding: EdgeInsets.symmetric(
                    horizontal: Constant.generalPadding,
                    vertical: Constant.generalPaddingVertical,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  height: inProgress.value ? Constant.height * 0.5 : 0,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: Constant.height * 0.005),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: Constant.width,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                inProgress.value = false;
                              });
                            },
                            child: Icon(
                              Icons.close,
                              size: 24.sp,
                              color: const Color(0xFF000000),
                            ),
                          ),
                        ),
                        SizedBox(height: Constant.generalWhiteSpace / 2),
                        Container(
                          padding: EdgeInsets.all(5),
                          // color: Colors.blue,
                          width: Constant.width,
                          height: Constant.height * 0.225,
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: Constant.width * 0.45,
                              decoration: BoxDecoration(
                                color: Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: Constant.generalPadding * 2,
                            vertical: Constant.height * 0.015,
                          ),
                          child: FittedBox(
                            child: Text(
                              "Your listing was created on May 17, 2025.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF000000),
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Constant.generalWhiteSpace),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: Constant.generalPadding,
                          ),
                          width: Constant.width,
                          height: Constant.height * 0.05,
                          decoration: BoxDecoration(
                            color: Constant.primaryColor,
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Align(
                            child: SizedBox(
                              height: Constant.height * 0.02,
                              child: FittedBox(
                                child: Text(
                                  "Edit listing",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                  fontFamily: "Outfit",
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Constant.width,
                          height: Constant.height * 0.05,
                          child: Align(
                            child: SizedBox(
                              height: Constant.height * 0.02,
                              child: FittedBox(
                                child: Text(
                                  "Edit listing",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                  fontFamily: "Outfit",
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  ),
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

  @override
  void dispose() {
    inProgress.removeListener(() {});
    super.dispose();
  }
}
