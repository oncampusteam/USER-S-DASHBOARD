import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/firebase/firestore_db.dart';

class PendingPayment extends StatefulWidget {
  const PendingPayment({super.key});

  @override
  State<PendingPayment> createState() => _PendingPaymentState();
}

class _PendingPaymentState extends State<PendingPayment> {
  List<BookedHostels> booked = [];

  Future<void> getPendingPayment() async {
    User? user = FirebaseAuth.instance.currentUser;
    
    if (user != null) {
      setState(() async {
        booked = await FirestoreDb.instance.getBookedHostels(user);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPendingPayment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(63, 118, 182, 234).withOpacity(0.1),
          child: Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Column(
              children: [
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, .4),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      height: 40.h,
                      width: 40.w,
                      child: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        widthFactor: MediaQuery.sizeOf(context).width.w,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Pending Payment",
                            style: TextStyle(
                              fontSize: 15.5.sp.clamp(0, 17.5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, .4),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    height: 40.h,
                    width: 40.w,
                    child: const Icon(Icons.close, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 10.h),
                ListView.builder(
                  itemCount: booked.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    BookedHostels bookedHostel = booked[index];
                    return Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Card(
                                color: Colors.white,
                                child: Container(
                                  // width: MediaQuery.sizeOf(context).width,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.0.w,
                                      vertical: 20.h,
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 90.w,
                                          height: 90.h,
                                          child: Stack(
                                            children: [
                                              SizedBox(
                                                width: 90.w,
                                                height: 90.h,
                                                child: Image.asset(
                                                  "assets/hostels_detail/hostel-2.png",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                    5.0.r,
                                                  ),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            50.r,
                                                          ),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                        2.0.r,
                                                      ),
                                                      child: const Icon(
                                                        Icons.favorite_border,
                                                        size: 17,
                                                        color: Color(
                                                          0xFF00EFD1,
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
                                            padding: EdgeInsets.only(
                                              left: 5.0.w,
                                            ),
                                            child: Container(
                                              // width: MediaQuery.sizeOf(context).width,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        bookedHostel.name ?? "",
                                                        style: TextStyle(
                                                          fontSize: 12.sp.clamp(
                                                            0,
                                                            14,
                                                          ),
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                                            color:
                                                                const Color.fromARGB(
                                                                  255,
                                                                  33,
                                                                  243,
                                                                  201,
                                                                ),
                                                          ),
                                                          SizedBox(width: 5.w),
                                                          Text(
                                                            "4.8",
                                                            style: TextStyle(
                                                              fontSize: 12.sp
                                                                  .clamp(0, 14),
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
                                                        size: 10.sp.clamp(
                                                          0,
                                                          12,
                                                        ),
                                                      ),
                                                      Text(
                                                        "1994 Broadway, New York",
                                                        style: TextStyle(
                                                          fontSize: 8.sp.clamp(
                                                            0,
                                                            10,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 2.h),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.sizeOf(
                                                            context,
                                                          ).width *
                                                          0.5.w,
                                                      child: Text(
                                                        "    Wifi . Shower. Kitchen . Security . Parking . Balcony . Friendly Environment",
                                                        style: TextStyle(
                                                          fontSize: 8.sp.clamp(
                                                            0,
                                                            10,
                                                          ),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 2.h),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      "Price Estimate",
                                                      style: TextStyle(
                                                        fontSize: 12.sp.clamp(
                                                          0,
                                                          12,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "c2,000/",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        "Academic Year",
                                                        style: TextStyle(
                                                          fontSize: 10.sp.clamp(
                                                            0,
                                                            12,
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
                              SizedBox(height: 20.h),
                              Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 15.0.w,
                                    top: 40.h,
                                    right: 15.0.w,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Booking Date",
                                            style: TextStyle(
                                              fontSize: 12.sp.clamp(0, 14),
                                            ),
                                          ),
                                          Text(
                                            "August 08, 2024 | 4:40 PM",
                                            style: TextStyle(
                                              fontSize: 12.sp.clamp(0, 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Check In",
                                            style: TextStyle(
                                              fontSize: 12.sp.clamp(0, 14),
                                            ),
                                          ),
                                          Text(
                                            "August 08, 2024",
                                            style: TextStyle(
                                              fontSize: 12.sp.clamp(0, 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Check Out",
                                            style: TextStyle(
                                              fontSize: 12.sp.clamp(0, 14),
                                            ),
                                          ),
                                          Text(
                                            "August 08, 2026",
                                            style: TextStyle(
                                              fontSize: 12.sp.clamp(0, 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Tenant",
                                            style: TextStyle(
                                              fontSize: 12.sp.clamp(0, 14),
                                            ),
                                          ),
                                          Text(
                                            "01 person",
                                            style: TextStyle(
                                              fontSize: 12.sp.clamp(0, 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20.h),
                                      const Divider(),
                                      SizedBox(height: 20.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Amount",
                                            style: TextStyle(
                                              fontSize: 12.sp.clamp(0, 14),
                                            ),
                                          ),
                                          Text(
                                            "c 1,800",
                                            style: TextStyle(
                                              fontSize: 14.sp.clamp(0, 16),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Tax & Fees",
                                            style: TextStyle(
                                              fontSize: 12.sp.clamp(0, 14),
                                            ),
                                          ),
                                          Text(
                                            "c 200.00",
                                            style: TextStyle(
                                              fontSize: 14.sp.clamp(0, 16),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total",
                                            style: TextStyle(
                                              fontSize: 12.sp.clamp(0, 14),
                                            ),
                                          ),
                                          Text(
                                            "c 2,000",
                                            style: TextStyle(
                                              fontSize: 14.sp.clamp(0, 16),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20.h),
                                      Divider(height: .2.h),
                                      SizedBox(height: 20.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/payment/Simplification.png",
                                                width: 25.w,
                                                height: 25,
                                                color: Colors.black,
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(width: 5.w),
                                              Text(
                                                "Debit Card",
                                                style: TextStyle(
                                                  fontSize: 12.sp.clamp(0, 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                          TextButton(
                                            child: Text(
                                              "Change",
                                              style: TextStyle(
                                                color: const Color(0xFF00EFD1),
                                                fontSize: 12.sp.clamp(0, 14),
                                              ),
                                            ),
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 50.h),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                color: Colors.white,
                                height: 60.h,
                                width: MediaQuery.sizeOf(context).width,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8.0.h,
                                    horizontal: 12.w,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide.none,
                                        borderRadius: BorderRadius.circular(
                                          15.r,
                                        ),
                                      ),
                                      backgroundColor: const Color(0xFF00EFD1),
                                    ),
                                    child: const Text(
                                      "Pay now",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
