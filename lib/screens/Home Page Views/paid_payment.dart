import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:on_campus/screens/bottom_nav.dart';
import 'package:on_campus/firebase/firestore_db.dart';
import 'package:on_campus/widgets/payment_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaidPayment extends StatefulWidget {
  final User user;
  final String subject;
  const PaidPayment({super.key, required this.user, required this.subject});

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
    //debugPrint(formattedDate); // Output: July 10, 2025
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
        //debugPrint("paid: $paid");
      }
    } catch (e) {
      //debugPrint("Error fetching payments: $e");
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
        //debugPrint("No paid hostels");
      }
      //debugPrint("paid Hostel Details: $paidHostels");
    } catch (e) {
      //debugPrint("Error fetching hostel details: $e");
    }
  }

  bool receit = false;
  double _height = 0;

  Widget _receit() {
    return Align(
      // alignment: AlignmentDirectional.bottomEnd,
      child: AnimatedContainer(
        curve: Curves.easeIn,
        height: _height,
        duration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
          // color: const Color(0xFFF5F8FF),
          color: const Color(0xFFF5F8FF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r),
            topRight: Radius.circular(25.r),
          ),
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 20.h),
            child: Column(
              children: [
                SizedBox(
                  // color: Colors.red,
                  height: Constant.height * 0.16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _height = 0;
                              receit = false;
                            });
                          },
                          child: Icon(Icons.close, size: 24.h),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 25.h),
                        child: Column(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: const Color(0xFF00EFD1),
                              size: 24.h,
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              height: Constant.height * 0.03,
                              child: FittedBox(
                                child: Text(
                                  "Payment Success",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp,
                                    color: const Color(0xFF00EFD1),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              height: Constant.height * 0.04,
                              child: FittedBox(
                                child: Text(
                                  "GH₵ 2,000",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 28.sp,
                                    // color: const Color(0xFF00EFD1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: Icon(Icons.ios_share_outlined, size: 24.h),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25.h),
                  padding: EdgeInsets.all(5.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16.r)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 50.h,
                        // margin: EdgeInsets.symmetric(horizontal: 3.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: const Color(0xFFF5F6F7),
                        ),
                        child: Align(
                          child: SizedBox(
                            height: Constant.height * 0.025,
                            child: FittedBox(
                              child: Text(
                                "Payment Details",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 15.h),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Ref Number",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                          color: const Color(0xFF707070),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "000085752257",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Payment Time",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                          color: const Color(0xFF707070),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "17-08-2024, 04:40:17",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Payment Method",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                          color: const Color(0xFF707070),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Mobile Money",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Sender Name",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                          color: const Color(0xFF707070),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Antonio Roberto",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 5.h,
                            // ),
                            SizedBox(
                              // color: Colors.blue,
                              height: 25.h,
                              width: double.infinity,
                              child: Align(
                                child: Text(
                                  "------------------------------------------------------------------------------------------------------",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    color: const Color.fromRGBO(0, 0, 0, 0.03),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Amount",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                          color: const Color(0xFF707070),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "GH₵ 1,800",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Admin Fee",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                          color: const Color(0xFF707070),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "GH₵ 20",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: Constant.height * 0.025,
                                    child: FittedBox(
                                      child: Text(
                                        "Payment Status",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 13.sp,
                                          color: const Color(0xFF707070),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5.h),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                        35,
                                        162,
                                        109,
                                        0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(23.r),
                                    ),
                                    child: Text(
                                      "Success",
                                      style: TextStyle(
                                        color: const Color(0xFF00EFD1),
                                        fontFamily: "Poppins",
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Sizedbox()
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF00EFD1)),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  height: Constant.height * 0.06,
                  child: Align(
                    child: SizedBox(
                      height: Constant.height * 0.025,
                      child: FittedBox(
                        child: Row(
                          children: [
                            SizedBox(
                              height: Constant.height * 0.025,
                              child: Image.asset(
                                "assets/view_room_details/import.png",
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            SizedBox(
                              height: Constant.height * 0.025,
                              child: FittedBox(
                                child: Text(
                                  " Get PDF Receit",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: const Color(0xFF00EFD1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
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
                SizedBox(height: 5.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25.h),
                  width: double.infinity,
                  height: Constant.height * 0.06,
                  child: FilledButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          // side: const BorderSide(color: Color(0xFF00EFD1), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        ),
                      ),
                      backgroundColor: const WidgetStatePropertyAll(
                        Color(0xFF00EFD1),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Get.to(
                        () => const BottomNav(username: "Godfred"),
                        transition: Transition.fadeIn,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeIn,
                      );
                      receit = false;
                    },
                    child: SizedBox(
                      height: Constant.height * 0.025,
                      child: FittedBox(
                        child: Text(
                          "Back to Home",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PopScope(
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
                    foregroundDecoration: BoxDecoration(
                      color: receit ? Color.fromRGBO(0, 0, 0, 0.5) : null,
                    ),
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
                                color: const Color.fromRGBO(0, 0, 0, 0.03),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
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
                            Container(
                              color: Colors.red,
                              height: Constant.height * 0.035,
                              child: FittedBox(
                                child: Text(
                                  widget.subject,
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
                                      children: List.generate(paidHostels.length, (
                                        index,
                                      ) {
                                        Hostels paidHostel = paidHostels[index];
                                        late BookedHostels bookedHostel;
                                        // final isExpanded = expandedIndex == index;
                                        for (BookedHostels hostel in paid) {
                                          if (hostel.hostel_name ==
                                              paidHostel.name) {
                                            bookedHostel = hostel;
                                          }
                                        }
                                        return Column(
                                          children: [
                                            roomCard(
                                              pendingHostel: paidHostels[index],
                                              bookedHostel: bookedHostel,
                                            ),
                                            SizedBox(height: 10),
                                            // if (isExpanded)
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
                                                              bottom: 40.h,
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
                                                              height: 10.h,
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
                                                              height: 10.h,
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
                                                              height: 10.h,
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
                                                              height: 10.h,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Tax (Vat)",
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
                                                              height: 10.h,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Total Amount",
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
                                                              height: 10.h,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Transaction ID",
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
                                                                  "#TJFSLKHFDSLKFH",
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
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  height:
                                                                      Constant
                                                                          .height *
                                                                      0.05,
                                                                  color: Colors
                                                                      .white,
                                                                  // height:
                                                                  //     25.h,
                                                                  // width:
                                                                  child: ElevatedButton(
                                                                    onPressed: () {
                                                                      setState(() {
                                                                        _height =
                                                                            Constant.height *
                                                                            0.85;
                                                                        receit =
                                                                            true;
                                                                      });
                                                                    },
                                                                    style: ElevatedButton.styleFrom(
                                                                      elevation:
                                                                          0,
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
                                                                    child: Align(
                                                                      child: SizedBox(
                                                                        height:
                                                                            Constant.height *
                                                                            0.025,
                                                                        child: FittedBox(
                                                                          child: const Text(
                                                                            "View Receipt",
                                                                            style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontFamily: "Poppins",
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        5.w,
                                                                    vertical:
                                                                        2.5.h,
                                                                  ),
                                                                  decoration: BoxDecoration(
                                                                    color:
                                                                        Color.fromRGBO(
                                                                          35,
                                                                          162,
                                                                          109,
                                                                          0.1,
                                                                        ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          23.r,
                                                                        ),
                                                                  ),
                                                                  child: Align(
                                                                    child: SizedBox(
                                                                      height:
                                                                          Constant
                                                                              .height *
                                                                          0.02,
                                                                      child: FittedBox(
                                                                        child: Text(
                                                                          "Succes",
                                                                          style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            color: Color(
                                                                              0xFF00EFD1,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
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
                                  ),
                          ],
                        ),

                        SizedBox(height: 100.h),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  width: Constant.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: const Color(0xFFEFEFEF)),
                    ),
                  ),
                  child: Align(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(
                          () => BottomNav(username: "Godfred", subindex: 0),
                        );
                      },
                      child: Container(
                        height: Constant.height * 0.06,
                        width: Constant.width * 0.9,
                        decoration: BoxDecoration(
                          color: Color(0xFFDFF0ED),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Align(
                          child: SizedBox(
                            height: Constant.height * 0.025,
                            child: FittedBox(
                              child: Text(
                                "View Info",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF35AD9E),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(bottom: 0, left: 0, right: 0, child: _receit()),
            ],
          ),
        ),
      ),
    );
  }
}
