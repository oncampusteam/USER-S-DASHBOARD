import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:on_campus/screens/Home Page Views/home.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:on_campus/firebase/firestore_db.dart';

class Otp extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const Otp({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _otpController = TextEditingController();

  late String _verificationId;

  int seconds = 30;
  Timer? _timer;
  bool canResend = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _verificationId = widget.verificationId;
    _startTimer();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    seconds = 30;
    canResend = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      if (seconds == 0) {
        timer.cancel();
        setState(() => canResend = true);
      } else {
        setState(() => seconds--);
      }
    });
  }

  Future<void> _verifyOtp() async {
    if (_otpController.text.length != 6) {
      Get.snackbar("Invalid OTP", "Please enter the 6-digit code");
      return;
    }

    setState(() => isLoading = true);

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _otpController.text.trim(),
      );
      await FirestoreDb.instance.signInWithPhone(credential);
    
      Get.offAll(() => Home());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Verification Failed", e.message ?? "Invalid OTP");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _resendOtp() async {
    setState(() => isLoading = true);

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+233${widget.phoneNumber}',

        verificationCompleted: (_) {},

        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar("Error", e.message ?? "Verification failed");
        },

        codeSent: (String verId, int? resendToken) {
          _verificationId = verId;
          _startTimer();
        },

        codeAutoRetrievalTimeout: (String verId) {
          _verificationId = verId;
        },
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 18),
                  onPressed: () => Get.back(),
                ),
              ),

              const SizedBox(height: 30),
              Image.asset("assets/loginPage/otpbackground.png"),
              const SizedBox(height: 20),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "OTP Verification",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "We will send you a one time password on \n this Mobile Number",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "+233 ${widget.phoneNumber}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: 260,
                    child: PinCodeTextField(
                      appContext: context,
                      length: 6,
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.circle,
                        fieldHeight: 40,
                        fieldWidth: 40,
                        activeColor: Colors.teal,
                        selectedColor: Colors.teal,
                        inactiveColor: Colors.teal.shade200,
                      ),
                      onChanged: (_) {},
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    "00:${seconds.toString().padLeft(2, '0')}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Didn't get OTP? ", style: TextStyle(fontSize: 11)),
                      TextButton(
                        onPressed: canResend ? _resendOtp : null,
                        child: const Text(
                          "Resend OTP",
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: isLoading ? null : _verifyOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 239, 209),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
