import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyState extends StatefulWidget {
  final String title;
  final String content;
  final String imagePath;
  final String buttonText;
  final void Function() buttonTap;
  const EmptyState({
    super.key,
    required this.title,
    required this.content,
    required this.imagePath,
    required this.buttonText,
    required this.buttonTap,
  });

  @override
  State<EmptyState> createState() => _EmptyStateState();
}

class _EmptyStateState extends State<EmptyState> {
  String imagePath = "";

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
      ),
      child: Material(
        child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Container(
                  // color: Colors.red,
                  padding: EdgeInsets.only(top: 60.h),
                  height: Constant.height * 0.5,
                  width: Constant.width,
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
                        color: Color(0xFF101828),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: Constant.height * 0.03,
                  width: Constant.width * 0.8,
                  child: FittedBox(
                    child: Text(
                      widget.content,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF667085),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(bottom: 250.h),
                  width: Constant.width,
                  child: Align(
                    child: GestureDetector(
                      onTap: widget.buttonTap,
                      child: Container(
                        width: Constant.width * 0.2,
                        height: Constant.height * 0.04,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          color: Color(0xFF00EFD1),
                        ),
                        child: Align(
                          child: SizedBox(
                            height: Constant.height * 0.025,
                            child: FittedBox(
                              child: Text(
                                widget.buttonText,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
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
    );
  }
}
