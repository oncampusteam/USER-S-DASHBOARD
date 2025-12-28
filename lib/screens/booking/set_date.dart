import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:intl/intl.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/screens/Home%20Page%20Views/payment.dart';

class SetDate extends StatefulWidget {
  final Hostels hostel;
  final int duration;
  const SetDate({super.key, required this.hostel, required this.duration});

  @override
  State<SetDate> createState() => _SetDateState();
}

class _SetDateState extends State<SetDate> {

@override
  void dispose() {
    dateController_movein.dispose();
    dateController_moveout.dispose();
    
    super.dispose();
  }

  bool isLoading = false;
    final TextEditingController dateController_movein = TextEditingController();
  final TextEditingController dateController_moveout = TextEditingController();
  final Map<String, GlobalKey> _sectionKeys = {};
  final _formkey = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();

   Future<void> _selectDate(
    BuildContext context,
    TextEditingController moveInController,
    TextEditingController? moveOutController,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        // Set move-in date
        moveInController.text = DateFormat('MM-dd-yyyy').format(pickedDate);

        // If move-out controller was provided, add 2 years automatically
        if (moveOutController != null) {
          final moveOutDate = DateTime(
            pickedDate.year + widget.duration,
            pickedDate.month,
            pickedDate.day,
          );

          moveOutController.text = DateFormat('MM-dd-yyyy').format(moveOutDate);
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return setDate();
  }


   Widget setDate() {
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
        child: Form(
          key: _formkey2,
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
                      widget.hostel.hostel_images![0] ?? "",
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
                            TextSpan(text: "GHS 4000/"),
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
              Container(
                height: 60,
                child: TextFormField(
                  controller: dateController_movein,
                  readOnly: true,
                  onTap: () {
                    _selectDate(
                      context,
                      dateController_movein,
                      dateController_moveout,
                    );
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
                        _selectDate(
                          context,
                          dateController_movein,
                          dateController_moveout,
                        );
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please pick a date';
                    }
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
              Container(
                height: 60,
                child: TextFormField(
                  controller: dateController_moveout,
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
                    if (_formkey2.currentState!.validate()) {
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
                            'move_in': dateController_movein.text,
                            'move_out': dateController_moveout.text,
                            'isDone': true,
                          }, SetOptions(merge: true));
                      setState(() {
                        isLoading = false;
                      });
                      Get.to(
                        () => Payment(user: user),
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

}