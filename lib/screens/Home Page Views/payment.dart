import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:on_campus/screens/payable.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:on_campus/screens/bottom_nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_campus/firebase/firestore_db.dart';
import 'package:on_campus/widgets/payment_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Payment extends StatefulWidget {
  final User user;
  const Payment({super.key, required this.user});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int selectedIndex = 1;
  bool tapped = false;
  bool isLoading = false;
  bool isLoadingButton = false;
  int? expandedIndex;
  List<BookedHostels> pending = [];
  List<Hostels> pendingHostels = [];
  User? user = FirebaseAuth.instance.currentUser;

  String StructureDate(String hyphenDate) {
    String inputDate = hyphenDate; // format: dd-MM-yyyy
    DateTime date = DateFormat("dd-MM-yyyy").parse(inputDate);

    String formattedDate = DateFormat("MMMM dd, yyyy").format(date);
    debugPrint(formattedDate); // Output: July 10, 2025
    return (formattedDate);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  String formatDate(String inputDate) {
    // Original date comes as "11-13-2025"
    final parsedDate = DateFormat("MM-dd-yyyy").parse(inputDate);

    // Format month (e.g. "Feb")
    String month = DateFormat("MMM").format(parsedDate);

    // Format day and year (e.g. "13 2025")
    String dayYear = DateFormat("d yyyy").format(parsedDate);

    return "$month\n$dayYear";
  }

  Future<void> loadData() async {
    setState(() => isLoading = true);
    await getPendingPayment(); // Ensure this finishes first
    await getPendingHostelDetails(); // Then fetch hostel details
    setState(() => isLoading = false);
  }

  Future<void> getPendingPayment() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        pending = await FirestoreDb.instance.getPendingHostels(user);
        debugPrint("Pending: $pending");
      }
    } catch (e) {
      debugPrint("Error fetching payments: $e");
    }
  }

  Future<void> getPendingHostelDetails() async {
    pendingHostels.clear(); // Prevent duplicate hostels

    try {
      if (pending.isNotEmpty) {
        for (BookedHostels hostel in pending) {
          Hostels hostelDetails = await FirestoreDb.instance.getHostelsByName(
            hostel.hostel_name!,
          );
          pendingHostels.add(hostelDetails);
        }
      } else {
        debugPrint("No pending hostels");
      }
      debugPrint("Pending Hostel Details: $pendingHostels");
    } catch (e) {
      debugPrint("Error fetching hostel details: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        // appBar: AppBar(),
        body: Column(
          children: [
            Container(
              // color: Colors.red,
              height: Constant.height * 0.06,
            ),
            SizedBox(
              height: Constant.height * 0.94,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: SingleChildScrollView(
                      child: Container(
                        // color: Colors.red,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10.h),
                                  height: 40.h,
                                  width: 40.w,
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
                                SizedBox(width: 75.w),
                                Text(
                                  "Pending Payment",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.sp.clamp(0, 22),
                                    color: const Color(0xFF323232),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                margin: EdgeInsets.only(right: 10.h),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                height: 40.h,
                                width: 40.w,
                                child: Icon(
                                  Icons.close,
                                  color: const Color(0xFF323232),
                                  size: 14.h,
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Column(
                              children: [
                                isLoading
                                    ? CircularProgressIndicator()
                                    : SingleChildScrollView(
                                        child: Column(
                                          children: List.generate(pendingHostels.length, (
                                            index,
                                          ) {
                                            Hostels pendingHostel =
                                                pendingHostels[index];
                                            late BookedHostels bookedHostel;
                                            final isExpanded =
                                                expandedIndex == index;
                                            for (BookedHostels hostel
                                                in pending) {
                                              if (hostel.hostel_name ==
                                                  pendingHostel.name) {
                                                bookedHostel = hostel;
                                              }
                                            }
                                            return Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      expandedIndex = isExpanded
                                                          ? null
                                                          : index; // toggle
                                                    });
                                                  },
                                                  child: roomCard(
                                                    pendingHostel:
                                                        pendingHostel,
                                                    bookedHostel: bookedHostel,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      Constant.height * 0.05,
                                                ),
                                                if (isExpanded)
                                                  Container(
                                                    color: Colors.white,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 20.h,
                                                        ),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                left: 15.0.w,
                                                                top: 40.h,
                                                                right: 15.0.w,
                                                              ),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Booking Date",
                                                                    style: TextStyle(
                                                                      fontSize: 12
                                                                          .sp
                                                                          .clamp(
                                                                            0,
                                                                            14,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "August 08, 2024 | 4:40 PM",
                                                                    style: TextStyle(
                                                                      fontSize: 12
                                                                          .sp
                                                                          .clamp(
                                                                            0,
                                                                            14,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 20.h,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Check In",
                                                                    style: TextStyle(
                                                                      fontSize: 12
                                                                          .sp
                                                                          .clamp(
                                                                            0,
                                                                            14,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    StructureDate(
                                                                      bookedHostel
                                                                          .move_in!,
                                                                    ),
                                                                    style: TextStyle(
                                                                      fontSize: 12
                                                                          .sp
                                                                          .clamp(
                                                                            0,
                                                                            14,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 20.h,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Check Out",
                                                                    style: TextStyle(
                                                                      fontSize: 12
                                                                          .sp
                                                                          .clamp(
                                                                            0,
                                                                            14,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    StructureDate(
                                                                      bookedHostel
                                                                          .move_out!,
                                                                    ),
                                                                    style: TextStyle(
                                                                      fontSize: 12
                                                                          .sp
                                                                          .clamp(
                                                                            0,
                                                                            14,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 20.h,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Tenant",
                                                                    style: TextStyle(
                                                                      fontSize: 12
                                                                          .sp
                                                                          .clamp(
                                                                            0,
                                                                            14,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "${bookedHostel.people_booking} person(s)",
                                                                    style: TextStyle(
                                                                      fontSize: 12
                                                                          .sp
                                                                          .clamp(
                                                                            0,
                                                                            14,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                              const Divider(),
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Amount",
                                                                    style: TextStyle(
                                                                      fontSize: 12
                                                                          .sp
                                                                          .clamp(
                                                                            0,
                                                                            14,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "GH₵ ${pendingHostel.amt_per_year}",
                                                                    style: TextStyle(
                                                                      fontSize: 14
                                                                          .sp
                                                                          .clamp(
                                                                            0,
                                                                            16,
                                                                          ),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 20.h,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Tax & Fees",
                                                                    style: TextStyle(
                                                                      fontSize: 12
                                                                          .sp
                                                                          .clamp(
                                                                            0,
                                                                            14,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "GH₵ ${(pendingHostel.amt_per_year)! * 0.05}",
                                                                    style: TextStyle(
                                                                      fontSize: 14
                                                                          .sp
                                                                          .clamp(
                                                                            0,
                                                                            16,
                                                                          ),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 20.h,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Total",
                                                                    style: TextStyle(
                                                                      fontSize: 12
                                                                          .sp
                                                                          .clamp(
                                                                            0,
                                                                            14,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "GH₵ ${(((pendingHostel.amt_per_year)! * 0.05) + (pendingHostel.amt_per_year)!)}",
                                                                    style: TextStyle(
                                                                      fontSize: 14
                                                                          .sp
                                                                          .clamp(
                                                                            0,
                                                                            16,
                                                                          ),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                              Divider(
                                                                height: .2.h,
                                                              ),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Image.asset(
                                                                        "assets/payment/Simplification.png",
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25,
                                                                        color: Colors
                                                                            .black,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      Text(
                                                                        "Debit Card",
                                                                        style: TextStyle(
                                                                          fontSize: 12.sp.clamp(
                                                                            0,
                                                                            14,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  TextButton(
                                                                    child: Text(
                                                                      "Change",
                                                                      style: TextStyle(
                                                                        color: const Color.fromARGB(
                                                                          255,
                                                                          33,
                                                                          243,
                                                                          201,
                                                                        ),
                                                                        fontSize: 12
                                                                            .sp
                                                                            .clamp(
                                                                              0,
                                                                              14,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () {},
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          color: const Color(
                                                            0xFFF5F8FF,
                                                          ),
                                                          height: 20.h,
                                                        ),
                                                        Container(
                                                          // color: Colors.red,
                                                          height:
                                                              Constant.height *
                                                              0.06,
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                context,
                                                              ).width *
                                                              0.9,
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Get.to(
                                                                () => Payable(
                                                                  bookedHostel:
                                                                      bookedHostel,
                                                                  pendingHostel:
                                                                      pendingHostel,
                                                                  user: user,
                                                                  amount:
                                                                      (((pendingHostel
                                                                              .amt_per_year)! *
                                                                          0.05) +
                                                                      (pendingHostel
                                                                          .amt_per_year)!),
                                                                ),
                                                                transition:
                                                                    Transition
                                                                        .fadeIn,
                                                                duration: Duration(
                                                                  milliseconds:
                                                                      300,
                                                                ),
                                                                curve: Curves
                                                                    .easeIn,
                                                              );
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              elevation: 0,
                                                              shape: RoundedRectangleBorder(
                                                                side: BorderSide
                                                                    .none,
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      15.r,
                                                                    ),
                                                              ),
                                                              backgroundColor:
                                                                  const Color(
                                                                    0xFF00EFD1,
                                                                  ),
                                                            ),
                                                            child: SizedBox(
                                                              height:
                                                                  Constant
                                                                      .height *
                                                                  0.025,
                                                              child: FittedBox(
                                                                child: const Text(
                                                                  "Pay now",
                                                                  style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        "Poppins",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 10.h),
                                                        Container(
                                                          color: Colors.white,
                                                          height:
                                                              Constant.height *
                                                              0.06,
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                context,
                                                              ).width,
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                isScrollControlled:
                                                                    true,
                                                                builder:
                                                                    (
                                                                      BuildContext
                                                                      context,
                                                                    ) {
                                                                      return StatefulBuilder(
                                                                        builder:
                                                                            (
                                                                              BuildContext
                                                                              context,
                                                                              StateSetter
                                                                              setModalState,
                                                                            ) {
                                                                              return Container(
                                                                                height:
                                                                                    Constant.height *
                                                                                    0.6,
                                                                                // decoration: BoxDecoration(),
                                                                                child: Column(
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      height:
                                                                                          Constant.height *
                                                                                          0.025,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height:
                                                                                          Constant.height *
                                                                                          0.04,
                                                                                      child: FittedBox(
                                                                                        child: Text(
                                                                                          "Cancel this Booking?",
                                                                                          style: TextStyle(
                                                                                            fontSize: 25,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontFamily: "Poppins",
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    // SizedBox(
                                                                                    //   height: 15,
                                                                                    // ),
                                                                                    SizedBox(
                                                                                      height:
                                                                                          Constant.height *
                                                                                          0.07,
                                                                                      width:
                                                                                          Constant.width *
                                                                                          0.8,
                                                                                      child: FittedBox(
                                                                                        child: Text(
                                                                                          "This action will permanently delete your\nbooking.",
                                                                                          style: TextStyle(
                                                                                            fontSize: 16,
                                                                                            color: Color(
                                                                                              0xFFB0B0B0,
                                                                                            ),
                                                                                            fontFamily: "Montserrat",
                                                                                            fontWeight: FontWeight.w500,
                                                                                          ),
                                                                                          textAlign: TextAlign.center,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width:
                                                                                          Constant.width *
                                                                                          0.4,
                                                                                      height:
                                                                                          Constant.height *
                                                                                          0.2,
                                                                                      child: ClipRRect(
                                                                                        borderRadius: BorderRadiusGeometry.circular(
                                                                                          10,
                                                                                        ),
                                                                                        child: Image.asset(
                                                                                          "assets/payment/paymentImage.png",
                                                                                          fit: BoxFit.cover,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 20,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height:
                                                                                          Constant.height *
                                                                                          0.08,
                                                                                      width:
                                                                                          Constant.width *
                                                                                          0.8,
                                                                                      child: FittedBox(
                                                                                        child: Text(
                                                                                          "Your booking was made on May 17, 2025",
                                                                                          style: TextStyle(
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontFamily: "Poppins",
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 15,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height:
                                                                                          Constant.height *
                                                                                          0.06,
                                                                                      width:
                                                                                          MediaQuery.sizeOf(
                                                                                            context,
                                                                                          ).width *
                                                                                          0.9,
                                                                                      child: ElevatedButton(
                                                                                        onPressed: () async {
                                                                                          setModalState(
                                                                                            () {
                                                                                              isLoadingButton = true;
                                                                                            },
                                                                                          );
                                                                                          await FirebaseFirestore.instance
                                                                                              .collection(
                                                                                                'Users',
                                                                                              )
                                                                                              .doc(
                                                                                                user!.uid,
                                                                                              )
                                                                                              .collection(
                                                                                                'Booked hostels',
                                                                                              )
                                                                                              .doc(
                                                                                                bookedHostel.hostel_name,
                                                                                              ) // document ID
                                                                                              .delete();
                                                                                          setModalState(
                                                                                            () {
                                                                                              isLoadingButton = false;
                                                                                            },
                                                                                          );

                                                                                          showModalBottomSheet(
                                                                                            context: context,
                                                                                            isScrollControlled: true,
                                                                                            isDismissible: false,
                                                                                            builder:
                                                                                                (
                                                                                                  BuildContext context,
                                                                                                ) {
                                                                                                  return StatefulBuilder(
                                                                                                    builder:
                                                                                                        (
                                                                                                          BuildContext context,
                                                                                                          StateSetter setModalState,
                                                                                                        ) {
                                                                                                          return IntrinsicHeight(
                                                                                                            child: Padding(
                                                                                                              padding: const EdgeInsets.symmetric(
                                                                                                                horizontal: 20.0,
                                                                                                              ),
                                                                                                              child: Container(
                                                                                                                child: Column(
                                                                                                                  children: [
                                                                                                                    SizedBox(
                                                                                                                      height: 30,
                                                                                                                    ),
                                                                                                                    Align(
                                                                                                                      child: Image.asset(
                                                                                                                        "assets/payment/bin.png",
                                                                                                                        height: 110.h,
                                                                                                                        width: 100.w,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    SizedBox(
                                                                                                                      height: 5,
                                                                                                                    ),
                                                                                                                    SizedBox(
                                                                                                                      height:
                                                                                                                          Constant.height *
                                                                                                                          0.03,
                                                                                                                      child: FittedBox(
                                                                                                                        child: Text(
                                                                                                                          "Booking Cancelled",
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),

                                                                                                                    SizedBox(
                                                                                                                      height:
                                                                                                                          Constant.height *
                                                                                                                          0.07,
                                                                                                                      width:
                                                                                                                          Constant.width *
                                                                                                                          0.8,
                                                                                                                      child: FittedBox(
                                                                                                                        child: Text(
                                                                                                                          "Your reservation for Room 406 has been \n successfully cancelled.",
                                                                                                                          textAlign: TextAlign.center,
                                                                                                                          style: TextStyle(
                                                                                                                            fontFamily: "Outfit",
                                                                                                                            fontWeight: FontWeight.w400,
                                                                                                                            color: Color(
                                                                                                                              0xFF666666,
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    SizedBox(
                                                                                                                      height: 15,
                                                                                                                    ),
                                                                                                                    SizedBox(
                                                                                                                      width: MediaQuery.of(
                                                                                                                        context,
                                                                                                                      ).size.width,
                                                                                                                      height:
                                                                                                                          Constant.height *
                                                                                                                          0.06,
                                                                                                                      child: ElevatedButton(
                                                                                                                        onPressed: () async {
                                                                                                                          Navigator.pushReplacement(
                                                                                                                            context,
                                                                                                                            MaterialPageRoute(
                                                                                                                              builder:
                                                                                                                                  (
                                                                                                                                    context,
                                                                                                                                  ) => BottomNav(
                                                                                                                                    username:
                                                                                                                                        FirebaseAuth.instance.currentUser?.displayName ??
                                                                                                                                        "User",
                                                                                                                                  ),
                                                                                                                            ),
                                                                                                                          );
                                                                                                                        },
                                                                                                                        style: ElevatedButton.styleFrom(
                                                                                                                          elevation: 0,
                                                                                                                          shape: RoundedRectangleBorder(
                                                                                                                            side: BorderSide.none,
                                                                                                                            borderRadius: BorderRadius.circular(
                                                                                                                              15.r,
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                          backgroundColor: const Color(
                                                                                                                            0xFF00EFD1,
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                        child: SizedBox(
                                                                                                                          height:
                                                                                                                              Constant.height *
                                                                                                                              0.025,
                                                                                                                          child: FittedBox(
                                                                                                                            child: Text(
                                                                                                                              "Back",
                                                                                                                              style: TextStyle(
                                                                                                                                color: Colors.white,
                                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    SizedBox(
                                                                                                                      height: 30,
                                                                                                                    ),
                                                                                                                  ],
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          );
                                                                                                        },
                                                                                                  );
                                                                                                },
                                                                                          );
                                                                                        },
                                                                                        style: ElevatedButton.styleFrom(
                                                                                          elevation: 0,
                                                                                          shape: RoundedRectangleBorder(
                                                                                            side: BorderSide.none,
                                                                                            borderRadius: BorderRadius.circular(
                                                                                              15.r,
                                                                                            ),
                                                                                          ),
                                                                                          backgroundColor: const Color(
                                                                                            0xFF00EFD1,
                                                                                          ),
                                                                                        ),
                                                                                        child: isLoadingButton
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
                                                                                                    SizedBox(
                                                                                                      width: 5,
                                                                                                    ),
                                                                                                    Text(
                                                                                                      "Please wait..",
                                                                                                      style: TextStyle(
                                                                                                        color: Colors.white,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              )
                                                                                            : SizedBox(
                                                                                                height:
                                                                                                    Constant.height *
                                                                                                    0.025,
                                                                                                child: FittedBox(
                                                                                                  child: Text(
                                                                                                    "Yes, Cancel",
                                                                                                    style: TextStyle(
                                                                                                      color: Colors.white,
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontFamily: "Outfit",
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                      ),
                                                                                    ),

                                                                                    SizedBox(
                                                                                      height: 60.h,
                                                                                      width: MediaQuery.sizeOf(
                                                                                        context,
                                                                                      ).width,
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.symmetric(
                                                                                          vertical: 8.0.h,
                                                                                          horizontal: 12.w,
                                                                                        ),
                                                                                        child: ElevatedButton(
                                                                                          onPressed: () {
                                                                                            Navigator.of(
                                                                                              context,
                                                                                            ).pop();
                                                                                          },
                                                                                          style: ElevatedButton.styleFrom(
                                                                                            elevation: 0,
                                                                                            shape: RoundedRectangleBorder(
                                                                                              side: BorderSide.none,
                                                                                              borderRadius: BorderRadius.circular(
                                                                                                15.r,
                                                                                              ),
                                                                                            ),
                                                                                            backgroundColor: Colors.transparent,
                                                                                          ),
                                                                                          child: const Text(
                                                                                            "No",
                                                                                            style: TextStyle(
                                                                                              color: Colors.black,
                                                                                              fontFamily: "Outfit",
                                                                                              fontWeight: FontWeight.bold,
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
                                                                    },
                                                              );
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              elevation: 0,
                                                              shape: RoundedRectangleBorder(
                                                                side: BorderSide
                                                                    .none,
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      15.r,
                                                                    ),
                                                              ),
                                                              backgroundColor:
                                                                  Colors
                                                                      .red[50],
                                                            ),
                                                            child: SizedBox(
                                                              height:
                                                                  Constant
                                                                      .height *
                                                                  0.025,
                                                              child: FittedBox(
                                                                child: const Text(
                                                                  "Cancel Booking",
                                                                  style: TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                              ],
                                            );
                                          }),
                                        ),
                                      ),
                              ],
                            ),

                            SizedBox(height: 100.h),
                          ],
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
