import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/firebase/firestore_db.dart';
import 'package:on_campus/widgets/payment_widgets.dart';

class PaidPayment extends StatefulWidget {
  final User user;
  const PaidPayment({super.key, required this.user});

  @override
  State<PaidPayment> createState() => _PaidPaymentState();
}

class _PaidPaymentState extends State<PaidPayment> {
  int selectedIndex = 1;
  bool tapped = false;
  bool isLoading = false;
  int? expandedIndex;
  List<BookedHostels> paid = [];
  List<Hostels> paidHostels = [];
  User? user = FirebaseAuth.instance.currentUser;

  String StructureDate(String hyphenDate) {
    String inputDate = hyphenDate; // format: dd-MM-yyyy
    DateTime date = DateFormat("dd-MM-yyyy").parse(inputDate);

    String formattedDate = DateFormat("MMMM dd, yyyy").format(date);
    print(formattedDate); // Output: July 10, 2025
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
    await getpaidPayment(); // Ensure this finishes first
    await getpaidHostelDetails(); // Then fetch hostel details
    setState(() => isLoading = false);
  }

  Future<void> getpaidPayment() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        paid = await FirestoreDb.instance.getPaidHostels(user);
        print("paid: $paid");
      }
    } catch (e) {
      print("Error fetching payments: $e");
    }
  }

  Future<void> getpaidHostelDetails() async {
    paidHostels.clear(); // Prevent duplicate hostels

    try {
      if (paid.isNotEmpty) {
        for (BookedHostels hostel in paid) {
          Hostels hostelDetails = await FirestoreDb.instance.getHostelsByName(
            hostel.hostel_name!,
          );
          paidHostels.add(hostelDetails);
        }
      } else {
        print("No paid hostels");
      }
      print("paid Hostel Details: $paidHostels");
    } catch (e) {
      print("Error fetching hostel details: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        // appBar: AppBar(),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: Constant.height * 0.06),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
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
                          SizedBox(
                            height: Constant.height * 0.03,
                            child: FittedBox(
                              child: Text(
                                "Payment History",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.sp.clamp(0, 22),
                                  color: const Color(0xFF323232),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 10.h),
                          decoration: BoxDecoration(
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
                                    children: List.generate(
                                      paidHostels.length,
                                      (index) {
                                        Hostels paidHostel = paidHostels[index];
                                        late BookedHostels bookedHostel;
                                        final isExpanded =
                                            expandedIndex == index;
                                        for (BookedHostels hostel in paid) {
                                          if (hostel.hostel_name ==
                                              paidHostel.name) {
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
                                              pendingHostel: paidHostels[index],
                                              bookedHostel: bookedHostel,
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          if (isExpanded)
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 10.h,
                                              ),
                                              child: Card(
                                                child: Container(
                                                  color: Colors.white,
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
                                                              height: 20.h,
                                                            ),
                                                            const Divider(),
                                                            SizedBox(
                                                              height: 20.h,
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
                                                                  "GH₵ ${paidHostel.amt_per_year}",
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
                                                                  "GH₵ ${(paidHostel.amt_per_year)! * 0.05}",
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
                                                                  "GH₵ ${(((paidHostel.amt_per_year)! * 0.05) + (paidHostel.amt_per_year)!)}",
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
                                                                Container(
                                                                  height: Constant.height * 0.05,
                                                                  color: Colors
                                                                      .white,
                                                                  // height:
                                                                  //     25.h,
                                                                  // width:
                                                                  child: ElevatedButton(
                                                                    onPressed:
                                                                        () {},
                                                                    style: ElevatedButton.styleFrom(
                                                                      elevation:
                                                                          0,
                                                                      shape: RoundedRectangleBorder(
                                                                        side:
                                                                            BorderSide.none,
                                                                        borderRadius: BorderRadius.circular(
                                                                          15.r,
                                                                        ),
                                                                      ),
                                                                      backgroundColor:
                                                                          const Color(
                                                                            0xFF00EFD1,
                                                                          ),
                                                                    ),
                                                                    child: Align(
                                                                      child: SizedBox(
                                                                        height: Constant.height * 0.025,
                                                                        child: FittedBox(
                                                                          child: const Text(
                                                                            "View Receipt",
                                                                            style: TextStyle(
                                                                              color:
                                                                                  Colors.white,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontFamily: "Poppins"
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {},
                                                                  child: Text(
                                                                    "Paid",
                                                                    style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight.w600,
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
                                            ),
                                          ]
                                        );
                                      },
                                    ),
                                  ),

                                  /*                                 Column(
                                    children: List.generate(paidHostels.length, (
                                      index,
                                    ) {
                                      Hostels paidHostel = paidHostels[index];
                                      late BookedHostels bookedHostel;
                                      final isExpanded =
                                          expandedIndex == index;
                                      for (BookedHostels hostel in paid) {
                                        if (hostel.hostel_name ==
                                            paidHostel.name) {
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
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 10.h,
                                              ),
                                              child: Card(
                                                color: Colors.white,
                                                child: Container(
                                                  padding:
                                                      EdgeInsets.symmetric(
                                                        horizontal: 15.h,
                                                        vertical: 20.h,
                                                      ),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 100.w,
                                                        height: 90.h,
                                                        child: Stack(
                                                          children: [
                                                            SizedBox(
                                                              width: 100.w,
                                                              height: 90.h,
                                                              child: Image.asset(
                                                                "assets/payment/paymentImage.png",
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets.all(
                                                                      5.0.r,
                                                                    ),
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          50.r,
                                                                        ),
                                                                  ),
                                                                  child: Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                          2.0.r,
                                                                        ),
                                                                    child: const Icon(
                                                                      Icons
                                                                          .favorite_border,
                                                                      size:
                                                                          17,
                                                                      color: Color.fromARGB(
                                                                        255,
                                                                        33,
                                                                        243,
                                                                        201,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                left: 5.0.w,
                                                              ),
                                                          child: SizedBox(
                                                            // height: 90.h,
                                                            // width: MediaQuery.sizeOf(context).width,
                                                            // color: Colors.red,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      bookedHostel.hostel_name ??
                                                                          "",
                                                                      style: TextStyle(
                                                                        fontSize: 16.sp.clamp(
                                                                          0,
                                                                          18,
                                                                        ),
                                                                        fontFamily:
                                                                            "Roboto",
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        letterSpacing:
                                                                            0.15.w,
                                                                        color: Color.fromARGB(
                                                                          255,
                                                                          58,
                                                                          48,
                                                                          74,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons.star,
                                                                          size: 15.sp.clamp(
                                                                            0,
                                                                            17,
                                                                          ),
                                                                          color: const Color.fromARGB(
                                                                            255,
                                                                            33,
                                                                            243,
                                                                            201,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          "${paidHostel.rate}",
                                                                          style: TextStyle(
                                                                            fontFamily: "Roboto",
                                                                            color: const Color(
                                                                              0xFF323232,
                                                                            ),
                                                                            fontSize: 13.sp.clamp(
                                                                              0,
                                                                              15,
                                                                            ),
                                                                            fontWeight: FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .location_on_outlined,
                                                                      size: 10
                                                                          .sp
                                                                          .clamp(
                                                                            0,
                                                                            12,
                                                                          ),
                                                                    ),
                                                                    Text(
                                                                      "${paidHostel.city},  ${paidHostel.region}",
                                                                      style: TextStyle(
                                                                        fontFamily:
                                                                            "Roboto",
                                                                        color: const Color(
                                                                          0xFF333333,
                                                                        ),
                                                                        fontSize: 10.sp.clamp(
                                                                          0,
                                                                          12,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 2.h,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: SizedBox(
                                                                    width:
                                                                        MediaQuery.sizeOf(
                                                                          context,
                                                                        ).width *
                                                                        0.5.w,
                                                                    child: SizedBox(
                                                                      child: Text(
                                                                        "    Wifi • Shower • Kitchen • Security •\n Parking • Balcony • Friendly Environment",
                                                                        overflow:
                                                                            TextOverflow.visible,
                                                                        style: TextStyle(
                                                                          fontSize: 9.sp.clamp(
                                                                            0,
                                                                            11,
                                                                          ),
                                                                          fontFamily:
                                                                              "Roboto",
                                                                          color: const Color(
                                                                            0xFF1D1B20,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 2.h,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: Text(
                                                                    "Price Estimate",
                                                                    style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontSize: 12
                                                                          .sp
                                                                          .clamp(
                                                                            0,
                                                                            14,
                                                                          ),
                                                                      color: const Color(
                                                                        0xFF323232,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.15.w,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      "GH₵ ${paidHostel.amt_per_year}/",
                                                                      style: TextStyle(
                                                                        fontFamily:
                                                                            "Poppins",
                                                                        fontSize: 18.sp.clamp(
                                                                          0,
                                                                          20,
                                                                        ),
                                                                        color: const Color(
                                                                          0xFF323232,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "Academic Year",
                                                                      style: TextStyle(
                                                                        fontFamily:
                                                                            "Poppins",
                                                                        fontSize: 12.sp.clamp(
                                                                          0,
                                                                          14,
                                                                        ),
                                                                        color: const Color(
                                                                          0xFF323232,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),









                                          if (isExpanded)
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 10.h,
                                              ),
                                              child: Card(
                                                child: Container(
                                                  color: Colors.white,
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
                                                              height: 20.h,
                                                            ),
                                                            const Divider(),
                                                            SizedBox(
                                                              height: 20.h,
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
                                                                  "GH₵ ${paidHostel.amt_per_year}",
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
                                                                  "GH₵ ${(paidHostel.amt_per_year)! * 0.05}",
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
                                                                  "GH₵ ${(((paidHostel.amt_per_year)! * 0.05) + (paidHostel.amt_per_year)!)}",
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
                                                                Container(
                                                                  color: Colors
                                                                      .white,
                                                                  height:
                                                                      25.h,
                                                                  // width:
                                                                  child: ElevatedButton(
                                                                    onPressed:
                                                                        () {},
                                                                    style: ElevatedButton.styleFrom(
                                                                      elevation:
                                                                          0,
                                                                      shape: RoundedRectangleBorder(
                                                                        side:
                                                                            BorderSide.none,
                                                                        borderRadius: BorderRadius.circular(
                                                                          15.r,
                                                                        ),
                                                                      ),
                                                                      backgroundColor:
                                                                          const Color(
                                                                            0xFF00EFD1,
                                                                          ),
                                                                    ),
                                                                    child: const Text(
                                                                      "View Receipt",
                                                                      style: TextStyle(
                                                                        color:
                                                                            Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {},
                                                                  child: Text(
                                                                    "Paid",
                                                                    style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight.w600,
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
                                            ),






                                        ],
                                      );
                                    }),
                                  ),
*/
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
    );
  }
}
