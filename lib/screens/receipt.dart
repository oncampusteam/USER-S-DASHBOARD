import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:on_campus/classes/pdf_download.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Receipt extends StatelessWidget {
  const Receipt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: SizedBox(
          height: Constant.height * 0.05,
          child: Image.asset(
            "assets/initialPage0/onCampus.png",
            fit: BoxFit.fitHeight
            )),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 20.h,),
            CircleAvatar(
              radius: 30.h,
              backgroundColor: const Color(0xFFDBF9F5),
              child: Icon(Icons.check, size: 20, color: Color(0xFF23D3C3)),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: Constant.height * 0.03,
              child: FittedBox(
                child: const Text(
                  "Payment Confirmed",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Inter"
                    ),
                ),
              ),
            ),
            // const SizedBox(height: 8),
            SizedBox(
              height: Constant.height * 0.025,
              child: FittedBox(
                child: const Text(
                  "Thank you for your payment!",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            _stayDuration(),
            const SizedBox(height: 25),

            _infoRow("Student", "Kwame Mensah", "kwame.m@uni.edu.gh"),
            const SizedBox(height: 20),

            _twoColumnInfo(
              leftTitle: "Hostel",
              leftMain: "Nana Hostels",
              leftSub: "Legon Campus Area",
              rightTitle: "Room Type",
              rightMain: "Executive (2-in-room)",
              rightSub: "Block B, Rm 104",
            ),

            const SizedBox(height: 30),
            _paymentSummary(),

            const SizedBox(height: 25),
            _transactionInfo(),

            const SizedBox(height: 30),
            _secureText(),

            const SizedBox(height: 30),
            _downloadButton()
          ],
        ),
      ),
    );
  }

  // ------------------------------------

  // Widget _successIcon() {
  //   return CircleAvatar(
  //     radius: 40,
  //     backgroundColor: const Color(0xFFDBF9F5),
  //     child: Icon(Icons.check, size: 40, color: Color(0xFF23D3C3)),
  //   );
  // }

  Widget _stayDuration() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: _card(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                height: Constant.height * 0.025,
                child: FittedBox(
                  child: Text("STAY DURATION",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF94A3B8), letterSpacing: 1)),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(43, 238, 196, 0.1),
                  borderRadius: BorderRadius.circular(4.r)
                ),
                child: Align(
                  child: SizedBox(
                    height: Constant.height * 0.025,
                    child: FittedBox(
                      child: Text(
                        "1 Year",
                        style: TextStyle(
                          color: Color(0xFF00EFD1),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                        ),
                        ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: Constant.width * 0.4,
            child: Row(
              children: [
                Column(
                    children: [
                      Container(
                        width: Constant.width * 0.1,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(43, 140, 238, 0.2),
                          shape: BoxShape.circle
                        ),
                        child: Align(
                          child: Container(
                            width: Constant.width * 0.032,
                            height: Constant.height * 0.02,
                            decoration: BoxDecoration(
                              color: Color(0xFF00EFD1),
                              shape: BoxShape.circle
                            ),
                            child: Container(),
                          ),
                        ),
                      ),
                      Container(
                        height: Constant.height * 0.07,
                        width: Constant.width * 0.01,
                        color: Color(0xFFE2E8F0),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        width: Constant.width * 0.032,
                        height: Constant.height * 0.02,
                        decoration: BoxDecoration(
                          color: Color(0xFFCBD5E1),
                          shape: BoxShape.circle,
                        ),
                      )
                    ],
                  ),
                // Icon(Icons.circle, size: 12, color: Color(0xFF23D3C3)),
                // SizedBox(width: 5),
                Column(
                children: [
                  SizedBox(
                    height: Constant.height * 0.025,
                    width: Constant.width * 0.3,
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                      "Check-in",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF64748B)
                      ),
                      ))),
                  SizedBox(
                    height: Constant.height * 0.03,
                    width: Constant.width * 0.3,
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Sep 15, 2023",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Inter"
                        )),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: Constant.height * 0.025,
                    width: Constant.width * 0.3,
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Check-out",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF64748B)
                          ),
                        ),
                    ),
                  ),
                  SizedBox(
                    height: Constant.height * 0.03,
                    width: Constant.width * 0.3,
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "May 15, 2024",
                                        style:TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: "Inter"
                          )
                                        ),
                    ),
                  ),
                ],),  
              ],
            ),
          ),
          
          
        ],
      ),
    );
  }

  Widget _infoRow(String title, String main, String sub) {
    return Container(
      width: Constant.width,
      padding: const EdgeInsets.all(20),
      decoration: _card(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Constant.height * 0.025,
            child: FittedBox(
              child: Text(title.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B)
                    )
                  ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: Constant.height * 0.03,
            child: FittedBox(
              child: Text(main,
                  style:
                      const TextStyle(
                        color: Color(0xFF0F172A), 
                        fontWeight: FontWeight.w600,
                        fontFamily: "Inter"
                        ),
                        ),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: Constant.height * 0.03,
            child: FittedBox(
              child: Text(sub, 
              style: const TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF64748B)
                        )
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _twoColumnInfo({
    required String leftTitle,
    required String leftMain,
    required String leftSub,
    required String rightTitle,
    required String rightMain,
    required String rightSub,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _card(),
      child: Row(
        children: [
          Expanded(child: _infoBlock(leftTitle, leftMain, leftSub)),
          Expanded(child: _infoBlock(rightTitle, rightMain, rightSub)),
        ],
      ),
    );
  }

  Widget _infoBlock(String title, String main, String sub) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Constant.height * 0.025,
          child: FittedBox(
            child: Text(title.toUpperCase(),
                style: const TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF64748B)
                            )
                ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: Constant.height * 0.03,
          child: FittedBox(
            child: Text(main, 
            style:
             const TextStyle(
               color: Color(0xFF0F172A), 
               fontWeight: FontWeight.w600,
               fontFamily: "Inter"
               ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: Constant.height * 0.025,
          width: Constant.width * 0.4,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Text(sub, 
            style: const TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w400,
              color: Color(0xFF64748B)
              )
            ),
          ),
        ),
      ],
    );
  }

  Widget _paymentSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _card(),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: Constant.height * 0.025,
              child: FittedBox(
                child: Text("PAYMENT SUMMARY",
                    style: TextStyle(
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF64748B)
                                )
                    ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _row("Room Payment", "GHS 5000.00"),
          _row("Processing Fee", "GHS 50.00"),
          _row("Tax (VAT)", "GHS 0.00"),
          const Divider(),
          _row(
            "Total Amount",
            "GHS 5050.00",
            bold: true,
            highlight: true,
          )
        ],
      ),
    );
  }

  Widget _row(String left, String right,
      {bool bold = false, bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            height: !bold ? Constant.height * 0.025: Constant.height * 0.03,
            child: FittedBox(child: Text(
              left,
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: !bold ? FontWeight.w400: FontWeight.w700,
                color: !bold ? Color(0xFF475569) : Color(0xFF0F172A)
              ),
              ))),
          const Spacer(),
          SizedBox(
            height: bold ? Constant.height * 0.03: Constant.height * 0.025,
            child: FittedBox(
              child: Text(
                right,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
                  color: highlight ? const Color(0xFF2BEED4) : Color(0xFF0F172A),
                  fontSize: highlight ? 18 : 14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _transactionInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _card(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Constant.height * 0.025,
                    child: FittedBox(
                      child: Text(
                        "Date & Time",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF94A3B8)
                        )
                        ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: Constant.height * 0.025,
                    child: FittedBox(
                      child: Text(
                        "Sep 1, 2023 • 10:42 AM",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF334155)
                        )
                        ),
                    ),
                  )
                ],
              ),
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Constant.height * 0.025,
                    child: FittedBox(
                      child: Text(
                        "Payment Method",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF94A3B8)
                        )
                        ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/initialPage0/Container.png",
                        fit: BoxFit.cover,
                        color: Color(0xFF334155),
                        height: Constant.height * 0.025,
                        ),
                        SizedBox(
                          height: Constant.height * 0.03,
                          child: FittedBox(
                            child: Text(
                              " Mobile Money",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF334155)
                              )
                              ),
                          ),
                        ),
                    ],
                  )
                ],
              )
            ],
          ),
          // _row("Date & Time", "Sep 1, 2023 • 10:42 AM"),
          // _row("Payment Method", "Mobile Money"),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Constant.height * 0.025,
                    child: FittedBox(
                      child: Text(
                        "Transaction ID",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF94A3B8)
                        )
                        ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: Constant.width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      color: Color(0xFFF1F5F9)
                    ),
                    child: Align(
                      child: SizedBox(
                        height: Constant.height * 0.025,
                        width: Constant.width * 0.25,
                        child: FittedBox(
                          child: Text(
                            "#GH-TRX-8829304",
                            style: TextStyle(
                              fontFamily: "Consolas",
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF475569)
                            ),
                            ))),
                    )),
                      ],
                    ),
            
          )
        ],
      ),
    );
  }

  Widget _secureText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.lock_outline_rounded, color: Colors.green),
        SizedBox(width: 8),
        SizedBox(
          height: Constant.height * 0.025,
          child: FittedBox(
            child: Text("Payments are secure and encrypted",
                style: TextStyle(color: Colors.grey)),
          ),
        )
      ],
    );
  }

  Widget _downloadButton() {
  return SizedBox(
    width: double.infinity,
    height: Constant.height * 0.06,
    child: ElevatedButton.icon(
      onPressed: () async {
        final file = await generateReceiptPdf();
        OpenFilex.open(file.path);
        debugPrint("PDF saved at: ${file.path}");
      },
      icon: Image.asset("assets/initialPage0/download-2.png"),
      label: const Text(
        "Download Receipt (PDF)",
        style: TextStyle(
          fontFamily: "Inter",
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2BEED4),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    ),
  );
}


  BoxDecoration _card() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 10,
          offset: const Offset(0, 5),
        )
      ],
    );
  }
}
