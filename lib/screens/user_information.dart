import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/screens/personal_info.dart';

class UserInformation extends StatefulWidget {
  final UserModel? userInfo;
  const UserInformation({super.key, required this.userInfo});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          color: Colors.white,
          width: double.infinity,
          margin: EdgeInsets.only(top: Constant.height * 0.06),
          padding: EdgeInsets.only(left: 20.h, right: 20.h, top: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30.h,
                width: 30.w,
                foregroundDecoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                    size: 24.w,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(0, -65),
                child: Column(
                  children: [
                    Align(
                      child: Image.asset(
                        "assets/personal_info/user logo.png",
                        height: 110.h,
                        width: 100.w,
                      ),
                    ),
                    Align(
                      child: SizedBox(
                        height: Constant.height * 0.04,
                        child: FittedBox(
                          child: Text(
                            user?.displayName ?? "user",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Poppins-Bold",
                              fontSize: 22.sp,
                              letterSpacing: 0.15.w,
                              color: const Color(0xFF323232),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: Constant.height * 0.03,
                        child: FittedBox(
                          child: Text(
                            "Personal Information",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Constant.height * 0.03,
                          child: FittedBox(
                            child: Text(
                              "First Name : ${widget.userInfo!.name!.split(" ")[0]} ",
                            ),
                          ),
                        ),
                        const Divider(color: Color.fromARGB(31, 163, 162, 162)),
                        SizedBox(height: 10),
                        SizedBox(
                          height: Constant.height * 0.03,
                          child: FittedBox(
                            child: Text(
                              "Surname : ${widget.userInfo!.name!.split(" ").last}",
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        const Divider(color: Color.fromARGB(31, 163, 162, 162)),
                        SizedBox(height: 10),
                        SizedBox(
                          height: Constant.height * 0.06,
                          child: FittedBox(child: Text("Email address :\n${widget.userInfo!.email}"))),
                        SizedBox(height: 10),
                        const Divider(color: Color.fromARGB(31, 163, 162, 162)),
                        SizedBox(height: 10),
                        SizedBox(
                          height: Constant.height * 0.03,
                          child: FittedBox(child: Text("Phone Number : ${widget.userInfo!.phone}"))),
                        SizedBox(height: 10),
                        const Divider(color: Color.fromARGB(31, 163, 162, 162)),
                        SizedBox(height: 10),
                        SizedBox(
                          height: Constant.height * 0.03,
                          child: FittedBox(child: Text("Gender : ${widget.userInfo!.gender}"))),
                        SizedBox(height: 10),
                        const Divider(color: Color.fromARGB(31, 163, 162, 162)),
                        SizedBox(height: 10),
                        SizedBox(
                          height: Constant.height * 0.03,
                          child: FittedBox(child: Text("Program of study : ${widget.userInfo!.program}"))),
                        SizedBox(height: 10),
                        const Divider(color: Color.fromARGB(31, 163, 162, 162)),
                        SizedBox(height: 10),
                        SizedBox(
                          height: Constant.height * 0.03,
                          child: FittedBox(child: Text("Year : ${widget.userInfo!.year}"))),
                        SizedBox(height: 10),
                        const Divider(color: Color.fromARGB(31, 163, 162, 162)),
                        SizedBox(height: 10),
                        SizedBox(
                          height: Constant.height * 0.03,
                          child: FittedBox(child: Text("Guardian name : ${widget.userInfo!.guardian}"))),
                        SizedBox(height: 10),
                        const Divider(color: Color.fromARGB(31, 163, 162, 162)),
                        SizedBox(height: 10),
                        SizedBox(
                          height: Constant.height * 0.03,
                          child: FittedBox(
                            child: Text(
                              "Emergency contact(1) : ${widget.userInfo!.emergency1}",
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        const Divider(color: Color.fromARGB(31, 163, 162, 162)),
                        SizedBox(height: 10),
                        SizedBox(
                          height: Constant.height * 0.03,
                          child: FittedBox(
                            child: Text(
                              "Emergency contact(2) : ${widget.userInfo!.emergency2}",
                            ),
                          ),
                        ),
                        SizedBox(height: 35),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 150,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(
                                  () => PersonalInfo(),
                                  transition: Transition.fadeIn,
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeIn,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                backgroundColor: const Color(0xFF00EFD1),
                              ),
                              child: SizedBox(
                                height: Constant.height * 0.03,
                                child: FittedBox(
                                  child: const Text(
                                    "Edit",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400,
                                      ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
