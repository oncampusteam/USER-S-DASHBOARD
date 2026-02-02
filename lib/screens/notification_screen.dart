import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:on_campus/classes/user_file.dart';
import 'package:on_campus/screens/bottom_nav.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_campus/widgets/notification_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool turnOn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 25.h),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Container(
          padding: EdgeInsets.only(left: 25.h),
          height: 24.h,
          width: 24.w,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.chevron_left, color: Color(0xFF323232)),
          ),
        ),
        title: SizedBox(
          height: 25.h,
          child: FittedBox(
            child: Text(
              "Notification",
              style: TextStyle(
                fontFamily: "Poppins-Bold",
                fontSize: 22.sp,
                letterSpacing: 0.15.w,
              ),
            ),
          ),
        ),
        actions: [
          Switch(
            activeTrackColor: const Color(0xFF00EFD1),
            activeThumbColor: Colors.white,
            value: turnOn,
            onChanged: (value) {
              setState(() {
                turnOn = !turnOn;
                if (turnOn) {
                  NotificationService.show(
                    title: "Push Notification is active",
                    body: "Welcome to oncampus",
                  );
                }
              });
            },
          ),
        ],
      ),
      body: !turnOn
          ? Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 60.h),
                  height: Constant.height * 0.5,
                  width: Constant.width,
                  child: Image.asset(
                    "assets/empty_state/no_notification.png",
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: Constant.height * 0.03,
                  child: FittedBox(
                    child: Text(
                      "No notifications",
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
                  height: Constant.height * 0.06,
                  width: Constant.width * 0.8,
                  child: FittedBox(
                    child: Text(
                      textAlign: TextAlign.center,
                      "You have no notifications yet.\nPlease come back later.",
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
                  margin: EdgeInsets.only(bottom: 100.h),
                  width: Constant.width,
                  child: Align(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(
                          () => BottomNav(
                            username: userInformation["username"],
                            subindex: 2,
                          ),
                        );
                      },
                      child: Container(
                        width: Constant.width * 0.25,
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
                                "Go Home",
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
            )
          : Column(
              children: [
                SizedBox(height: 30.h),
                notificationCard(
                  name: "Craig",
                  city: "Kumasi",
                  content: "On Campus update: Your booking has been cancelled",
                  status: "Canceled",
                ),
                SizedBox(height: 20.h),
                notificationCard(
                  name: "Eric",
                  city: "Accra",
                  content: "New date and time request",
                  status: "Request pending",
                ),
              ],
            ),
    );
  }

  Widget notificationCard({
    required String name,
    required String city,
    required String content,
    required String status,
    String imageUrl = "",
  }) {
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.symmetric(horizontal: 25.h),
      // height: Constant.height * 0.08,
      child: Row(
        children: [
          Container(
            height: Constant.height * 0.075,
            width: Constant.width * 0.155,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: CachedNetworkImage(
              imageUrl: imageUrl, // Network image
              fit: BoxFit.cover,
              placeholder: (context, url) => Image.asset(
                "assets/notification/default.png",
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) => Image.asset(
                "assets/notification/default.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10.h),
          SizedBox(
            width: Constant.width * 0.7,
            // color: Colors.yellow,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Constant.height * 0.025,
                      child: FittedBox(
                        child: Text(
                          name,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF0A0A0A),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Constant.height * 0.025,
                      child: FittedBox(
                        child: Text(
                          " ∙ $city",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF717375),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  content,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0A0A0A),
                  ),
                ),
                SizedBox(
                  height: Constant.height * 0.025,
                  child: FittedBox(
                    child: Text(
                      status,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF717375),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
