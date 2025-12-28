import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/Welcome Screens/welcome_screen_4.dart';

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly'
];
GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);

class GoogleAuth {
  static String? username;
  static String? email;

  static Future<dynamic> signUpWithGoogle() async {
    // _googleSignIn.signOut();
    debugPrint(
        "Starting the execution of the signUpWithGoogle.................................");
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      debugPrint(
          "GoogleUser: $googleUser############################################");
      if (googleUser != null) {
        username = googleUser.displayName?.toUpperCase() ?? "";
        email = googleUser.email;

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        debugPrint("Google Auth Provider credential done...........");

        final userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        debugPrint("Should Push..................................");

        Get.to(() => const WelcomeScreen4(),
            transition: Transition.fadeIn,
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 600));
        return userCredential;
      }
      debugPrint("GoogleUsr is null..............");
      _googleSignIn.signOut();
      return UserCredential as UserCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == "network-request-failed") {
        debugPrint(
            "There is network issue. Please check your internet connection.........................................");
        return "network-request-failed";
      } else {
        debugPrint("this is the errorCode : $e");
        return '';
      }
    } on PlatformException catch (e) {
      if (e.code == "network_error") {
        debugPrint(
            "There is no internet connection................................................");
        Get.rawSnackbar(
            messageText: const Text("PLEASE CONNECT TO THE INTERNET",
                style: TextStyle(color: Colors.white, fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red,
            icon: const Icon(Icons.wifi_off, color: Colors.white, size: 35),
            margin: EdgeInsets.zero,
            snackStyle: SnackStyle.GROUNDED);
        return "network-request-failed";
      }
    } catch (e) {
      debugPrint(
          "This is the eror : $e .............................................");
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:on_campus/screens/Welcome%20Screens/welcome_screen_4.dart';

// class AuthController extends GetxController {
//   static Future<UserCredential?> signUpWithGoogle() async {
//     debugPrint("Starting the execution of signUpWithGoogle...");

//     try {
//       // Attempt to sign in with Google
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       debugPrint("GoogleUser: $googleUser");

//       if (googleUser != null) {
//         // Retrieve user's display name and email
//         final String username =
//             googleUser.displayName?.toUpperCase() ?? "Unknown";
//         final String email = googleUser.email;

//         debugPrint("User Name: $username, Email: $email");

//         // Obtain authentication details from the request
//         final GoogleSignInAuthentication googleAuth =
//             await googleUser.authentication;
//         debugPrint("Google Authentication retrieved.");

//         // Create a new credential
//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );

//         debugPrint("Firebase credential created.");

//         // Sign in to Firebase with the credential
//         final UserCredential userCredential =
//             await FirebaseAuth.instance.signInWithCredential(credential);
//         debugPrint("Firebase sign-in successful: ${userCredential.user}");

//         // Navigate to the next screen
//         Get.to(() => const WelcomeScreen4(),
//             transition: Transition.fadeIn,
//             curve: Curves.easeIn,
//             duration: const Duration(milliseconds: 600));

//         return userCredential;
//       } else {
//         debugPrint("Google sign-in returned null (user canceled or failed).");
//         return null;
//       }
//     } on FirebaseAuthException catch (e) {
//       if (e.code == "network-request-failed") {
//         debugPrint("Network error: Check your internet connection.");
//         return null;
//       } else {
//         debugPrint("FirebaseAuthException: ${e.message}");
//         return null;
//       }
//     } on PlatformException catch (e) {
//       if (e.code == "network_error") {
//         debugPrint("PlatformException: No internet connection.");
//         Get.rawSnackbar(
//           messageText: const Text("PLEASE CONNECT TO THE INTERNET",
//               style: TextStyle(color: Colors.white, fontSize: 14)),
//           duration: const Duration(seconds: 2),
//           backgroundColor: Colors.red,
//           icon: const Icon(Icons.wifi_off, color: Colors.white, size: 35),
//           margin: EdgeInsets.zero,
//           snackStyle: SnackStyle.GROUNDED,
//         );
//         return null;
//       }
//     } catch (e, stackTrace) {
//       debugPrint("Unexpected error: $e");
//       debugPrint("Stack trace: $stackTrace");
//       return null;
//     }
//   }
// }
