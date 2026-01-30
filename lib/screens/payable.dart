import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paystack_for_flutter/paystack_for_flutter.dart';
import 'package:on_campus/screens/Home%20Page%20Views/history.dart';

class Payable extends StatefulWidget {
  final BookedHostels bookedHostel;
  final Hostels pendingHostel;
  final User? user;
  final double amount;
  const Payable({
    super.key,
    required this.bookedHostel,
    required this.pendingHostel,
    required this.user,
    required this.amount,
  });

  @override
  State<Payable> createState() => _PayableState();
}

class _PayableState extends State<Payable> {
  // String secretKey = "sk_test_13937ae4f88036bbec93c978710a821d598fe708";
String secretKey = dotenv.env['PAYSTACK_SECRET_KEY']!;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: Constant.height * 0.025,
              child: FittedBox(
                child: Text(
                  "Payable Amount",
                  style: TextStyle(
                    fontFamily: "Outfit",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: Constant.height * 0.055,
              child: FittedBox(
                child: Text(
                  "GHS ${widget.bookedHostel.amount}",
                  style: TextStyle(
                    fontSize: 32.sp.clamp(0, 32),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 25,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/user_interface_icons/payment_process_icons/wall2.svg',
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(width: 5),
                            SizedBox(
                              height: 22,
                              width: 50,

                              child: FilledButton(
                                onPressed: () {},
                                style: FilledButton.styleFrom(
                                  backgroundColor: Color(0xFF00EFD1),
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                ),
                                child: SizedBox(
                                  height: Constant.height * 0.025,
                                  child: FittedBox(
                                    child: Text(
                                      "  Room  ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Constant.height * 0.025,
                          child: FittedBox(
                            child: Text(
                              "Room 406",
                              style: TextStyle(
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Divider(thickness: .5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: Constant.height * 0.025,
                          child: FittedBox(
                            child: Text(
                              "Name",
                              style: TextStyle(
                                fontFamily: "Outfit",
                                fontSize: 12.sp.clamp(0, 12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Constant.height * 0.025,
                          child: FittedBox(
                            child: Text(
                              "${widget.user?.displayName}",
                              style: TextStyle(
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Divider(thickness: .5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: Constant.height * 0.025,
                          child: FittedBox(
                            child: Text(
                              "Room type",
                              style: TextStyle(fontSize: 12.sp.clamp(0, 12)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Constant.height * 0.025,
                          child: FittedBox(
                            child: Text(
                              "4-in-a Room",
                              style: TextStyle(
                                fontFamily: "Outift",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Divider(thickness: .5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: Constant.height * 0.025,
                          child: FittedBox(
                            child: Text(
                              "No. of students",
                              style: TextStyle(fontSize: 12.sp.clamp(0, 12)),
                            ),
                          ),
                        ),
                        Text(
                          "${widget.bookedHostel.people_booking}",
                          style: TextStyle(
                            fontFamily: "Outfit",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Divider(thickness: .5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: Constant.height * 0.025,
                          child: FittedBox(
                            child: Text(
                              "Number of years",
                              style: TextStyle(fontSize: 12.sp.clamp(0, 12)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Constant.height * 0.025,
                          child: FittedBox(
                            child: Text(
                              "${widget.bookedHostel.duration} Year(s)",
                              style: TextStyle(
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Divider(thickness: .5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: Constant.height * 0.025,
                          child: FittedBox(
                            child: Text(
                              "Date of move in",
                              style: TextStyle(fontSize: 12.sp.clamp(0, 12)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Constant.height * 0.025,
                          child: FittedBox(
                            child: Text(
                              "${widget.bookedHostel.move_in}",
                              style: TextStyle(
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Divider(thickness: .5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: Constant.height * 0.025,
                          child: FittedBox(
                            child: Text(
                              "Date of move out",
                              style: TextStyle(fontSize: 12.sp.clamp(0, 12)),
                            ),
                          ),
                        ),
                        Text(
                          "${widget.bookedHostel.move_in}",
                          style: TextStyle(
                            fontFamily: "Outift",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Divider(thickness: .5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: Constant.height * 0.025,
                          child: FittedBox(
                            child: Text(
                              "Payment method",
                              style: TextStyle(fontSize: 12.sp.clamp(0, 12)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Constant.height * 0.025,
                          child: FittedBox(
                            child: Text(
                              "Mobile Money",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Divider(thickness: .5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: Constant.height * 0.025,
                          child: FittedBox(
                            child: Text(
                              "Phone number",
                              style: TextStyle(fontSize: 12.sp.clamp(0, 12)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Constant.height * 0.025,
                          child: FittedBox(
                            child: Text(
                              // "${FirestoreDb.instance.getUserInfo(widget.user).}",
                              "0552296265",
                              style: TextStyle(
                                fontFamily: "Outift",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Divider(thickness: .5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: Constant.height * 0.025,
                          child: FittedBox(
                            child: Text(
                              "Email address",
                              style: TextStyle(fontSize: 12.sp.clamp(0, 12)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Constant.height * 0.03,
                          width: Constant.width * 0.5,
                          child: FittedBox(
                            child: Text(
                              overflow: TextOverflow.clip,
                              "${widget.user?.email}",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 100),
          ],
        ),
      ),
      bottomSheet: Container(
        height: Constant.height * 0.08,
        color: Colors.white,
        child: Align(
          child: SizedBox(
            height: Constant.height * 0.06,
            width: Constant.width * 0.9,
            child: ElevatedButton(
              onPressed: () async {
                await PaystackFlutter().pay(
                  context: context,
                  secretKey: secretKey, // Your Paystack secret key.
                  amount:
                      (widget.amount) *
                      100, // The amount to be charged in the smallest currency unit. If amount is 600, multiply by 100(600*100)
                  email:
                      '${widget.user?.email}', // The customer's email address.
                  firstName:
                      '${widget.user?.displayName!.split(" ")[0]}', // Customer's first name
                  lastName:
                      '${widget.user?.displayName!.split(" ").last}', // Customer's last name
                  callbackUrl:
                      'https://callback.com', // The URL to which Paystack will redirect the user after the transaction.
                  showProgressBar:
                      true, // If true, it shows progress bar to inform user an action is in progress when getting checkout link from Paystack.
                  paymentOptions: [
                    PaymentOption.card,
                    PaymentOption.bankTransfer,
                    PaymentOption.mobileMoney,
                  ],
                  currency: Currency.GHS,
                  metaData: {
                    "hostel_name": widget.bookedHostel.hostel_name,
                    "price": widget.amount,
                  }, // Additional metadata to be associated with the transaction
                  onSuccess: (paystackCallback) async {
                    await FirebaseFirestore.instance
                        .collection('Users')
                        .doc(widget.user!.uid)
                        .collection('Booked hostels')
                        .doc(widget.bookedHostel.hostel_name) // Set your own ID
                        .set({'paid': true}, SetOptions(merge: true));
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      barrierColor: const Color.fromRGBO(0, 0, 0, 0.3), // Dim background
                      builder: (context) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 5,
                            sigmaY: 5,
                          ), // Blur background
                          child: Dialog(
                            backgroundColor: Colors.white.withOpacity(
                              0.5,
                            ), // Translucent
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Check Icon
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xFF00EFD1),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 40,
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  SizedBox(
                                    height: Constant.height * 0.03,
                                    child: FittedBox(
                                      child: const Text(
                                        "Thank You!",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  SizedBox(
                                    height: Constant.height * 0.06,
                                    child: FittedBox(
                                      child: const Text(
                                        "Your hostel room has been booked\nEnjoy Your Day!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 25),

                                  // Button
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Get.to(() => History());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: Color(0xFF00EFD1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 15,
                                        ),
                                      ),
                                      child: SizedBox(
                                        height: Constant.height * 0.025,
                                        child: FittedBox(
                                          child: const Text(
                                            "Go to My Bookings",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }, // A callback function for when the payment is successful.
                  onCancelled: (paystackCallback) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Transaction Failed/Not successful::::${paystackCallback.reference}',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }, // A callback function for when the payment is canceled/unsuccessful.
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
              child: Center(
                child: SizedBox(
                  height: Constant.height * 0.03,
                  child: FittedBox(
                    child: Text(
                      "Proceed",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19.sp.clamp(0, 19),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
