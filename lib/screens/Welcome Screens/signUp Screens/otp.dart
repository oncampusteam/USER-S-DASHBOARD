import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_campus/screens/Home%20Page%20Views/home.dart';

class Otp extends StatefulWidget {
  final String otp;
  const Otp({super.key, required this.otp});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final TextEditingController _otpController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final bool _codeSent = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Enter the 6-digit code sent to your phone',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _otpController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              hintText: '------',
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              // verifyOTP();
              String Otp = _otpController.text.trim();
              if (Otp.isEmpty) {
              } else {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: widget.otp,
                  smsCode: Otp,
                );
                await FirebaseAuth.instance
                    .signInWithCredential(credential)
                    .then((value) => {Get.to(() => Home())});
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Verify', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
