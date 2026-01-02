import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:on_campus/screens/Welcome%20Screens/signUp%20Screens/otp.dart';

class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String _verificationId = '';

  Future<void> verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+233${_phoneController.text.trim()}',
      verificationCompleted: (credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message ?? 'Error')));
      },
      codeSent: (otp, token) {
        Get.to(
          () => Otp(otp: otp),
          transition: Transition.fadeIn,
          curve: Curves.easeIn,
          duration: Duration(milliseconds: 600),
        );
      },
      codeAutoRetrievalTimeout: (otp) {},
    );
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
                  SizedBox(
                    height: Constant.height * 0.04,
                    child: FittedBox(
                      child: Text(
                        "Log in with Phone number",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: 23,
                          color: Color(0xFF000E08)
                          ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Constant.height * 0.06,
                    width: Constant.width * 0.8,
                    child: FittedBox(
                      child: Text(
                        "Welcome back! Sign in using your Phone number\nor email to continue with us",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF797C7B)
                        ),
                      ),
                    ),
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
                  const Spacer(),
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
            const SizedBox(height: 30),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                verifyPhoneNumber();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 239, 209),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Send OTP',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
