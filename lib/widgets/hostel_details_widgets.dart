import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/screens/get_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_campus/screens/Home%20Page%20Views/payment.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

Widget utilities({
  required Hostels hostel,
  bool amenities = false,
  bool security = false,
  bool bills = false,
  required String type,
  required BuildContext context,
}) {
  List<dynamic> abs() {
    if (amenities == true) {
      // debugPrint("This is the amenities return: ${hostel.amenities}");
      // debugPrint("This is the amenities length: ${hostel.amenities?.length}");
      // debugPrint("This is the amenities length: ${hostel.bills_utilities?.length}");
      // debugPrint("This is the amenities length: ${hostel.security_safety?.length}");
      return hostel.amenities as List<dynamic>;
    } else if (bills == true) {
      return hostel.bills_utilities as List<dynamic>;
    }
    if (security == true) {
      return hostel.security_safety as List<dynamic>;
    } else {
      return [];
    }
  }

  List<dynamic> value = abs();

  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GetIcon(text: value[0]["id"] ?? "noicon"),
              SizedBox(width: 5),
              SizedBox(
                height: Constant.height * 0.023,
                width: Constant.width * 0.35,
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  child: Text(value[0]["id"] ?? ""),
                ),
              ),
            ],
          ),
          Row(
            children: [
              GetIcon(text: value[1]["id"] ?? "noicon"),
              SizedBox(width: 5),
              SizedBox(
                height: Constant.height * 0.023,
                width: Constant.width * 0.35,
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  child: Text(value[1]["label"] ?? ""),
                ),
              ),
            ],
          ),
        ],
      ),
      SizedBox(height: 10.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GetIcon(text: value[2]["id"] ?? "noicon"),
              SizedBox(width: 5),
              SizedBox(
                height: Constant.height * 0.023,
                width: Constant.width * 0.35,
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  child: Text(value[2]["id"] ?? ""),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.white,
                context: context,
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 4,
                          width: 30,
                          margin: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 75, 74, 74),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        Text(
                          type,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 30,
                          ),
                          child: Divider(height: 10),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30.0,
                              vertical: 10,
                            ),
                            child: GridView.count(
                              crossAxisCount: 2,
                              mainAxisSpacing: 1,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              childAspectRatio: 4.0,
                              children: List.generate(value.length, (index) {
                                return Row(
                                  children: [
                                    getIcon(
                                      text: value[index]["id"] ?? "noicon",
                                    ),
                                    SizedBox(width: 5),
                                    SizedBox(
                                      height: Constant.height * 0.023,
                                      width: security
                                          ? Constant.width * 0.35
                                          : Constant.width * 0.32,
                                      child: FittedBox(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          value[index]["id"]?? "",
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/user_interface_icons/Hostel_detail_screens/ic_add.svg',
                  width: 20,
                  height: 20,
                ),
                SizedBox(width: 5),
                SizedBox(
                  height: Constant.height * 0.023,
                  width: Constant.width * 0.35,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "More",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

typedef OccupantFields =
    void Function(
      int count,
      StateSetter setModalState,
      List<TextEditingController> occupantNames,
      List<TextEditingController> occupantEmails,
    );
int duration = 1;
Widget book({
  required StateSetter setModalState,
  required TextEditingController numPeople,
  required TextEditingController name,
  required TextEditingController emailAddress,
  required List<TextEditingController> occupantEmails,
  required List<TextEditingController> occupantNames,
  required Hostels hostel,
  required GlobalKey<FormState> formkey,
  // required OccupantFields occupantFields,
  required bool isChecked,
  required bool isLoading,
  required BuildContext context,
  required GlobalKey<FormState> formkey2,
  required TextEditingController movin,
  required TextEditingController movOut,
  required VoidCallback triggerRebuild,
}) {
  void occupantFields({
    required int count,
    required StateSetter setModalState,
    required List<TextEditingController> occupantNames,
    required List<TextEditingController> occupantEmails,
  }) {
    if (count >= 1 && count <= 4) {
      setModalState(() {
        occupantNames.clear();
        occupantEmails.clear();

        for (int i = 0; i < count; i++) {
          occupantNames.add(TextEditingController());
          occupantEmails.add(TextEditingController());
        }
      });
    } else {
      Get.snackbar(
        "Incorrect value",
        "You can book for up to 4 occupants only",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  return SingleChildScrollView(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),

      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Align(
              child: Container(
                height: 5.h,
                width: 30.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF79747E),
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
            ),
          ),
          5.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "20% Off",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp.clamp(0, 12),
                  letterSpacing: 0.15.w,
                  color: const Color(0xFF00EFD1),
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.star_border_outlined,
                    size: 15.h,
                    color: const Color(0xFF00EFD1),
                  ),
                  Text(
                    "4.5",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.15.w,
                      fontSize: 12.sp.clamp(0, 12),
                      color: const Color(0xFF323232),
                    ),
                  ),
                  Text(
                    " (180 reviews)",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.15.w,
                      fontSize: 12.sp.clamp(0, 12),
                      color: const Color.fromRGBO(50, 50, 50, 0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
          5.verticalSpace,
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  hostel.hostel_images![0]["imageUrl"] ?? "",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "4in Room Bedroom Apartment",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "GH₵ 4000/"),
                        TextSpan(
                          text: "Academic year",
                          style: TextStyle(fontSize: 8),
                        ),
                      ],
                    ),
                  ),
                  Text("Available Rooms", style: TextStyle(fontSize: 10)),
                ],
              ),
            ],
          ),
          const Divider(color: Color.fromRGBO(120, 120, 120, 0.3)),
          SizedBox(height: 5),
          Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Number of people booking?",
                  style: TextStyle(
                    fontSize: 15.sp.clamp(0, 15),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2.w,
                    color: const Color(0xFF323232),
                  ),
                ),
                10.verticalSpace,
                TextFormField(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      int count = int.tryParse(value) ?? 1;
                      occupantFields(
                        count: count,
                        setModalState: setModalState,
                        occupantNames: occupantNames,
                        occupantEmails: occupantEmails,
                      );
                      setModalState(() {});
                    }
                  },
                  enabled: isChecked,
                  controller: numPeople,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.grey),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  decoration: InputDecoration(
                    labelText: "1",
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1,
                        style: BorderStyle.none,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }
                    final num = int.tryParse(value);
                    if (num == null || num < 1 || num > 4) {
                      return 'Enter a number between 1 and 4';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 4),
                  child: Text("Min 1 - Max 4", style: TextStyle(fontSize: 10)),
                ),
                SizedBox(height: 10),

                Column(
                  children: [
                    for (int i = 0; i < occupantNames.length; i++)
                      Column(
                        children: [
                          Text(
                            "Occupant ${i + 1}",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 15.sp.clamp(0, 15),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2.w,
                              color: const Color(0xFF323232),
                            ),
                          ),
                          SizedBox(height: 10.h),

                          TextFormField(
                            controller: occupantNames[i],
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.grey),
                            decoration: InputDecoration(
                              labelText: "Full name",
                              labelStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  style: BorderStyle.none,
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 10.h),
                          TextFormField(
                            controller: occupantEmails[i],
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.grey),

                            decoration: InputDecoration(
                              labelText: "Occupant Email",
                              labelStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  style: BorderStyle.none,
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email address';
                              }
                              final emailRegex = RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              );

                              // 3️ Check if it matches
                              if (!emailRegex.hasMatch(value)) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 4),
                            child: Text(
                              "Optional",
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          15.verticalSpace,
                        ],
                      ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? newValue) {
                        setModalState(() {
                          isChecked = newValue!;
                          if (isChecked == false) {
                            occupantFields(
                              count: 1,
                              setModalState: setModalState,
                              occupantNames: occupantNames,
                              occupantEmails: occupantEmails,
                            );
                            numPeople.text = "1";
                          }
                        });
                      },
                    ),
                    Text(
                      "Booking for others",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                SizedBox(height: 40.h),
                SizedBox(
                  height: 40.h,
                  width: double.infinity,
                  child: FilledButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        ),
                      ),
                      backgroundColor: const WidgetStatePropertyAll(
                        Color.fromARGB(255, 0, 239, 209),
                      ),
                    ),
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        setModalState(() {
                          isLoading = true;
                        });

                        final user = FirebaseAuth.instance.currentUser;

                        List<Map<String, dynamic>> occupants = [];

                        for (int i = 0; i < occupantNames.length; i++) {
                          occupants.add({
                            'name': occupantNames[i].text.trim(),
                            'email': occupantEmails[i].text.trim(),
                          });
                        }
                        await FirebaseFirestore.instance
                            .collection('Users')
                            .doc(user!.uid)
                            .collection('Booked hostels')
                            .doc(hostel.name) // Set your own ID
                            .set({
                              'hostel_name': hostel.name,
                              'paid': false,
                              'isDone': false,
                              'people_booking': int.parse(numPeople.text),
                              'name': name.text,
                              'occupants': occupants,
                              'email': emailAddress.text,
                            }, SetOptions(merge: true));
                        setModalState(() {
                          isLoading = false;
                        });
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder:
                                  (
                                    BuildContext context,
                                    StateSetter setModalState,
                                  ) {
                                    return selectWidget(
                                      setModalState: setModalState,
                                      context: context,
                                      isLoading: isLoading,
                                      hostel: hostel,
                                      moveOut: movOut,
                                      movin: movin,
                                      formkey2: formkey2,
                                      triggerRebuild: triggerRebuild,
                                    );
                                  },
                            );
                          },
                        );
                      }
                    },
                    child: isLoading
                        ? Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text("Please wait.."),
                              ],
                            ),
                          )
                        : Text(
                            "Continue",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp.clamp(0, 20),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget selectWidget({
  required StateSetter setModalState,
  required BuildContext context,
  required bool isLoading,
  required Hostels hostel,
  required TextEditingController movin,
  required TextEditingController moveOut,
  required GlobalKey<FormState> formkey2,
  required VoidCallback triggerRebuild,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),

    height: MediaQuery.of(context).size.height * 0.35,
    padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 5.h,
            width: 30.w,
            decoration: BoxDecoration(
              color: const Color(0xFF79747E),
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
          5.verticalSpace,
          Text(
            "Select Info",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp.clamp(0, 16),
              letterSpacing: 0.2,
            ),
          ),
          15.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Gender",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp.clamp(0, 16),
                      letterSpacing: 0.2,
                    ),
                  ),
                  Text(
                    "Choose your gender",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      color: const Color(0xFF333333),
                      fontSize: 9.sp.clamp(0, 9),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  genderSelector(setModalState: setModalState, gender: "M"),
                  25.horizontalSpace,
                  genderSelector(setModalState: setModalState, gender: "F"),
                ],
              ),
            ],
          ),
          15.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Duration",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp.clamp(0, 16),
                      letterSpacing: 0.2,
                    ),
                  ),
                  Text(
                    "Maximum 4 years",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      color: const Color(0xFF333333),
                      fontSize: 10.sp.clamp(0, 10),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (duration >= 2) {
                        setModalState(() {
                          duration--;
                        });
                      }
                    },
                    child: Container(
                      height: 30.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                            color: Colors.black.withOpacity(0.05),
                          ),
                        ],
                      ),
                      child: const Align(
                        child: Text(
                          "-",
                          style: TextStyle(color: Color(0xFF00EFD1)),
                        ),
                      ),
                    ),
                  ),
                  5.horizontalSpace,
                  Text(
                    "$duration",
                    style: TextStyle(
                      fontSize: 16.sp.clamp(0, 16),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  5.horizontalSpace,
                  GestureDetector(
                    onTap: () {
                      if (duration <= 3) {
                        setModalState(() {
                          duration++;
                        });
                      }
                    },
                    child: Container(
                      height: 30.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                            color: Colors.black.withOpacity(0.05),
                          ),
                        ],
                      ),
                      child: const Align(
                        child: Text(
                          "+",
                          style: TextStyle(color: Color(0xFF00EFD1)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          50.verticalSpace,
          SizedBox(
            height: 45.h,
            width: double.infinity,
            child: FilledButton(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  ),
                ),
                backgroundColor: const WidgetStatePropertyAll(
                  Color.fromARGB(255, 0, 239, 209),
                ),
              ),
              onPressed: () async {
                setModalState(() {
                  isLoading = true;
                });
                final user = FirebaseAuth.instance.currentUser;
                await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(user!.uid)
                    .collection('Booked hostels')
                    .doc(hostel.name) // Set your own ID
                    .set({
                      'gender': selectedGender == "M" ? "male" : "female",
                      'duration': duration,
                    }, SetOptions(merge: true));

                setModalState(() {
                  isLoading = false;
                });
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder:
                          (BuildContext context, StateSetter setModalState) {
                            return setDate(
                              setModalState: setModalState,
                              context: context,
                              formkey2: formkey2,
                              hostel: hostel,
                              isLoading: isLoading,
                              moveOut: moveOut,
                              movin: movin,
                              triggerRebuild: triggerRebuild,
                            );
                          },
                    );
                  },
                );
              },
              child: isLoading
                  ? Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text("Please wait.."),
                        ],
                      ),
                    )
                  : Text(
                      "Continue",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w600,
                        fontSize: 17.sp.clamp(0, 17),
                      ),
                    ),
            ),
          ),
        ],
      ),
    ),
  );
}

String selectedGender = "";
Widget genderSelector({
  required StateSetter setModalState,
  required String gender,
}) {
  bool isGender = selectedGender == gender;
  return GestureDetector(
    onTap: () {
      setModalState(() {
        selectedGender = gender;
        // debug//debugPrint(selectedGender);
      });
    },
    child: Container(
      height: 30.h,
      width: 30.w,
      decoration: BoxDecoration(
        color: isGender ? Color(0xFF00EFD1) : Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 4),
            color: const Color.fromRGBO(0, 0, 0, 0.5),
          ),
        ],
      ),
      child: Align(
        child: Text(
          gender,
          style: TextStyle(color: isGender ? Colors.white : Color(0xFF00EFD1)),
        ),
      ),
    ),
  );
}

Future<void> selectDate(
  BuildContext context,
  TextEditingController moveInController,
  TextEditingController? moveOutController,
  VoidCallback triggerRebuild,
) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (pickedDate != null) {
    // setState(() {
    // Set move-in date
    moveInController.text = DateFormat('MM-dd-yyyy').format(pickedDate);

    // If move-out controller was provided, add 2 years automatically
    if (moveOutController != null) {
      final moveOutDate = DateTime(
        pickedDate.year + duration,
        pickedDate.month,
        pickedDate.day,
      );

      moveOutController.text = DateFormat('MM-dd-yyyy').format(moveOutDate);
    }
    triggerRebuild();
    // });
  }
}

Widget setDate({
  required GlobalKey<FormState> formkey2,
  required StateSetter setModalState,
  required Hostels hostel,
  required bool isLoading,
  required TextEditingController movin,
  required TextEditingController moveOut,
  required BuildContext context,
  required VoidCallback triggerRebuild,
}) {
  return SingleChildScrollView(
    child: Container(
      height: Constant.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),

      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
      child: Form(
        key: formkey2,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Align(
                child: Container(
                  height: 5.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF79747E),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
              ),
            ),
            5.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "20% Off",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp.clamp(0, 12),
                    letterSpacing: 0.15.w,
                    color: const Color(0xFF00EFD1),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_border_outlined,
                      size: 15.h,
                      color: const Color(0xFF00EFD1),
                    ),
                    Text(
                      "4.5",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.15.w,
                        fontSize: 12.sp.clamp(0, 12),
                        color: const Color(0xFF323232),
                      ),
                    ),
                    Text(
                      " (180 reviews)",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.15.w,
                        fontSize: 12.sp.clamp(0, 12),
                        color: const Color.fromRGBO(50, 50, 50, 0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            5.verticalSpace,
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    hostel.hostel_images![0]["imageUrl"]?? "",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "4in Room Bedroom Apartment",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "GH₵ 4000/"),
                          TextSpan(
                            text: "Academic year",
                            style: TextStyle(fontSize: 8),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Available Rooms:",
                          style: TextStyle(fontSize: 10),
                        ),
                        SizedBox(width: 10.w),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Divider(color: Color.fromRGBO(120, 120, 120, 0.3)),
            SizedBox(height: 5),

            Text(
              "Book Hostel",
              style: TextStyle(
                fontSize: 18.sp.clamp(0, 18),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2.w,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 7),
            Text(
              "Move in",
              style: TextStyle(
                fontSize: 15.sp.clamp(0, 15),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2.w,
                color: const Color(0xFF323232),
              ),
            ),
            7.verticalSpace,
            SizedBox(
              height: 60,
              child: TextFormField(
                controller: movin,
                readOnly: true,
                onTap: () {
                  selectDate(context, movin, moveOut, triggerRebuild);
                },
                decoration: InputDecoration(
                  labelText: "date",
                  labelStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 1,
                      style: BorderStyle.none,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  suffix: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      selectDate(context, movin, moveOut, triggerRebuild);
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please pick a date';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 4),
              child: Text("MM/DD/YYYY", style: TextStyle(fontSize: 10)),
            ),
            SizedBox(height: 10),
            Text(
              "Move out",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 15.sp.clamp(0, 15),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2.w,
                color: const Color(0xFF323232),
              ),
            ),
            SizedBox(height: 7.h),
            SizedBox(
              height: 60,
              child: TextFormField(
                controller: moveOut,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "date",
                  labelStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 1,
                      style: BorderStyle.none,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 4),
              child: Text("MM/DD/YYYY", style: TextStyle(fontSize: 10)),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: 40.h,
              width: double.infinity,
              child: FilledButton(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                    ),
                  ),
                  backgroundColor: const WidgetStatePropertyAll(
                    Color.fromARGB(255, 0, 239, 209),
                  ),
                ),
                onPressed: () async {
                  if (formkey2.currentState!.validate()) {
                    setModalState(() {
                      isLoading = true;
                    });
                    final user = FirebaseAuth.instance.currentUser;
                    await FirebaseFirestore.instance
                        .collection('Users')
                        .doc(user!.uid)
                        .collection('Booked hostels')
                        .doc(hostel.name) // Set your own ID
                        .set({
                          'move_in': movin.text,
                          'move_out': moveOut.text,
                          'isDone': true,
                        }, SetOptions(merge: true));
                    setModalState(() {
                      isLoading = false;
                    });
                    Get.to(
                      () => Payment(user: user, subject: "Payment"),
                      transition: Transition.fadeIn,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeIn,
                    );
                  }
                },
                child: isLoading
                    ? Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text("Please wait.."),
                          ],
                        ),
                      )
                    : Text(
                        "Proceed to payment",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp.clamp(0, 20),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
