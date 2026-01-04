import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:on_campus/screens/bottom_nav.dart';
import 'package:on_campus/screens/initialPage1.dart';

class Initialpage0 extends StatefulWidget {
  const Initialpage0({super.key});

  @override
  State<Initialpage0> createState() => _Initialpage0State();
}

class _Initialpage0State extends State<Initialpage0>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  bool noPadding = false;
  BoxShape shape = BoxShape.circle;
  BorderRadius? borderRadius;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    // _rebuildAfterDelay();
    _rebuild();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animation = Tween<double>(
      begin: 100,
      end: 0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
  }

  void _rebuildAfterDelay() async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      // padding = MediaQuery.of(context).size.height * 0.6;
      setState(() {
        // Update any state to trigger the rebuild
        height = 71.h;
        width = 71.h;
        imageHeight = 25.h;
        imageWidth = 25.h;
        radius = 50.r;
        duration = const Duration(milliseconds: 800);
        padding = MediaQuery.of(context).size.height * 0.5;
      });

      // Continue calling the function to rebuild again after the delay
      // _rebuildAfterDelay();
    }
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      imageHeight = 50.h;
      imageWidth = 50.h;
      height = 111.h;
      width = 111.h;
      // radius = 100.r;
      setState(() {});
    }
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      height = 153.h;
      width = 153.h;
      imageHeight = 85.h;
      imageWidth = 85.h;
      setState(() {});
    }

    await Future.delayed(const Duration(seconds: 2));
    noPadding = true;
    if (mounted) {
      height = MediaQuery.of(context).size.height * 0.4;
      width = MediaQuery.of(context).size.width * 0.8;
      duration = const Duration(milliseconds: 50);
      curve = Curves.easeIn;
      padding = MediaQuery.of(context).size.height * 0.3;
      radius = 150.h;
      setState(() {});
    }
    await Future.delayed(const Duration(milliseconds: 30));
    noPadding = true;
    if (mounted) {
      height = MediaQuery.of(context).size.height * 0.5;
      width = MediaQuery.of(context).size.width;
      padding = MediaQuery.of(context).size.height * 0.25;
      duration = const Duration(milliseconds: 50);
      curve = Curves.easeIn;
      setState(() {});
    }
    // await Future.delayed(const Duration(seconds: 5));
    // noPadding = true;
    // if (mounted) {
    //   height = MediaQuery.of(context).size.height * 0.8;
    //   width = MediaQuery.of(context).size.width;
    //   padding = MediaQuery.of(context).size.height * 0.15;
    //   duration = const Duration(milliseconds: 800);
    //   curve = Curves.easeIn;
    //   // shape = BoxShape.rectangle;
    //   // borderRadius = BorderRadius.circular(radius);
    //   // radius = 200.r;
    //   setState(() {});
    // }

    // await Future.delayed(const Duration(milliseconds: 50));
    if (mounted) {
      // Get.to(
      //   () => user == null
      //       ? Material(child: Initialpage1())
      //       : BottomNav(username: user!.displayName!),
      //   transition: Transition.fadeIn,
      //   curve: Curves.easeIn,
      //   duration: const Duration(milliseconds: 600),
      // );
    }
  }

  double padding = 0;
  bool visible = true;
  Duration duration = const Duration(seconds: 0);
  double height = 0.h;
  double width = 0.h;
  double imageHeight = 0.h;
  double imageWidth = 0.h;
  bool image = true;
  double radius = 0;
  double opacity = 1;
  Curve curve = Curves.bounceOut;

  void _rebuild() async {
    if (mounted) {}
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Container(
          height: Constant.height,
          width: Constant.width,
          child: Stack(
            children: [
            Center(
              child:Image.asset(
                "assets/initialPage0/onCampus-big.png",
                height: Constant.height * 0.15,
                fit: BoxFit.contain
                )
                ),
                Positioned(
                  bottom: Constant.height * 0.05,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    width: Constant.width,
                    child: Center(
                      child: Row(
                        children:[
                          
                        ])
                        )
                  )
                )
          ]),
        );
        // AnimatedContainer(
        //   onEnd: () {
        //     setState(() {
        //       padding = noPadding
        //           ? padding
        //           : MediaQuery.of(context).size.height * 0.4;
        //     });
        //   },
        //   curve: curve,
        //   color: Colors.white,
        //   padding: EdgeInsets.only(top: padding),
        //   duration: duration,
        //   alignment: Alignment.topCenter,
        //   child: image
        //       ? AnimatedContainer(
        //           duration: duration,
        //           curve: curve,
        //           height: height,
        //           width: width,
        //           alignment: Alignment.topCenter,
        //           decoration: BoxDecoration(
        //             shape: shape,
        //             borderRadius: borderRadius,
        //             gradient: const LinearGradient(
        //               begin: Alignment.topCenter,
        //               end: Alignment.bottomCenter,
        //               colors: [Color(0xFF00FFC2), Color(0xFF3787E5)],
        //             ),
        //           ),
        //           child: Center(
        //             child: Image.asset(
        //               "assets/initialPage0/on.png",
        //               fit: BoxFit.cover,
        //               height: imageHeight,
        //               width: imageWidth,
        //             ),
        //           ),
        //         )
        //       : Image.asset(
        //           "assets/initialPage0/onCampus.png",
        //           height: 97.h,
        //           width: 285.w,
        //         ),
        // );
      },
    );
  }
}
