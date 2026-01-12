import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:on_campus/firebase/firestore_db.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_campus/screens/Home%20Page%20Views/payment.dart';
import 'package:on_campus/screens/Home%20Page%20Views/paid_payment.dart';

class Bookings extends StatefulWidget {
  const Bookings({super.key});

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  List<BookedHostels> paid = [];
  List<BookedHostels> pending = [];
  List<Hostels> pendingHostels = [];
  List<Hostels> paidHostels = [];
  bool isLoading = false;
  bool isPaidSelected = false;
  User? user = FirebaseAuth.instance.currentUser;

  // String formatDate(String inputDate) {
  //   // Original date comes as "11-13-2025"
  //   final parsedDate = DateFormat("MM-dd-yyyy").parse(inputDate);

  //   // Format month (e.g. "Feb")
  //   String month = DateFormat("MMM").format(parsedDate);

  //   // Format day and year (e.g. "13 2025")
  //   String dayYear = DateFormat("d yyyy").format(parsedDate);

  //   return "$month\n$dayYear";
  // }

  List<String> format(String inputDate) {
    // Original date comes as "11-13-2025"
    final parsedDate = DateFormat("MM-dd-yyyy").parse(inputDate);

    // Format month (e.g. "Feb")
    String month = DateFormat("MMM").format(parsedDate);

    // Format day and year (e.g. "13 2025")
    String dayYear = DateFormat("d yyyy").format(parsedDate);

    //debugPrint("this is the value of month: $month");
    //debugPrint("this is the value of dayYear: $dayYear");

    return [month, dayYear];
  }

  @override
  void initState() {
    super.initState();
    loadData();
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
        paid = await FirestoreDb.instance.getPaidHostels(user);
        //debugPrint("Pending: $pending");
      }
    } catch (e) {
      //debugPrint("Error fetching payments: $e");
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
        //debugPrint("No pending hostels");
      }
      if (paid.isNotEmpty) {
        for (BookedHostels hostel in paid) {
          Hostels hostelDetails = await FirestoreDb.instance.getHostelsByName(
            hostel.hostel_name!,
          );
          paidHostels.add(hostelDetails);
        }
      } else {
        //debugPrint("No approved hostels");
      }
      //debugPrint("Pending Hostel Details: $pendingHostels");
    } catch (e) {
      //debugPrint("Error fetching hostel details: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromRGBO(118, 182, 234, 0.1),
          padding: EdgeInsets.only(top: Constant.height * 0.06),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.r),
            child: Column(
              children: [
                SizedBox(height: 30.h),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 255, .4),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        height: 30.h,
                        width: 30.w,
                        child: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        widthFactor: MediaQuery.sizeOf(context).width.w,
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: Constant.height * 0.035,
                            child: FittedBox(
                              child: Text(
                                "My Bookings",
                                style: TextStyle(
                                  fontSize: 15.5.sp.clamp(0, 17.5),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xfff1f1f1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => isPaidSelected = true),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            transitionBuilder: (child, animation) =>
                                FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                            child: AnimatedContainer(
                              width: 130,
                              height: 30,
                              key: ValueKey(isPaidSelected), // IMPORTANT
                              duration: const Duration(milliseconds: 400),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isPaidSelected
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SizedBox(
                                height: Constant.height * 0.025,
                                child: FittedBox(
                                  child: Text(
                                    "Approved",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: isPaidSelected
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => isPaidSelected = false),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            transitionBuilder: (child, animation) =>
                                FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                            child: AnimatedContainer(
                              width: 130,
                              height: 30,
                              key: ValueKey(!isPaidSelected), // IMPORTANT
                              duration: const Duration(milliseconds: 400),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: !isPaidSelected
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SizedBox(
                                height: Constant.height * 0.025,
                                child: FittedBox(
                                  child: Text(
                                    "Pending",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: !isPaidSelected
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: isPaidSelected
                      ? Approved(key: const ValueKey('B'))
                      : Pending(key: const ValueKey('A')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Pending({required Key key}) {
    return isLoading
        ? SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: Center(child: CircularProgressIndicator()),
          )
        : pendingHostels.isEmpty
        ? SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: Center(child: Text("There are no pending hostels")),
          )
        : SizedBox(
            // color: Colors.blue,
            key: key,
            height: Constant.height - Constant.height * 0.2,
            child: ListView.builder(
              itemCount: pendingHostels.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                Hostels pendingHostel = pendingHostels[index];
                late BookedHostels bookedHostel;
                for (BookedHostels hostel in pending) {
                  if (hostel.hostel_name == pendingHostels[index].name) {
                    bookedHostel = hostel;
                  }
                }
                // final isExpanded = expandedIndex == index;
                return GestureDetector(
                  onTap: () async {
                    Get.to(() => Payment(user: user!, subject: "Booking"));
                  },
                  child: Column(
                    children: [
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: SizedBox(
                            width: Constant.height * 0.83,

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // margin: EdgeInsets.only(right: 10.h),
                                  height: Constant.height * 0.25,
                                  decoration: BoxDecoration(
                                    // color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.r),
                                      topRight: Radius.circular(12.r),
                                      bottomLeft: Radius.circular(12.r),
                                      bottomRight: Radius.circular(12.r),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        left: 0,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12.r),
                                            topRight: Radius.circular(12.r),
                                          ),
                                          child: Image.asset(
                                            "assets/hostels_detail/hostel-2.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 30,
                                        left: 12,
                                        child: SizedBox(
                                          height: 28,
                                          width: 100,
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              backgroundColor: Colors.white,
                                              // foregroundColor: Colors.white,
                                            ),

                                            child: Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                height: Constant.height * 0.025,
                                                child: FittedBox(
                                                  child: Text(
                                                    "Pending",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "Poppins",
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        bottom: 10,
                                        left: 12,
                                        child: SizedBox(
                                          height: 25.h,
                                          // width: 70,
                                          child: ElevatedButton(
                                            // style: RoundedRectangleBorder(),
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(0),
                                              backgroundColor: Colors.white,
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.star_outline,
                                                    size: 20,
                                                    color: Color.fromARGB(
                                                      255,
                                                      0,
                                                      239,
                                                      209,
                                                    ),
                                                  ),
                                                  SizedBox(width: 3),
                                                  SizedBox(
                                                    height:
                                                        Constant.height * 0.025,
                                                    child: FittedBox(
                                                      child: Text(
                                                        "${pendingHostel.rate}",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: "Poppins",
                                                          color: Colors.black,
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
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 0.0,
                                    horizontal: 8,
                                  ),
                                  child: SizedBox(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height:
                                                      Constant.height * 0.04,
                                                  child: FittedBox(
                                                    child: Text(
                                                      pendingHostel.name,
                                                      style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20.sp.clamp(
                                                          0,
                                                          22,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "${pendingHostel.city}, ${pendingHostel.region}",
                                                          style: TextStyle(
                                                            fontSize: 12.sp
                                                                .clamp(0, 18),
                                                            fontFamily:
                                                                "Poppins",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            letterSpacing:
                                                                0.15.w,
                                                            color: const Color(
                                                              0xFF323232,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(width: 5),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                // color: Colors.red,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Text.rich(
                                                        TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: "From\n",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12.sp
                                                                    .clamp(
                                                                      0,
                                                                      12,
                                                                    ),
                                                                color:
                                                                    const Color(
                                                                      0xFF323232,
                                                                    ),
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  "GH₵ ${pendingHostel.amt_per_year} ",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold, // Only "GH₵" is bold
                                                                fontSize: 12.sp
                                                                    .clamp(
                                                                      0,
                                                                      12,
                                                                    ),
                                                                color:
                                                                    const Color(
                                                                      0xFF323232,
                                                                    ),
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  "\nper year",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12.sp
                                                                    .clamp(
                                                                      0,
                                                                      12,
                                                                    ),
                                                                color:
                                                                    const Color(
                                                                      0xFF323232,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        textAlign: TextAlign
                                                            .right, // Aligns all text to the right
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: Constant.width * 0.45,
                                              height: Constant.height * 0.06,
                                              // color: Colors.red,
                                              child: FittedBox(
                                                alignment: Alignment.centerLeft,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      // "${formatDate(bookedHostel.move_in ?? "")} ",
                                                      format(
                                                        bookedHostel.move_in ??
                                                            "",
                                                      )[0],
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    // Text(" - "),
                                                    Text(
                                                      "${format(bookedHostel.move_in ?? "")[1]} - ${format(bookedHostel.move_out ?? "")[1]} ",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 1, // Thickness of the line
                                              height:
                                                  40, // Height of the divider
                                              color: Colors
                                                  .grey, // Color of the divider
                                            ),
                                            Expanded(
                                              // flex: 2,
                                              child: Container(
                                                // color: Colors.blue,
                                                width: Constant.width * 0.45,
                                                height: Constant.height * 0.06,
                                                child: FittedBox(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    textAlign: TextAlign.right,
                                                    "  ${pendingHostel.city}\n${pendingHostel.region}",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      fontFamily: "Poppins",
                                                    ),
                                                    softWrap:
                                                        true, // Allows multi-line wrapping
                                                    maxLines: 2,
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
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                );
              },
            ),
          );
  }

  Widget Approved({required Key key}) {
    return isLoading
        ? SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: Center(child: CircularProgressIndicator()),
          )
        : paidHostels.isEmpty
        ? SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: Center(child: Text("There are no approved hostels")),
          )
        : SizedBox(
            // color: Colors.blue,
            key: key,
            height: Constant.height - Constant.height * 0.2,
            child: ListView.builder(
              itemCount: paidHostels.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                Hostels paidHostel = paidHostels[index];
                late BookedHostels bookedHostel;
                for (BookedHostels hostel in paid) {
                  if (hostel.hostel_name == paidHostels[index].name) {
                    bookedHostel = hostel;
                  }
                }
                // final isExpanded = expandedIndex == index;
                return GestureDetector(
                  onTap: () async {
                    Get.to(
                      () =>
                          PaidPayment(user: user!, subject: "Approved Booking"),
                    );
                  },
                  child: Column(
                    children: [
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: SizedBox(
                            width: Constant.height * 0.83,

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // margin: EdgeInsets.only(right: 10.h),
                                  height: Constant.height * 0.25,
                                  decoration: BoxDecoration(
                                    // color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.r),
                                      topRight: Radius.circular(12.r),
                                      bottomLeft: Radius.circular(12.r),
                                      bottomRight: Radius.circular(12.r),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        left: 0,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12.r),
                                            topRight: Radius.circular(12.r),
                                          ),
                                          child: Image.asset(
                                            "assets/hostels_detail/hostel-2.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 30,
                                        left: 12,
                                        child: SizedBox(
                                          height: 28,
                                          width: 100,
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              backgroundColor: Color(
                                                0xFF35AD9E,
                                              ),
                                              foregroundColor: Colors.white,
                                            ),

                                            child: Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                height: Constant.height * 0.025,
                                                child: FittedBox(
                                                  child: Text(
                                                    "Approved",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "Poppins",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        bottom: 10,
                                        left: 12,
                                        child: SizedBox(
                                          height: 25.h,
                                          // width: 70,
                                          child: ElevatedButton(
                                            // style: RoundedRectangleBorder(),
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(0),
                                              backgroundColor: Colors.white,
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.star_outline,
                                                    size: 20,
                                                    color: Color.fromARGB(
                                                      255,
                                                      0,
                                                      239,
                                                      209,
                                                    ),
                                                  ),
                                                  SizedBox(width: 3),
                                                  SizedBox(
                                                    height:
                                                        Constant.height * 0.025,
                                                    child: FittedBox(
                                                      child: Text(
                                                        "${paidHostel.rate}",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: "Poppins",
                                                          color: Colors.black,
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
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 0.0,
                                    horizontal: 8,
                                  ),
                                  child: SizedBox(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height:
                                                      Constant.height * 0.04,
                                                  child: FittedBox(
                                                    child: Text(
                                                      paidHostel.name,
                                                      style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20.sp.clamp(
                                                          0,
                                                          22,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "${paidHostel.city}, ${paidHostel.region}",
                                                          style: TextStyle(
                                                            fontSize: 12.sp
                                                                .clamp(0, 18),
                                                            fontFamily:
                                                                "Poppins",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            letterSpacing:
                                                                0.15.w,
                                                            color: const Color(
                                                              0xFF323232,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(width: 5),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                // color: Colors.red,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Text.rich(
                                                        TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: "From\n",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12.sp
                                                                    .clamp(
                                                                      0,
                                                                      12,
                                                                    ),
                                                                color:
                                                                    const Color(
                                                                      0xFF323232,
                                                                    ),
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  "GH₵ ${paidHostel.amt_per_year} ",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold, // Only "GH₵" is bold
                                                                fontSize: 12.sp
                                                                    .clamp(
                                                                      0,
                                                                      12,
                                                                    ),
                                                                color:
                                                                    const Color(
                                                                      0xFF323232,
                                                                    ),
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  "\nper year",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12.sp
                                                                    .clamp(
                                                                      0,
                                                                      12,
                                                                    ),
                                                                color:
                                                                    const Color(
                                                                      0xFF323232,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        textAlign: TextAlign
                                                            .right, // Aligns all text to the right
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: Constant.width * 0.45,
                                              height: Constant.height * 0.06,
                                              // color: Colors.red,
                                              child: FittedBox(
                                                alignment: Alignment.centerLeft,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      // "${formatDate(bookedHostel.move_in ?? "")} ",
                                                      format(
                                                        bookedHostel.move_in ??
                                                            "",
                                                      )[0],
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    // Text(" - "),
                                                    Text(
                                                      "${format(bookedHostel.move_in ?? "")[1]} - ${format(bookedHostel.move_out ?? "")[1]} ",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 1, // Thickness of the line
                                              height:
                                                  40, // Height of the divider
                                              color: Colors
                                                  .grey, // Color of the divider
                                            ),
                                            Expanded(
                                              // flex: 2,
                                              child: Container(
                                                // color: Colors.blue,
                                                width: Constant.width * 0.45,
                                                height: Constant.height * 0.06,
                                                child: FittedBox(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    textAlign: TextAlign.right,
                                                    "  ${paidHostel.city}\n${paidHostel.region}",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      fontFamily: "Poppins",
                                                    ),
                                                    softWrap:
                                                        true, // Allows multi-line wrapping
                                                    maxLines: 2,
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
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                );
              },
            ),
          );
    // SizedBox(
    //     key: key,
    //     height: 800,
    //     child: ListView.builder(
    //       itemCount: paidHostels.length,
    //       scrollDirection: Axis.vertical,
    //       itemBuilder: (context, index) {
    //         Hostels paidHostel = paidHostels[index];
    //         late BookedHostels bookedHostel;
    //         for (BookedHostels hostel in paid) {
    //           if (hostel.hostel_name == paidHostels[index].name) {
    //             bookedHostel = hostel;
    //           }
    //         }
    //         return GestureDetector(
    //           onTap: () async {
    //             Get.to(() => Payment(user: user!));
    //           },
    //           child: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 2.0),
    //             child: Column(
    //               children: [
    //                 Card(
    //                   color: Colors.white,
    //                   child: Padding(
    //                     padding: const EdgeInsets.only(bottom: 15),
    //                     child: SizedBox(
    //                       width: 330.w.clamp(0, 330),

    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Container(
    //                             // margin: EdgeInsets.only(right: 10.h),
    //                             height: 200,
    //                             decoration: BoxDecoration(
    //                               // color: Colors.black,
    //                               borderRadius: BorderRadius.only(
    //                                 topLeft: Radius.circular(12.r),
    //                                 topRight: Radius.circular(12.r),
    //                                 bottomLeft: Radius.circular(12.r),
    //                                 bottomRight: Radius.circular(12.r),
    //                               ),
    //                             ),
    //                             child: Stack(
    //                               children: [
    //                                 Positioned(
    //                                   top: 0,
    //                                   right: 0,
    //                                   left: 0,
    //                                   child: ClipRRect(
    //                                     borderRadius: BorderRadius.only(
    //                                       topLeft: Radius.circular(12.r),
    //                                       topRight: Radius.circular(12.r),
    //                                     ),
    //                                     child: Image.asset(
    //                                       "assets/hostels_detail/hostel-2.png",
    //                                       fit: BoxFit.cover,
    //                                     ),
    //                                   ),
    //                                 ),
    //                                 Positioned(
    //                                   top: 30,
    //                                   left: 12,
    //                                   child: SizedBox(
    //                                     height: 28,
    //                                     width: 100,
    //                                     child: ElevatedButton(
    //                                       onPressed: () {},
    //                                       style: ElevatedButton.styleFrom(
    //                                         padding: EdgeInsets.all(0),
    //                                         shape: RoundedRectangleBorder(
    //                                           borderRadius:
    //                                               BorderRadius.all(
    //                                                 Radius.circular(10),
    //                                               ),
    //                                         ),
    //                                         backgroundColor: Color(
    //                                           0xFF00EFD1,
    //                                         ),
    //                                         foregroundColor: Colors.white,
    //                                       ),

    //                                       child: Align(
    //                                         alignment: Alignment.center,
    //                                         child: Text(
    //                                           "Approved",
    //                                           style: TextStyle(
    //                                             fontWeight: FontWeight.w600,
    //                                           ),
    //                                         ),
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ),

    //                                 Positioned(
    //                                   bottom: 10,
    //                                   left: 12,
    //                                   child: SizedBox(
    //                                     height: 20,
    //                                     // width: 70,
    //                                     child: ElevatedButton(
    //                                       onPressed: () {},
    //                                       style: ElevatedButton.styleFrom(
    //                                         padding: EdgeInsets.all(0),
    //                                       ),
    //                                       child: Align(
    //                                         alignment: Alignment.center,
    //                                         child: Row(
    //                                           children: [
    //                                             Icon(
    //                                               Icons.star_outline,
    //                                               size: 15,
    //                                               color: Color.fromARGB(
    //                                                 255,
    //                                                 0,
    //                                                 239,
    //                                                 209,
    //                                               ),
    //                                             ),
    //                                             SizedBox(width: 3),
    //                                             Text(
    //                                               "${paidHostel.rate}",
    //                                               style: TextStyle(
    //                                                 fontWeight:
    //                                                     FontWeight.w600,
    //                                               ),
    //                                             ),
    //                                           ],
    //                                         ),
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                           SizedBox(height: 5),
    //                           Padding(
    //                             padding: const EdgeInsets.symmetric(
    //                               vertical: 0.0,
    //                               horizontal: 8,
    //                             ),
    //                             child: SizedBox(
    //                               child: Column(
    //                                 children: [
    //                                   Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.spaceBetween,
    //                                     children: [
    //                                       Column(
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           Text(
    //                                             paidHostel.name ?? "",
    //                                             style: TextStyle(
    //                                               fontFamily: "Poppins",
    //                                               fontWeight:
    //                                                   FontWeight.w600,
    //                                               fontSize: 20.sp.clamp(
    //                                                 0,
    //                                                 22,
    //                                               ),
    //                                             ),
    //                                           ),
    //                                           Row(
    //                                             mainAxisAlignment:
    //                                                 MainAxisAlignment
    //                                                     .spaceBetween,
    //                                             children: [
    //                                               Row(
    //                                                 children: [
    //                                                   Text(
    //                                                     "${paidHostel.city}, ${paidHostel.region}",
    //                                                     style: TextStyle(
    //                                                       fontSize: 12.sp
    //                                                           .clamp(0, 18),
    //                                                       fontFamily:
    //                                                           "Poppins",
    //                                                       fontWeight:
    //                                                           FontWeight
    //                                                               .w500,
    //                                                       letterSpacing:
    //                                                           0.15.w,
    //                                                       color:
    //                                                           const Color(
    //                                                             0xFF323232,
    //                                                           ),
    //                                                     ),
    //                                                   ),
    //                                                 ],
    //                                               ),
    //                                               SizedBox(width: 5),
    //                                             ],
    //                                           ),
    //                                         ],
    //                                       ),
    //                                       Expanded(
    //                                         child: Container(
    //                                           // color: Colors.red,
    //                                           child: Column(
    //                                             crossAxisAlignment:
    //                                                 CrossAxisAlignment.end,
    //                                             children: [
    //                                               Align(
    //                                                 alignment:
    //                                                     Alignment.topRight,
    //                                                 child: Text.rich(
    //                                                   TextSpan(
    //                                                     children: [
    //                                                       TextSpan(
    //                                                         text: "From\n",
    //                                                         style: TextStyle(
    //                                                           fontWeight:
    //                                                               FontWeight
    //                                                                   .w500,
    //                                                           fontSize: 12
    //                                                               .sp
    //                                                               .clamp(
    //                                                                 0,
    //                                                                 12,
    //                                                               ),
    //                                                           color: const Color(
    //                                                             0xFF323232,
    //                                                           ),
    //                                                         ),
    //                                                       ),
    //                                                       TextSpan(
    //                                                         text:
    //                                                             "GH₵ ${paidHostel.amt_per_year} ",
    //                                                         style: TextStyle(
    //                                                           fontWeight:
    //                                                               FontWeight
    //                                                                   .bold, // Only "GH₵" is bold
    //                                                           fontSize: 12
    //                                                               .sp
    //                                                               .clamp(
    //                                                                 0,
    //                                                                 12,
    //                                                               ),
    //                                                           color: const Color(
    //                                                             0xFF323232,
    //                                                           ),
    //                                                         ),
    //                                                       ),
    //                                                       TextSpan(
    //                                                         text:
    //                                                             "\nper year",
    //                                                         style: TextStyle(
    //                                                           fontWeight:
    //                                                               FontWeight
    //                                                                   .w500,
    //                                                           fontSize: 12
    //                                                               .sp
    //                                                               .clamp(
    //                                                                 0,
    //                                                                 12,
    //                                                               ),
    //                                                           color: const Color(
    //                                                             0xFF323232,
    //                                                           ),
    //                                                         ),
    //                                                       ),
    //                                                     ],
    //                                                   ),
    //                                                   textAlign: TextAlign
    //                                                       .right, // Aligns all text to the right
    //                                                 ),
    //                                               ),
    //                                             ],
    //                                           ),
    //                                         ),
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   const Divider(),
    //                                   Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.spaceBetween,
    //                                     children: [
    //                                       Container(
    //                                         child: Row(
    //                                           children: [
    //                                             Text(
    //                                               "${formatDate(bookedHostel.move_in ?? "")} ",
    //                                               style: TextStyle(
    //                                                 fontWeight:
    //                                                     FontWeight.w600,
    //                                                 fontSize: 18,
    //                                               ),
    //                                             ),
    //                                             Text(" - "),
    //                                             Text(
    //                                               formatDate(
    //                                                 bookedHostel.move_out ??
    //                                                     "",
    //                                               ),
    //                                               style: TextStyle(
    //                                                 fontWeight:
    //                                                     FontWeight.w600,
    //                                                 fontSize: 18,
    //                                               ),
    //                                             ),
    //                                           ],
    //                                         ),
    //                                       ),
    //                                       Container(
    //                                         width:
    //                                             1, // Thickness of the line
    //                                         height:
    //                                             40, // Height of the divider
    //                                         color: Colors
    //                                             .grey, // Color of the divider
    //                                       ),
    //                                       Text(
    //                                         "${paidHostel.city}, ${paidHostel.region}",
    //                                         style: TextStyle(
    //                                           fontWeight: FontWeight.w500,
    //                                           fontSize: 16,
    //                                         ),
    //                                       ),
    //                                     ],
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(height: 15),
    //               ],
    //             ),
    //           ),
    //         );
    //       },
    //     ),
    //   );
  }
}
