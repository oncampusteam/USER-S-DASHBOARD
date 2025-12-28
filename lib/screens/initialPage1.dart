import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_campus/screens/welcome_page_views.dart';

class Initialpage1 extends StatefulWidget {
  const Initialpage1({super.key});

  @override
  State<Initialpage1> createState() => _Initialpage1State();
}

class _Initialpage1State extends State<Initialpage1> {
  late final Future<dynamic> future;
  @override
  void initState() {
    future = Future.delayed(const Duration(seconds: 2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
            body: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: Colors.white,
                // color: Color(0xFF00FFC2),
                // decoration: const BoxDecoration(
                //   gradient:const LinearGradient(
                //                   begin: Alignment.topCenter,
                //                   end: Alignment.bottomCenter,
                //                   colors: [Color(0xFF00FFC2), Color(0xFF3787E5)])
                //    ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Image.asset(
                    "assets/initialPage0/onCampus.png",
                    height: 97.h,
                    width: 285.w,
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return const WelcomePageViews();
            } else {
              return const Placeholder();
            }
          },
        )),
      ),
    );
  }
}
