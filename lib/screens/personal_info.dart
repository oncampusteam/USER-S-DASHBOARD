import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:on_campus/screens/bottom_nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_campus/screens/customStepper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  bool genderSelect = false;
  String sex = "";
  int level = 0;
  bool yearSelect = false;
  int index = 0;
  double initialScrollOffset = 0;
  ScrollController controller = ScrollController();

  bool isLoading = false;
  bool isLoadingStep = false;
  TextEditingController firstName = TextEditingController();
  TextEditingController surName = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController region = TextEditingController();
  TextEditingController program = TextEditingController();
  TextEditingController guardian = TextEditingController();
  TextEditingController emergency1 = TextEditingController();
  TextEditingController emergency2 = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController houseAddress = TextEditingController();
  final formkey0 = GlobalKey<FormState>();
  final formkey1 = GlobalKey<FormState>();
  final formkey2 = GlobalKey<FormState>();
  // int index = 0;
  final List<String> genderList = ['Male', 'Female'];
  final List<String> steps = [
    'Personal Info',
    'University Info',
    'Guardian Details',
    'Confirm',
  ];
  final List<int> yearList = [100, 200, 300, 400, 500, 600];

  Widget PersonalInfoForm() {
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          // color: Colors.red,
          child: Form(
            key: formkey0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 17),
                Row(
                  children: [
                    Text(
                      "First Name",
                      style: TextStyle(
                        height: 2,
                        fontWeight: FontWeight.w600,
                        fontSize: 11.5,
                      ),
                    ),
                    Text("*", style: TextStyle(color: Colors.red)),
                  ],
                ),
                SizedBox(
                  height: Constant.height * 0.1,
                  child: customTextForm(
                    controller: firstName,
                    hint: "Enter your first name",
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Surname",
                      style: TextStyle(
                        height: 2,
                        fontWeight: FontWeight.w600,
                        fontSize: 11.5,
                      ),
                    ),
                    Text("*", style: TextStyle(color: Colors.red)),
                  ],
                ),
                SizedBox(
                  height: Constant.height * 0.1,
                  child: customTextForm(
                    controller: surName,
                    hint: "Enter your Surname",
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Email address",
                      style: TextStyle(
                        height: 2,
                        fontWeight: FontWeight.w600,
                        fontSize: 11.5,
                      ),
                    ),
                    Text("*", style: TextStyle(color: Colors.red)),
                  ],
                ),
                SizedBox(
                  height: Constant.height * 0.1,
                  child: customEmailForm(
                    controller: email,
                    hint: "Enter your email",
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Phone number",
                      style: TextStyle(
                        height: 2,
                        fontWeight: FontWeight.w600,
                        fontSize: 11.5,
                      ),
                    ),
                    Text("*", style: TextStyle(color: Colors.red)),
                  ],
                ),
                SizedBox(
                  height: Constant.height * 0.1,
                  child: customNumberForm(
                    controller: mobileNumber,
                    hint: "Enter your phone number",
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Gender",
                      style: TextStyle(
                        height: 2,
                        fontWeight: FontWeight.w600,
                        fontSize: 11.5,
                      ),
                    ),
                    Text("*", style: TextStyle(color: Colors.red)),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.h),
                  decoration: BoxDecoration(
                    color: Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  height: Constant.height * 0.065,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        sex == "" ? "Choose your gender" : sex,
                        style: TextStyle(
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: sex == "" ? Color(0xFFB7B8BA) : Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            genderSelect = !genderSelect;
                          });
                        },
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                if (genderSelect)
                  Container(
                    width: Constant.width,
                    padding: EdgeInsets.only(left: 15.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            sex = "Male";
                            genderSelect = false;
                            setState(() {});
                          },
                          child: SizedBox(
                            height: Constant.height * 0.03,
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Male",
                                style: TextStyle(
                                  fontFamily: "Outfit",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              sex = "Female";
                              genderSelect = false;
                            });
                          },
                          child: SizedBox(
                            height: Constant.height * 0.03,
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Female",
                                style: TextStyle(
                                  fontFamily: "Outfit",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                ),
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
        ),
      ),
    );
  }

  Widget UniversityInfoForm() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        // height: 700,
        child: Form(
          key: formkey1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 17),
              Text("Program of study", style: TextStyle(height: 2)),
              SizedBox(
                height: 60,
                child: customTextForm(
                  controller: program,
                  hint: "Enter your Program of study",
                ),
              ),
              SizedBox(height: 20),
              Text("Year", style: TextStyle(height: 2)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.h),
                decoration: BoxDecoration(
                  color: Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                height: Constant.height * 0.065,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$level" == "0" ? "Select Level" : "$level",
                      style: TextStyle(
                        fontFamily: "Outfit",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: "$level" == "0"
                            ? Color(0xFFB7B8BA)
                            : Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          yearSelect = !yearSelect;
                        });
                      },
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              if (yearSelect)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.h),
                  width: Constant.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          level = 100;
                          yearSelect = false;
                          setState(() {});
                        },
                        child: SizedBox(
                          height: Constant.height * 0.03,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "100",
                              style: TextStyle(
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            level = 200;
                            yearSelect = false;
                          });
                        },
                        child: SizedBox(
                          height: Constant.height * 0.03,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "200",
                              style: TextStyle(
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            level = 300;
                            yearSelect = false;
                          });
                        },
                        child: SizedBox(
                          height: Constant.height * 0.03,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "300",
                              style: TextStyle(
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            level = 400;
                            yearSelect = false;
                          });
                        },
                        child: SizedBox(
                          height: Constant.height * 0.03,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "400",
                              style: TextStyle(
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            level = 500;
                            yearSelect = false;
                          });
                        },
                        child: SizedBox(
                          height: Constant.height * 0.03,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "500",
                              style: TextStyle(
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            level = 600;
                            yearSelect = false;
                          });
                        },
                        child: SizedBox(
                          height: Constant.height * 0.03,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "600",
                              style: TextStyle(
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget GuardianDetailsForm() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        child: Form(
          key: formkey2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 17),
              Text("Guardian name", style: TextStyle(height: 2)),
              SizedBox(
                height: 60,
                child: customTextForm(
                  controller: guardian,
                  hint: "Enter your guardian's name",
                ),
              ),
              SizedBox(height: 20),
              Text("Emergency contact (1)", style: TextStyle(height: 2)),
              SizedBox(
                height: 60,
                child: customNumberForm(
                  controller: emergency1,
                  hint: "Enter emergency contact",
                ),
              ),
              SizedBox(height: 20),
              Text("Emergency contact (2)", style: TextStyle(height: 2)),
              SizedBox(
                height: 60,
                child: customNumberForm(
                  controller: emergency2,
                  hint: "Enter emergency contact",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ConfirmationPage() {
    return Container();
  }

  Widget customTextForm({
    required TextEditingController controller,
    String? hint,
  }) {
    return TextFormField(
      //   onChanged: (){},
      //   focusNode:,
      enableInteractiveSelection: false,
      controller: controller,
      obscureText: false,
      enableSuggestions: true,
      autocorrect: false,
      cursorColor: Colors.white,
      cursorHeight: 20,
      style: const TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
        fontWeight: FontWeight.w500,
        fontSize: 12.5,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontFamily: "Outfit",
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
          color: Color(0xFFB7B8BA),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF00EFD1)),
        ),
        filled: true,
        fillColor: Color(0xFFF1F1F1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
      ),
      validator: (value) {
        if (value == "" || value == null || value.isEmpty) {
          return 'Please fill in required field';
        }
        return null;
      },
    );
  }

  Widget customEmailForm({
    required TextEditingController controller,
    String? hint,
  }) {
    return TextFormField(
      //   onChanged: (){},
      //   focusNode:,
      controller: controller,
      obscureText: false,
      enableSuggestions: true,
      autocorrect: false,
      cursorHeight: 20,
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
        fontWeight: FontWeight.w500,
        fontSize: 12.5,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontFamily: "Outfit",
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
          color: Color(0xFFB7B8BA),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF00EFD1)),
        ),
        filled: true,
        fillColor: Color(0xFFF1F1F1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email address';
        }
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

        // 3️ Check if it matches
        if (!emailRegex.hasMatch(value)) {
          return 'Enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget customNumberForm({
    required TextEditingController controller,
    String? hint,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: false,
      enableSuggestions: true,
      autocorrect: false,
      cursorColor: Colors.white,
      cursorHeight: 20,
      style: const TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
        fontWeight: FontWeight.w500,
        fontSize: 12.5,
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontFamily: "Outfit",
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
          color: Color(0xFFB7B8BA),
        ),

        filled: true,
        fillColor: Color(0xFFF1F1F1),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF00EFD1)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == "" || value == null || value.isEmpty) {
          return 'Please fill in required field';
        }
        if (value.length < 10) {
          return "Number must be up to 10 digits";
        }
        return null;
      },
    );
  }

  Widget UserInfo() {
    return isLoading ? CircularProgressIndicator() : Container();
  }

  dynamic confrimScrollSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          height: Constant.height * 0.43,
          child: Column(
            children: [
              SizedBox(height: 15),
              Container(color: Colors.black45, width: 35, height: 5),
              SizedBox(height: 20.h),
              Align(
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: Constant.height * 0.1,
                  width: Constant.width * 0.3,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 148, 118, 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    "assets/personal_info/Group.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: Constant.height * 0.03,
                child: FittedBox(
                  child: Text(
                    "Confirmed Successfully",
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: Constant.height * 0.06,
                child: FittedBox(
                  child: Text(
                    "Your personal information has been\nSuccessfully updated",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "Nunito",
                      color: Color(0xFF666666),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 35),
              Container(
                // color: Colors.white,
                height: Constant.height * 0.1,
                width: MediaQuery.sizeOf(context).width,
                child: Align(
                  child: SizedBox(
                    height: Constant.height * 0.06,
                    width: Constant.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(
                          () => BottomNav(
                            username:
                                FirebaseAuth
                                    .instance
                                    .currentUser!
                                    .displayName ??
                                "User",
                          ),
                          transition: Transition.fadeIn,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        backgroundColor: const Color(0xFF00EFD1),
                      ),
                      child: SizedBox(
                        height: Constant.height * 0.025,
                        child: FittedBox(
                          child: const Text(
                            "Done",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SizedBox(
        height: Constant.height * 0.1,
        child: Align(
          child: SizedBox(
            height: Constant.height * 0.06,
            width: Constant.width * 0.8,
            child: ElevatedButton(
              onPressed: () async {
                () async {
                  //debugPrint("This is the executing");
                };
                if (index > 1) {
                  setState(() {
                    isLoadingStep = true;
                  });
                  try {
                    await FirebaseFirestore.instance
                        .collection("Users")
                        .doc(user!.uid)
                        .set({
                          "name": "${firstName.text} ${surName.text}",
                          "email": email.text,
                          "phone": int.parse(mobileNumber.text),
                          "gender": sex,
                          "program": program.text,
                          "year": level,
                          "guardian": guardian.text,
                          "emergency1": int.parse(emergency1.text),
                          "emergency2": int.parse(emergency2.text),
                          "userInfoDone": true,
                        }, SetOptions(merge: true));
                  } catch (e) {
                    Get.snackbar(
                      "Error",
                      e.toString(),
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }

                  setState(() {
                    isLoadingStep = false;
                  });

                  confrimScrollSheet();
                }
                if (index == 0
                    ? formkey0.currentState!.validate() && sex != ""
                    : index == 1
                    ? formkey1.currentState!.validate() && level != 0
                    : formkey2.currentState!.validate() && index < 3) {
                  setState(() {
                    // controller.initialScrollOffset
                    // initialScrollOffset = 0;
                    index++;
                    controller.jumpTo(0);
                    // index++;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00EFD1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),

              child: isLoadingStep
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
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: Constant.height * 0.06),
        child: SingleChildScrollView(
          controller: controller,
          child: Container(
            // height: MediaQuery.of(context).size.height,
            color: Colors.white,
            width: double.infinity,
            padding: EdgeInsets.only(left: 20.h, right: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40.h,
                  width: 40.w,
                  // foregroundDecoration: BoxDecoration(
                  //   color: Colors.black.withOpacity(0.03),
                  //   borderRadius: BorderRadius.circular(8.r),
                  // ),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 0, 0, 0.05),
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
                Column(
                  children: [
                    Align(
                      child: SizedBox(
                        height: Constant.height * 0.1,
                        width: Constant.width * 0.2,
                        child: Image.asset(
                          "assets/personal_info/user logo.png",
                          fit: BoxFit.contain,
                        ),
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
                    SizedBox(height: 6),
                    isLoading
                        ? CircularProgressIndicator()
                        : Container(
                            height: MediaQuery.of(context).size.height + 30,
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // CustomStepper(
                                //   index: index,
                                //   stepTitles: steps,
                                //   onStepTapped: (index) {
                                //     setState(() => index = index);
                                //   },
                                // ),
                                Steps(
                                  index: index,
                                  stepsCallback: (int tapIndex) {
                                    if (index > 0 && tapIndex == 1) {
                                      setState(() {
                                        index = 0;
                                      });
                                    }
                                    if (index > 1 && tapIndex == 2) {
                                      setState(() {
                                        index = 1;
                                      });
                                    }
                                    if (index > 2 && tapIndex == 3) {
                                      setState(() {
                                        index = 2;
                                      });
                                    }
                                    if (index > 3 && tapIndex == 4) {
                                      setState(() {
                                        index = 3;
                                      });
                                    }
                                  },
                                ),
                                // Your step content here based on index
                                Container(
                                  child: IntrinsicHeight(
                                    child: IndexedStack(
                                      index: index,
                                      children: [
                                        PersonalInfoForm(),
                                        UniversityInfoForm(),
                                        GuardianDetailsForm(),
                                        ConfirmationPage(),
                                      ],
                                    ),
                                  ),
                                ),
                                // Spacer(),
                                SizedBox(height: 50),
                                // Navigation buttons
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     // if (index > 0)
                                //     //   TextButton(
                                //     //     onPressed: () =>
                                //     //         setState(() => index--),
                                //     //     child: Text(
                                //     //       'Back',
                                //     //       style: TextStyle(
                                //     //         color: Colors.black,
                                //     //         fontWeight: FontWeight.bold,
                                //     //       ),
                                //     //     ),
                                //     //   ),
                                //     // if (index < steps.length )
                                //     // Align(
                                //     //   alignment: Alignment.center,
                                //     //   child: SizedBox(
                                //     //     height: 50,
                                //     //     width:
                                //     //         MediaQuery.of(context).size.width *
                                //     //         0.5,

                                //     //     child:
                                //     //   ),
                                //     // ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
