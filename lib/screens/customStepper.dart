import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_campus/classes/constants.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep;
  final ValueChanged<int>? onStepTapped;
  final List<String> stepTitles;

  const CustomStepper({
    super.key,
    required this.currentStep,
    this.onStepTapped,
    required this.stepTitles,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(stepTitles.length, (index) {
        return GestureDetector(
          onTap: () => onStepTapped?.call(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Step indicator
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentStep >= index
                      ? Colors.transparent
                      : Colors.grey[300],
                  border: currentStep >= index
                      ? Border.all(
                          color: Color.fromARGB(255, 124, 241, 225),
                          width: currentStep >= index ? 2 : 0,
                        )
                      : Border.all(color: Colors.transparent),
                ),
                child: Center(
                  child: currentStep > index
                      ? Icon(Icons.check, size: 18, color: Colors.white)
                      : Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: currentStep >= index
                                ? Colors.black
                                : Colors.grey[700],
                            fontSize: 10,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 8),
              // Step title
              Text(
                stepTitles[index],
                style: TextStyle(
                  fontSize: 9.5,
                  fontWeight: currentStep == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: currentStep >= index ? Colors.grey[850] : Colors.grey,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class Steps extends StatefulWidget {
  final int index;
  // final Function() stepsCallback;
  const Steps({super.key, required this.index});

  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      width: Constant.width * 0.8,
      height: Constant.height * 0.06,
      child: Stack(
        children: [
          Container(
            // color: Colors.green,
            height: Constant.height * 0.03,
            child: Align(
              child: Container(
                width: Constant.width * 0.7,
                height: 2,
                decoration: BoxDecoration(color: Color(0xFFDADADA)),
              ),
            ),
          ),
          Align(
            child: Container(
              // color: Colors.yellow,
              height: Constant.height * 0.06,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 30.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: widget.index >= 0
                              ? Colors.white
                              : Color(0xFFDADADA),
                          shape: BoxShape.circle,
                          border: widget.index >= 0
                              ? Border.all(color: Color(0xFF00EFD1))
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            "1",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF323232),
                              fontSize: 8.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                        height: Constant.height * 0.02,
                        child: FittedBox(
                          child: Text(
                            "Personal info",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 30.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: widget.index >= 1
                              ? Colors.white
                              : Color(0xFFDADADA),
                          shape: BoxShape.circle,
                          border: widget.index >= 1
                              ? Border.all(color: Color(0xFF00EFD1))
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            "2",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF323232),
                              fontSize: 8.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                        height: Constant.height * 0.02,
                        child: FittedBox(
                          child: Text(
                            "University info",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 30.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: widget.index >= 2
                              ? Colors.white
                              : Color(0xFFDADADA),
                          shape: BoxShape.circle,
                          border: widget.index >= 2
                              ? Border.all(color: Color(0xFF00EFD1))
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            "3",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF323232),
                              fontSize: 8.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                        height: Constant.height * 0.02,
                        child: FittedBox(
                          child: Text(
                            "Guardian details",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 30.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: widget.index >= 3
                              ? Colors.white
                              : Color(0xFFDADADA),
                          shape: BoxShape.circle,
                          border: widget.index >= 3
                              ? Border.all(color: Color(0xFF00EFD1))
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            "4",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF323232),
                              fontSize: 8.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                        height: Constant.height * 0.02,
                        child: FittedBox(
                          child: Text(
                            "Confirm",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class ConfirmScrollSheet extends StatefulWidget {
//   const ConfirmScrollSheet({super.key});

//   @override
//   State<ConfirmScrollSheet> createState() => _ConfirmScrollSheetState();
// }

// class _ConfirmScrollSheetState extends State<ConfirmScrollSheet> {
//   @override
//   Widget build(BuildContext context) {
//     return Builder(builder: (context) {
//       try {
//                     await FirebaseFirestore.instance
//                         .collection("Users")
//                         .doc(user!.uid)
//                         .set({
//                           "name": "${firstName.text} ${surName.text}",
//                           "email": email.text,
//                           "phone": int.parse(mobileNumber.text),
//                           "gender": gender.text,
//                           "program": program.text,
//                           "year": int.parse(year.text),
//                           "guardian": guardian.text,
//                           "emergency1": int.parse(emergency1.text),
//                           "emergency2": int.parse(emergency2.text),
//                           "userInfoDone": true,
//                         }, SetOptions(merge: true));
//                   } catch (e) {
//                     Get.snackbar(
//                       "Error",
//                       e.toString(),
//                       snackPosition: SnackPosition.BOTTOM,
//                     );
//                   }
//                   return Container();
//     });
//   }
// }
