import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyState extends StatefulWidget {
  final String title;
  final String content;
  final String imagePath;
  const EmptyState({super.key, required this.title, required this.content, required this.imagePath});

  @override
  State<EmptyState> createState() => _EmptyStateState();
}

class _EmptyStateState extends State<EmptyState> {
  String imagePath = "";

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xFFF1FFFD),
        statusBarBrightness: Brightness.dark
      ),
      child: Material(
        child: SafeArea(
          top: false,
          child: Scaffold(
            body: Column(
              children: [
                SizedBox(
                  height: Constant.height * 0.4,
                  child: Image.asset(widget.imagePath, fit: BoxFit.cover),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: Constant.height * 0.03,
                  child: FittedBox(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF101828)
                      )
                      )),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: Constant.height * 0.03,
                  child: FittedBox(
                    child: Text(
                      widget.content,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF667085)
                      )
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
