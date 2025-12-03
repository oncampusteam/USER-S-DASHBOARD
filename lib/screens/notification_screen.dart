import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool turnOn = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: SizedBox(
          height: 24.h,
          width: 24.w,
          child: Icon(Icons.chevron_left, color: Color(0xFF323232))),
        title: Container(
            height: 22.h,
            child: FittedBox(
              child: Text(
                "Notification",
                style: TextStyle(
                  fontFamily: "Poppins-Bold",
                  fontSize: 22.sp,
                  letterSpacing: 0.15.w,
                ),
              ),
            )),
        actions: [
          Switch(
              activeTrackColor: const Color(0xFF00EFD1),
              activeColor: Colors.white,
              value: turnOn,
              onChanged: (value) {
                setState(() {
                  turnOn = !turnOn;
                });
              })
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Center(child: Text("No Notification yet"),),
      ),
    ));
  }
}
