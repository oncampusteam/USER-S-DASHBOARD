import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComingSoon extends StatefulWidget {
  const ComingSoon({super.key});

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  Duration remainingTime = const Duration(days: 365);
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = remainingTime.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        remainingTime = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final days = remainingTime.inDays;
    final hours = remainingTime.inHours - (days * 24);
    final minutes = remainingTime.inMinutes - (days * 24 * 60) - (hours * 60);
    final seconds = remainingTime.inSeconds -
        (days * 24 * 60 * 60) -
        (hours * 60 * 60) -
        (minutes * 60);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/coming_soon/rocket.png",
              height: 170,
              width: 170,
            ),
            SizedBox(height: 30.h),
            Text(
              "Coming Soon",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            SizedBox(height: 5.h),
            Text("We're creating something amazing"),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$days  :',
                  style:
                      const TextStyle(fontSize: 26, color: Color(0xFF00EFD1)),
                ),
                Text(
                  '  $hours  :',
                  style:
                      const TextStyle(fontSize: 26, color: Color(0xFF00EFD1)),
                ),
                Text(
                  '  $minutes  :',
                  style:
                      const TextStyle(fontSize: 26, color: Color(0xFF00EFD1)),
                ),
                Text(
                  '  $seconds',
                  style:
                      const TextStyle(fontSize: 24, color: Color(0xFF00EFD1)),
                ),
              ],
            ),
            SizedBox(height: 40.h),
            SizedBox(
              width: 250,
              height: 45,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Color(0xFF00EFD1),
                ),
                child: Text(
                  "Notify me",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
