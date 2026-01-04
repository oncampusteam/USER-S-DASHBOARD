import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/firebase/firestore_db.dart';
import 'package:on_campus/screens/Home%20Page%20Views/bookings.dart';
import 'package:on_campus/screens/Home%20Page%20Views/history.dart';

import 'package:on_campus/screens/Welcome%20Screens/signUp%20Screens/loginPage.dart';
import 'package:on_campus/screens/user_information.dart';

import 'package:on_campus/screens/personal_info.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user = FirebaseAuth.instance.currentUser;
  int selectedIndex = 3;
  UserModel? userInfo;
  bool isLoading = false;

  Future<void> getUserInfo() async {
    setState(() {
      isLoading = true;
    });
    UserModel? userInformation = await FirestoreDb.instance.getUserInfo(user);
    setState(() {
      userInfo = userInformation;
    });
    debugPrint("hey: ${userInfo?.userInfoDone ?? "Not Done"} ");

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    // Wait until the first frame is built before showing the dialog
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user == null) {
        // showDialog(
        //   context: context,
        //   barrierDismissible: false, // prevents closing when tapping outside
        //   builder: (BuildContext context) {
        //     return Center(
        //       child: AlertDialog(
        //         backgroundColor: Color(0xFF00EFD1),
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(15),
        //         ),
        //         title: const Text("Profile"),
        //         content: const Text("Please login to continue"),
        //         actions: [
        //           TextButton(
        //             onPressed: () {
        //               Navigator.of(context).pop();
        //             },
        //             child: const Text("Cancel"),
        //           ),
        //           ElevatedButton(
        //             onPressed: () {
        //               Navigator.of(context).pop();
        //               Get.to(
        //                 () => LoginPage(index: 2),
        //                 transition: Transition.fadeIn,
        //                 curve: Curves.easeIn,
        //                 duration: const Duration(seconds: 1),
        //               );
        //             },
        //             child: const Text("Login"),
        //           ),
        //         ],
        //       ),
        //     );
        //   },
        // );

        showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: const Color.fromRGBO(0, 0, 0, 0.2),
          builder: (context) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: AlertDialog(
                backgroundColor: Color.fromRGBO(255, 255, 255, 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
                title: SizedBox(
                  height: Constant.height * 0.03,
                  child: FittedBox(
                    child: const Text(
                      "Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Roboto",
                        color: Colors.black,
                      ),
                      )),
                ),
                content: SizedBox(
                  height: Constant.height * 0.025,
                  child: FittedBox(
                    child: const Text(
                      "Please Sign In to Continue",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto",
                        color: Color(0xFF7A7A7A),
                      ),
                      )),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: SizedBox(
                  height: Constant.height * 0.03,
                  child: FittedBox(
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Roboto",
                        color: Colors.black,
                      ),
                      )),
                ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Get.to(
                        () => LoginPage(index: 2),
                        transition: Transition.fadeIn,
                        curve: Curves.easeIn,
                        duration: const Duration(seconds: 1),
                      );
                    },
                    child: Container(
                      height: Constant.height * 0.04,
                      width: Constant.width * 0.2,
                      decoration: BoxDecoration(
                        color: Color(0xFF00EFD1),
                        borderRadius: BorderRadius.circular(16.r)
                      ),
                  child: Align(
                    child: SizedBox(
                      height: Constant.height * 0.025,
                      child: FittedBox(
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: "Roboto",
                            color: Colors.white,
                          ),
                          )),
                    ),
                  ),
                ),
                  ),
                ],
              ),
           );
                },
        );
      }
    });
    if(user != null){
      getUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            margin: EdgeInsets.only(top: Constant.height * 0.06),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.h),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 20,
                            color: Colors.transparent,
                          ),
                          onPressed: () {}, // invisible placeholder
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "Profile",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        // IconButton(
                        //   icon: IconButton(
                        //     icon: Image.asset(
                        //       "assets/user_interface_icons/profile_screen/editprofile.png",
                        //     ),
                        //     onPressed: () {
                        //       Get.to(
                        //         () => PersonalInfo(),
                        //         transition: Transition.fadeIn,
                        //         duration: const Duration(milliseconds: 600),
                        //         curve: Curves.easeIn,
                        //       );
                        //     },
                        //   ),
                        //   onPressed: () {},
                        // ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 55,
                          width: 55,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              "assets/welcome_screen_4/welcomeImage4.jpg",
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: SizedBox(
                                width: Constant.width * 0.6,
                                height: Constant.height * 0.04,
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    user?.displayName ?? "User",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Constant.width * 0.5,
                              child: FittedBox(
                                child: Text(
                                  user?.email ?? "Login to display email",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    ListTile(
                      onTap: () {
                        print("sldjdl${userInfo!.userInfoDone!}");
                        user == null
                            ? showDialog(
                                context: context,
                                barrierDismissible:
                                    false, // prevents closing when tapping outside
                                builder: (BuildContext context) {
                                  return Center(
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      title: const Text("Profile"),
                                      content: const Text(
                                        "Please login to continue",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
            
                                            Get.to(
                                              () => LoginPage(index: 2),
                                              transition: Transition.fadeIn,
                                              curve: Curves.easeIn,
                                              duration: const Duration(
                                                seconds: 1,
                                              ),
                                            );
                                          },
                                          child: const Text("Login"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : userInfo!.userInfoDone!
                            ? Get.to(
                                () => UserInformation(userInfo: userInfo),
                                transition: Transition.fadeIn,
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeIn,
                              )
                            : Get.to(
                                () => PersonalInfo(),
                                transition: Transition.fadeIn,
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeIn,
                              );
                      },
                      leading: IconButton(
                        icon: SvgPicture.asset(
                          "assets/user_interface_icons/profile_screen/User,Profile.svg",
                        ),
                        onPressed: () {},
                      ),
                      title: Text("Personal Information"),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios_outlined, size: 10),
                        onPressed: () {
                          Get.to(
                            () => userInfo!.userInfoDone!
                                ? UserInformation(userInfo: userInfo)
                                : PersonalInfo(),
                            transition: Transition.fadeIn,
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeIn,
                          );
                        },
                      ),
                      style: ListTileStyle.drawer,
                      contentPadding: EdgeInsets.all(0),
                      dense: true,
                      visualDensity: VisualDensity.compact,
                    ),
                    Divider(color: Colors.grey.withOpacity(0.1)),
                    ListTile(
                      onTap: () {
                        user == null
                            ? showDialog(
                                context: context,
                                barrierDismissible:
                                    false, // prevents closing when tapping outside
                                builder: (BuildContext context) {
                                  return Center(
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      title: const Text("Profile"),
                                      content: const Text(
                                        "Please login to continue",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Get.to(
                                              () => LoginPage(index: 2),
                                              transition: Transition.fadeIn,
                                              curve: Curves.easeIn,
                                              duration: const Duration(
                                                seconds: 1,
                                              ),
                                            );
                                          },
                                          child: const Text("Login"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : Get.to(
                                () => History(),
                                transition: Transition.fadeIn,
                                duration: Duration(milliseconds: 600),
                                curve: Curves.easeIn,
                              );
                      },
                      leading: IconButton(
                        icon: SvgPicture.asset(
                          "assets/user_interface_icons/profile_screen/credit-cards.svg",
                        ),
                        onPressed: () {},
                      ),
                      style: ListTileStyle.drawer,
                      contentPadding: EdgeInsets.all(0),
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      title: Text("Payment History"),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Divider(color: Colors.grey.withOpacity(0.1)),
                    ListTile(
                      onTap: () {
                        user == null
                            ? showDialog(
                                context: context,
                                barrierDismissible:
                                    false, // prevents closing when tapping outside
                                builder: (BuildContext context) {
                                  return Center(
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      title: const Text("Profile"),
                                      content: const Text(
                                        "Please login to continue",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Get.to(
                                              () => LoginPage(index: 2),
                                              transition: Transition.fadeIn,
                                              curve: Curves.easeIn,
                                              duration: const Duration(
                                                seconds: 1,
                                              ),
                                            );
                                          },
                                          child: const Text("Login"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : Get.to(
                                () => Bookings(),
                                transition: Transition.fadeIn,
                                duration: Duration(milliseconds: 600),
                                curve: Curves.easeIn,
                              );
                      },
                      leading: IconButton(
                        icon: SvgPicture.asset(
                          "assets/user_interface_icons/profile_screen/save-2.svg",
                        ),
                        onPressed: () {
                          Get.to(
                            user == null
                                ? showDialog(
                                    context: context,
                                    barrierDismissible:
                                        false, // prevents closing when tapping outside
                                    builder: (BuildContext context) {
                                      return Center(
                                        child: AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                          title: const Text("Profile"),
                                          content: const Text(
                                            "Please login to continue",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Get.to(
                                                  () => LoginPage(index: 2),
                                                  transition: Transition.fadeIn,
                                                  curve: Curves.easeIn,
                                                  duration: const Duration(
                                                    seconds: 1,
                                                  ),
                                                );
                                              },
                                              child: const Text("Login"),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                : () => Bookings(),
                            transition: Transition.fadeIn,
                            duration: Duration(milliseconds: 600),
                            curve: Curves.easeIn,
                          );
                        },
                      ),
                      title: Text("Bookings"),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        onPressed: () {},
                      ),
                      style: ListTileStyle.drawer,
                      contentPadding: EdgeInsets.all(0),
                      dense: true,
                      visualDensity: VisualDensity.compact,
                    ),
                    Divider(color: Colors.grey.withOpacity(0.1)),
                    ListTile(
                      leading: IconButton(
                        icon: SvgPicture.asset(
                          "assets/user_interface_icons/profile_screen/heart.svg",
                        ),
                        onPressed: () {},
                      ),
                      title: Text("Wishlist"),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        onPressed: () {},
                      ),
                      style: ListTileStyle.drawer,
                      contentPadding: EdgeInsets.all(0),
                      dense: true,
                      visualDensity: VisualDensity.compact,
                    ),
                    Divider(color: Colors.grey.withOpacity(0.1)),
                    ListTile(
                      leading: IconButton(
                        icon: SvgPicture.asset(
                          "assets/user_interface_icons/profile_screen/Chat, Messages.svg",
                        ),
                        onPressed: () {},
                      ),
                      title: Text("Message"),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        onPressed: () {},
                      ),
                      style: ListTileStyle.drawer,
                      contentPadding: EdgeInsets.all(0),
                      dense: true,
                      visualDensity: VisualDensity.compact,
                    ),
                    Divider(color: Colors.grey.withOpacity(0.1)),
                    ListTile(
                      leading: IconButton(
                        icon: SvgPicture.asset(
                          "assets/user_interface_icons/profile_screen/share.svg",
                        ),
                        onPressed: () {},
                      ),
                      title: Text("Share the app"),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        onPressed: () {},
                      ),
                      style: ListTileStyle.drawer,
                      contentPadding: EdgeInsets.all(0),
                      dense: true,
                      visualDensity: VisualDensity.compact,
                    ),
                    Divider(color: Colors.grey.withOpacity(0.1)),
                    ListTile(
                      leading: IconButton(
                        icon: SvgPicture.asset(
                          "assets/user_interface_icons/profile_screen/shop-add.svg",
                        ),
                        onPressed: () {},
                      ),
                      title: Text("Host Business or Service"),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        onPressed: () {},
                      ),
                      style: ListTileStyle.drawer,
                      contentPadding: EdgeInsets.all(0),
                      dense: true,
                      visualDensity: VisualDensity.compact,
                    ),
                    Divider(color: Colors.grey.withOpacity(0.1)),
                    ListTile(
                      leading: IconButton(
                        icon: SvgPicture.asset(
                          "assets/user_interface_icons/profile_screen/refer.svg",
                        ),
                        onPressed: () {},
                      ),
                      title: Text("Refer & Earn"),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        onPressed: () {},
                      ),
                      style: ListTileStyle.drawer,
                      contentPadding: EdgeInsets.all(0),
                      dense: true,
                      visualDensity: VisualDensity.compact,
                    ),
                    Divider(color: Colors.grey.withOpacity(0.1)),
                    ListTile(
                      leading: IconButton(
                        icon: SvgPicture.asset(
                          "assets/user_interface_icons/profile_screen/help.svg",
                        ),
                        onPressed: () {},
                      ),
                      title: Text("Help"),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        onPressed: () {},
                      ),
                      style: ListTileStyle.drawer,
                      contentPadding: EdgeInsets.all(0),
                      dense: true,
                      visualDensity: VisualDensity.compact,
                    ),
                    Divider(color: Colors.grey.withOpacity(0.1)),
                    user == null
                        ? ListTile(
                            onTap: () {
                              Get.to(
                                LoginPage(index: 2),
                                transition: Transition.fadeIn,
                                duration: Duration(milliseconds: 600),
                                curve: Curves.easeIn,
                              );
                            },
                            leading: IconButton(
                              icon: SvgPicture.asset(
                                "assets/user_interface_icons/profile_screen/logout.svg",
                              ),
                              onPressed: () {},
                            ),
                            title: Text("Log in"),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 15,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              onPressed: () {
                                Get.to(
                                  LoginPage(index: 2),
                                  transition: Transition.fadeIn,
                                  duration: Duration(milliseconds: 600),
                                  curve: Curves.easeIn,
                                );
                              },
                            ),
                            style: ListTileStyle.drawer,
                            contentPadding: EdgeInsets.all(0),
                            dense: true,
                            visualDensity: VisualDensity.compact,
                          )
                        : ListTile(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Profile'),
                                    content: const Text(
                                      'Are you sure you want to logout',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(
                                            context,
                                          ).pop(); // closes the dialog
                                        },
                                        child: const Text('NO'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          FirebaseAuth.instance.signOut();
                                          Navigator.of(context).pop();
                                          setState(() {}); // closes the dialog
                                        },
                                        child: const Text('YES'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            leading: IconButton(
                              icon: SvgPicture.asset(
                                "assets/user_interface_icons/profile_screen/logout.svg",
                              ),
                              onPressed: () {},
                            ),
                            title: Text("Log out"),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 15,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Profile'),
                                      content: const Text(
                                        'Are you sure you want to logout',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(
                                              context,
                                            ).pop(); // closes the dialog
                                          },
                                          child: const Text('NO'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            FirebaseAuth.instance.signOut();
                                            Navigator.of(
                                              context,
                                            ).pop(); // closes the dialog
                                          },
                                          child: const Text('YES'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            style: ListTileStyle.drawer,
                            contentPadding: EdgeInsets.all(0),
                            dense: true,
                            visualDensity: VisualDensity.compact,
                          ),
                    Divider(color: Colors.grey.withOpacity(0.1)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
