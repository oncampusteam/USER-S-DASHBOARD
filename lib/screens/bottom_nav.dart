import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:on_campus/firebase/firestore_db.dart';
import 'package:on_campus/firebase_options.dart';
import 'package:on_campus/screens/Home%20Page%20Views/apartment.dart';
import 'package:on_campus/screens/Home%20Page%20Views/coming_soon.dart';
import 'package:on_campus/screens/Home%20Page%20Views/compare.dart';
import 'package:on_campus/screens/Home%20Page%20Views/home.dart';
import 'package:on_campus/screens/Home%20Page%20Views/payment.dart';
import 'package:on_campus/screens/Home%20Page%20Views/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNav extends StatefulWidget {
  final String username;
  final int? subindex;
  const BottomNav({super.key, required this.username, this.subindex,});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late int currentpage;

  List<Widget> getPages() {
    return [
      Apartment(),
      const ComingSoon(),
      Home(username: widget.username),
      const ComingSoon(),
      Profile(),
    ];
  }

  void navigateBottomBar(int index) {
    setState(() {
      currentpage = index;
    });
  }

  @override
  void initState() {
    super.initState();
    currentpage = widget.subindex ?? 2;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                  child: getPages()[currentpage],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: CurvedNavigationBar(
                  height: 50,
                  color: Color(0xFF00EFD1),
                  buttonBackgroundColor: Colors.white,
                  backgroundColor: Colors.transparent,
                  animationDuration: const Duration(milliseconds: 300),
                  index: currentpage,
                  items: [
                    Image.asset(
                      "assets/apartment/apartment.png",
                      height: 45.h,
                      width: 80.w,
                      color: currentpage == 0
                          ? const Color.fromARGB(255, 0, 239, 209)
                          : Colors.white,
                    ),
                    Image.asset(
                      "assets/apartment/payment.png",
                      height: 32.h,
                      width: 55.w,
                      color: currentpage == 1
                          ? const Color.fromARGB(255, 0, 239, 209)
                          : Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/apartment/HomeIcon2.png",
                        height: 20.h,
                        width: 25.w,
                        color: currentpage == 2
                            ? const Color.fromARGB(255, 0, 239, 209)
                            : Colors.white,
                      ),
                    ),
                    Image.asset(
                      "assets/apartment/compare.png",
                      height: 35.h,
                      width: 65.w,
                      color: currentpage == 3
                          ? const Color.fromARGB(255, 0, 239, 209)
                          : Colors.white,
                    ),
                    Image.asset(
                      "assets/apartment/profile.png",
                      height: 35.h,
                      width: 65.w.clamp(0, 65),
                      color: currentpage == 4
                          ? const Color.fromARGB(255, 0, 239, 209)
                          : Colors.white,
                    ),
                  ],
                  onTap: (index) => navigateBottomBar(index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
