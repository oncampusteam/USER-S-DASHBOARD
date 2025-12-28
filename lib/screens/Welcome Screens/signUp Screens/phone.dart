import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:on_campus/screens/Welcome%20Screens/signUp%20Screens/otp.dart';

class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';
  bool isLoading = false;

  Future<void> verifyPhoneNumber() async {
    setState(() => isLoading = true);
    try {
      if (_phoneController.text.trim().isEmpty ||
          _phoneController.text.trim() == null ||
          _phoneController.text.trim() == "") {
        Get.snackbar("Error", "Enter your phone number");
      } else if (_phoneController.text.trim().length < 9) {
        Get.snackbar("Incorrect number", "Enter a valid phone number");
      }
      await _auth.verifyPhoneNumber(
        phoneNumber: '+233${_phoneController.text.trim()}',

        verificationCompleted: (credential) async {
          setState(() => isLoading = false);
        },

        verificationFailed: (FirebaseAuthException e) {
          setState(() => isLoading = false);
          Get.snackbar("Error", e.message ?? "Verification failed");
        },

        codeSent: (String verId, int? resendToken) {
          setState(() {
            isLoading = false;
            _verificationId = verId;
          });

          /// ✅ Navigate ONLY after reCAPTCHA succeeds
          Get.to(
            () => Otp(verificationId: verId, phoneNumber: _phoneController.text.trim(),),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 600),
          );
        },

        codeAutoRetrievalTimeout: (String verId) {
          _verificationId = verId;
          setState(() => isLoading = false);
        },
      );
    } catch (e) {
      Get.snackbar("Otp unsuccessful", "Check your internet connection");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    "Log in with Phone number",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Welcome back! Sign in using your Phone number or email to continue with us",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
            Text(
              'Your Phone number',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 239, 209),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
              ),
              child: Row(
                children: [
                  Image.network('https://flagcdn.com/w40/gh.png', width: 24),
                  const SizedBox(width: 8),
                  const Text('Ghana'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('+233', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(9),
                    ],
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: '0 00 00 00 00',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                try {
                  await verifyPhoneNumber();
                } catch (e) {
                  Get.snackbar("Error", e.toString());
                }

                setState(() {
                  isLoading = false;
                });
                Get.to(
                  () => Otp(verificationId: _verificationId, phoneNumber: _phoneController.text.trim(),),
                  transition: Transition.fadeIn,
                  curve: Curves.easeIn,
                  duration: Duration(milliseconds: 600),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 239, 209),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: isLoading
                  ? CircularProgressIndicator()
                  : Text(
                      'Send OTP',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
