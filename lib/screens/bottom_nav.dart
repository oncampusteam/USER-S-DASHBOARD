import 'package:flutter/material.dart';
import 'package:on_campus/screens/Home%20Page%20Views/apartment.dart';
import 'package:on_campus/screens/Home%20Page%20Views/coming_soon.dart';
import 'package:on_campus/screens/Home%20Page%20Views/home.dart';
import 'package:on_campus/screens/Home%20Page%20Views/profile.dart';
import 'package:on_campus/screens/bottomNavIndicator.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selected = 4;

  @override
  Widget build(BuildContext context) {
    return PopScope(
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
              child: Container(color: Colors.blue, child: body()),
            ),

            // body //

            // Bottom Nav Bar //
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomBottomNavBar(height: 60, dip: 50),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: CustomBottomNavBar(height: 49, dip: 45),
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
                        child: Image.asset("assets/apartment/HomeIcon2.png"),
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
                          Expanded(
                            child: Image.asset(
                              selected == 0
                                  ? "assets/apartment/apartment.png"
                                  : "assets/apartment/apartment.png",
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
                          Expanded(
                            child: Image.asset(
                              selected == 1
                                  ? "assets/apartment/payment.png"
                                  : "assets/apartment/payment.png",
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
                          Expanded(
                            child: Image.asset(
                              selected == 2
                                  ? "assets/apartment/compare.png"
                                  : "assets/apartment/compare.png",
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
                          Expanded(
                            child: Image.asset(
                              // height: 20,
                              // width: 23,
                              selected == 3
                                  ? "assets/apartment/profile.png"
                                  : "assets/apartment/profile.png",
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
          ],
        ),
      ),
    );
  }

  Widget body() {
    return IndexedStack(
      index: selected,
      children: [
        Apartment(),

        const ComingSoon(),

        const ComingSoon(),
        Profile(),

        Home(username: " widget.username"),
      ],
    );
  }
}
