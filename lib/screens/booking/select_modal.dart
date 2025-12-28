import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/screens/booking/set_date.dart';

class SelectModal extends StatefulWidget {
  final Hostels hostel;
  const SelectModal({super.key, required this.hostel});

  @override
  State<SelectModal> createState() => _SelectModalState();
}

class _SelectModalState extends State<SelectModal> {

  String gender = "";
String selectedGender = "";
int duration = 1;
bool isLoading = false;

@override
  void dispose() {
    setState((){
      duration = 1;
    });
    
    super.dispose();
  }

Widget genderSelector(String gender) {
  bool isGender = selectedGender == gender;
  return GestureDetector(
    onTap: () {
      setState(() {
        selectedGender = gender;
        print(selectedGender);
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
            color: Colors.black.withOpacity(0.05),
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

  @override
  Widget build(BuildContext context) {
    return selectWidget();
  }


    Widget selectWidget() {
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
                    genderSelector( "M"),
                    25.horizontalSpace,
                    genderSelector("F"),
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
                        if (duration >= 2)
                          setState(() {
                            duration--;
                          });
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
                          setState(() {
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
                  setState(() {
                    isLoading = true;
                  });
                  final user = FirebaseAuth.instance.currentUser;
                  await FirebaseFirestore.instance
                      .collection('Users')
                      .doc(user!.uid)
                      .collection('Booked hostels')
                      .doc(widget.hostel.name) // Set your own ID
                      .set({
                        'gender': selectedGender == "M" ? "male" : "female",
                        'duration': duration,
                      }, SetOptions(merge: true));

                  setState(() {
                    isLoading = false;
                  });
                  showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  builder: (_) => SetDate(hostel: widget.hostel, duration: duration),
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

}