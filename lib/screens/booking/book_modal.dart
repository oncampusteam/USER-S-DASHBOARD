import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/screens/booking/select_modal.dart';

class BookModal extends StatefulWidget {
  final Hostels hostel;
  const BookModal({super.key, required this.hostel});

  @override
  State<BookModal> createState() => _BookModalState();
}

class _BookModalState extends State<BookModal> {
  final num_people = TextEditingController();
  final name = TextEditingController();
  final email_address = TextEditingController();
  bool isChecked = false;
  bool isLoading = false;
  final Map<String, GlobalKey> _sectionKeys = {};
  final _formkey = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();

  final List<TextEditingController> occupantNames = [];
  final List<TextEditingController> occupantPhones = [];
  final List<TextEditingController> occupantEmails = [];

  void occupantFields({
    required int count,
    required List<TextEditingController> occupantNames,
    required List<TextEditingController> occupantPhones,
    required List<TextEditingController> occupantEmails,
  }) {
    if (count >= 1 && count <= 4) {
      setState(() {
        occupantNames.clear();
        occupantPhones.clear();
        occupantEmails.clear();

        for (int i = 0; i < count; i++) {
          occupantNames.add(TextEditingController());
          occupantPhones.add(TextEditingController());
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

  @override
  void initState() {
    super.initState();
    occupantNames.add(TextEditingController());
    occupantPhones.add(TextEditingController());
    occupantEmails.add(TextEditingController());
  }

  @override
  void dispose() {
    num_people.dispose();
    name.dispose();
    email_address.dispose();

    for (final c in occupantNames) c.dispose();
    for (final c in occupantPhones) c.dispose();
    for (final c in occupantEmails) c.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return book(
      num_people,
      name,
      email_address,
      occupantEmails,
      occupantPhones,
      occupantNames,
    );
  }

  Widget book(
    TextEditingController num_people,
    TextEditingController name,
    TextEditingController email_address,
    List<TextEditingController> occupantEmails,
    List<TextEditingController> occupantPhones,
    List<TextEditingController> occupantNames,
  ) {
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
                    Text("Available Rooms", style: TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),
            const Divider(color: Color.fromRGBO(120, 120, 120, 0.3)),
            SizedBox(height: 5),
            Form(
              key: _formkey,
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
                          occupantNames: occupantNames,
                          occupantPhones: occupantPhones,
                          occupantEmails: occupantEmails,
                        );
                        setState((){});
                      }
                    },
                    enabled: isChecked,
                    controller: num_people,
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
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 4),
                    child: Text(
                      "Min 1 - Max 4",
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  SizedBox(height: 10),

                  Column(
                    children: [
                      for (int i = 0; i < occupantNames.length; i++)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
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
                              },
                            ),
                            SizedBox(height: 10.h),

                            TextFormField(
                              controller: occupantPhones[i],
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.grey),
                              decoration: InputDecoration(
                                labelText: "Phone Number",
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 1,
                                    style: BorderStyle.none,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
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
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
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
                              },
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                top: 4,
                              ),
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
                          setState(() {
                            isChecked = newValue!;
                            if (isChecked == false) {
                              occupantFields(
                                count: 1,
                                occupantNames: occupantNames,
                                occupantPhones: occupantPhones,
                                occupantEmails: occupantEmails,
                              );
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
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.r),
                            ),
                          ),
                        ),
                        backgroundColor: const WidgetStatePropertyAll(
                          Color.fromARGB(255, 0, 239, 209),
                        ),
                      ),
                      onPressed: () async {
                        if (!isChecked) {
                          setState(() {
                            num_people.text = "1";
                          });
                        }
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });

                          final user = FirebaseAuth.instance.currentUser;

                          List<Map<String, dynamic>> occupants = [];

                          for (int i = 0; i < occupantNames.length; i++) {
                            occupants.add({
                              'name': occupantNames[i].text.trim(),
                              'phone': occupantPhones[i].text.trim(),
                              'email': occupantEmails[i].text.trim(),
                            });
                          }
                          await FirebaseFirestore.instance
                              .collection('Users')
                              .doc(user!.uid)
                              .collection('Booked hostels')
                              .doc(widget.hostel.name) // Set your own ID
                              .set({
                                'hostelname': widget.hostel.name,
                                'paid': false,
                                'isDone': false,
                                'people_booking': int.parse(num_people.text),
                                'name': name.text,
                                'occupants': occupants,
                                'email': email_address.text,
                              }, SetOptions(merge: true));
                          setState(() {
                            isLoading = false;
                          });
                          showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  builder: (_) => SelectModal(hostel: widget.hostel),
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
}
