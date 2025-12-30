import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_campus/firebase/firestore_db.dart';

class Googletempsignin extends StatefulWidget {
  const Googletempsignin({super.key});

  @override
  State<Googletempsignin> createState() => _GoogletempsigninState();
}

class _GoogletempsigninState extends State<Googletempsignin> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: FutureBuilder(
          future: FirestoreDb.instance.signInWithGoogle(),
          builder: (context,snapshot) {
            return Placeholder();
          },
        ),
      ),
      
    );
  }
}
