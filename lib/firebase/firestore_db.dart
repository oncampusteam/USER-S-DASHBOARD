import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:on_campus/firebase/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:on_campus/screens/Welcome%20Screens/welcome_screen_4.dart';
import 'package:on_campus/screens/Welcome%20Screens/welcome_screen_5.dart';

//  UserModel? usermodel;

class FirestoreDb {
  static FirestoreDb instance = FirestoreDb();
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // UserModel? usermodel;

  Future<List<Regions>> getRegions(BuildContext context) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
          .collection("Region")
          .get();

      List<Regions> regionsList = querySnapshot.docs
          .map((e) => Regions.fromJson(e.data()))
          .toList();

      return regionsList;
    } catch (e) {
      print(e);
      Get.snackbar(
        "Error",
        "An unknown error occurred. Please try again later. \n ${e.toString()}\n ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }
  }

  Future<List<Hostels>> getPrivateHostels() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
          .collectionGroup("Private Hostels")
          .get();

      List<Hostels> allPrivateHostels = querySnapshot.docs
          .map((e) => Hostels.fromJson(e.data()))
          .toList();
      print(allPrivateHostels);
      for (var e in querySnapshot.docs) {
        String fullPath = e.reference.path;

        // Example path: "Regions/Ashanti/Cities/Ayeduase/Private Hostels/Wagyingo"
        List<String> pathSegments = fullPath.split('/');

        String region = pathSegments[1];
        String city = pathSegments[3];
        await e.reference.update({'region': region, 'city': city});
      }
      return allPrivateHostels;
    } catch (e) {
      print(e);
      Get.snackbar(
        "Error",
        "An unknown error occurred. Please try again later. \n ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }
  }

  Future<List<Hostels>> getSchoolHostels() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
          .collectionGroup("School Hostels")
          .get();
      List<Hostels> allSchoolHostels = querySnapshot.docs
          .map((e) => Hostels.fromJson(e.data()))
          .toList();

      for (var e in querySnapshot.docs) {
        String fullPath = e.reference.path;

        // /Region/Cape Coast/Universities/UCC/School Hostels/SRC Hostel
        List<String> pathSegments = fullPath.split('/');
        String region = pathSegments[1];
        String university = pathSegments[3];
        await e.reference.update({'region': region, 'university': university});
        print(e.data().length);
      }
      return allSchoolHostels;
    } catch (e) {
      Get.snackbar(
        "Error",
        "An unknown error occurred. Please try again later. \n ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }
  }

  Future<List<Hostels>> getPopular() async {
    List<Hostels> popularHostels = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
          .collectionGroup("Private Hostels")
          .where(
            "ispopular",
            isEqualTo: true,
          ) // use boolean true instead of string
          .get();

      popularHostels = querySnapshot.docs
          .map((e) => Hostels.fromJson(e.data()))
          .toList();
      for (var e in querySnapshot.docs) {
        print(e.data());
      }

      return popularHostels;
    } catch (e) {
      print("Anfa oo");
      print(e);
      Get.snackbar(
        "Error",
        "An unknown error occurred. Please try again later. \n ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }
  }

  Future<List<RoomTypes>> roomTypes(Hostels name) async {
    List<RoomTypes> roomTypes = [];
    try {
      final query = await db
          .collectionGroup("Private Hostels")
          .where("name", isEqualTo: name.name)
          .get();

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await query
          .docs
          .first
          .reference
          .collection("roomTypes")
          .get();

      roomTypes = querySnapshot.docs
          .map((e) => RoomTypes.fromJson(e.data()))
          .toList();
      print(roomTypes);

      return roomTypes;
    } catch (e) {
      Get.snackbar(
        "Error",
        "An unknown error occurred. Please try again later. \n ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }
  }

  Future<List<Hostels>> getPopu() async {
    List<Hostels> popu = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
          .collection("Cities")
          .doc("Ayeduase")
          .collection("Private Hostels")
          // .where("isPopular", isEqualTo: true)
          .get();

      popu = querySnapshot.docs.map((e) => Hostels.fromJson(e.data())).toList();

      for (var e in querySnapshot.docs) {
        print("popu: ${e.data()}");
      }

      return popu;
    } catch (e) {
      print("An error occurred during Google sign-in: $e");
      Get.snackbar(
        "Error",
        "An unknown error occurred. Please try again later. \n ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      final user = userCredential.user;
      if (user != null) {
        final userModel = UserModel(
          email: user.email,
          name: user.displayName,
          id: user.uid,
          userInfoDone: false,
          phone: null,
          gender: "",
          program: "",
          year: null,
          guardian: "",
          emergency1: null,
          emergency2: null,
        );

        await db
            .collection("Users")
            .doc(user.uid)
            .set(userModel.toJson(), SetOptions(merge: true));

        // Step 6: Navigate with smooth transition

        Get.to(
          () => WelcomeScreen5(
            username: user.displayName?.split(' ').first ?? "User",
          ),
          transition: Transition.fadeIn,
          duration: Duration(milliseconds: 600),
        );
      }
    } catch (e) {
      if (e is SocketException) {
        // No internet (general device network failure)
        Get.snackbar(
          "No Internet",
          "Check your internet connection",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e is PlatformException &&
          (e.code == 'network_error' ||
              e.message?.contains('ApiException: 7') == true)) {
        // Firebase/Google Play Services network error
        Get.snackbar(
          "No Internet",
          "Check your internet connection",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        // Other error
        Get.snackbar(
          "Error",
          "Something went wrong. Please try again.\n${e.toString()}",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  Future<void> signInWithPhone(final credential) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      final user = userCredential.user;
      if (user != null) {
        final userModel = UserModel(
          email: user.email,
          name: user.displayName,
          id: user.uid,
          userInfoDone: false,
          phone: int.parse(user.phoneNumber ?? "0"),
          gender: "",
          program: "",
          year: null,
          guardian: "",
          emergency1: null,
          emergency2: null,
        );

        await db
            .collection("Users")
            .doc(user.uid)
            .set(userModel.toJson(), SetOptions(merge: true));

        // Step 6: Navigate with smooth transition

        Get.to(
          () => WelcomeScreen5(username: user.phoneNumber ?? "User"),
          transition: Transition.fadeIn,
          duration: Duration(milliseconds: 600),
        );
      }
    } catch (e) {
      if (e is SocketException) {
        // No internet (general device network failure)
        Get.snackbar(
          "No Internet",
          "Check your internet connection",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e is PlatformException &&
          (e.code == 'network_error' ||
              e.message?.contains('ApiException: 7') == true)) {
        // Firebase/Google Play Services network error
        Get.snackbar(
          "No Internet",
          "Check your internet connection",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        // Other error
        Get.snackbar(
          "Error",
          "Something went wrong. Please try again.\n${e.toString()}",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  Future<void> createFavHostels(Hostels hostel, UserModel usermodel) async {
    await db
        .collection("Users")
        .doc(usermodel.id)
        .collection("favHostels")
        .doc(hostel.name)
        .set(hostel.toJson());
  }

  Future<void> createVariables() async {
    try {
      // Get all documents in the 'Private Hostels' collection
      QuerySnapshot privateHostelsSnapshot = await db
          .collectionGroup('roomTypes')
          .get();

      // Iterate through the documents and update each one
      for (QueryDocumentSnapshot doc in privateHostelsSnapshot.docs) {
        try {
          // if (doc['type'] == "2in1") {
          await doc.reference.update({
            // 'price': 4700.55,
            'createdAt': FieldValue.serverTimestamp(),
          });
          // }
          // if (doc['type'] == "3in1") {
          //   await doc.reference.update({
          //     'price': 3300.55,
          //   });
          // } else if (doc['type'] == "4in1") {
          //   await doc.reference.update({
          //     'price': 2000.55,
          //     // 'bills_utilities': [
          //     //   "Electricity",
          //     //   "tap water",
          //     //   "wifi",
          //     //   "generator",
          //     //   "waste bins",
          //     //   "shuttle services",
          //     //   "laundry",
          //     //   "cafeteria",
          //     // ],
          //     // 'security_safety': [
          //     //   "fire extinguishers",
          //     //   "Fencing & gated entry",
          //     //   "Emergency Exits",
          //     //   "First Aid kits",
          //     //   "24/7 Security",
          //     // ]
          //   });
          // }
          print('Updated document: ${doc.id}');
        } catch (e) {
          print('Error updating document ${doc.id}: $e');
        }
      }

      print('Finished updating documents in "Private Hostels" collection.');
    } catch (e) {
      print('Error getting documents from "Private Hostels" collection: $e');
    }
  }

  Future<List<BookedHostels>> getBookedHostels(User user) async {
    List<BookedHostels> bookedHostels = [];
    try {} catch (e) {
      print(e.toString());
    }
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
        .collection("Users")
        .doc(user.uid)
        .collection("Booked hostels")
        .get();
    try {
      bookedHostels = querySnapshot.docs
          .map((e) => BookedHostels.fromJson(e.data()))
          .toList();
    } catch (e) {
      print(e.toString());
    }

    print(bookedHostels);
    return bookedHostels;
  }

  Future<Map<String, dynamic>> setupHostelRoomStructures() async {
    final firestore = FirebaseFirestore.instance;
    WriteBatch batch = firestore.batch();
    int processedCount = 0;

    try {
      // 1. Get all private hostels
      final privateHostelsQuery = await firestore
          .collectionGroup('Private Hostels')
          .get();

      if (privateHostelsQuery.docs.isEmpty) {
        return {
          'success': false,
          'message': 'No private hostels found to process',
        };
      }

      // Define strongly-typed room configurations
      final List<Map<String, dynamic>> roomConfigurations = [
        {'type': '2in1', 'totalRooms': 5},
        {'type': '3in1', 'totalRooms': 3},
        {'type': '4in1', 'totalRooms': 2},
      ];

      // 2. Process each private hostel
      for (final hostelDoc in privateHostelsQuery.docs) {
        final roomTypesRef = hostelDoc.reference.collection('roomTypes');

        // 3. Create each room type with rooms
        for (final config in roomConfigurations) {
          final String roomType = config['type'] as String; // Explicit cast
          final int totalRooms = config['totalRooms'] as int;

          // Set document ID to match the room type
          final roomTypeRef = roomTypesRef.doc(roomType);

          // Add room type document
          batch.set(roomTypeRef, {
            'type': roomType,
            'totalRooms': totalRooms,
            'availableRooms': totalRooms,
            'createdAt': FieldValue.serverTimestamp(),
          });

          // Create individual rooms
          for (int i = 1; i <= totalRooms; i++) {
            final roomNumber =
                '${roomType.replaceAll('in', '')}${i.toString().padLeft(2, '0')}';
            final roomRef = roomTypeRef.collection('rooms').doc('room_$i');

            batch.set(roomRef, {
              'number': roomNumber,
              'isAvailable': true,
              'type': roomType,
              'createdAt': FieldValue.serverTimestamp(),
            });
          }
        }

        processedCount++;

        // Commit batches in chunks
        if (processedCount % 10 == 0) {
          await batch.commit();
          batch = firestore.batch();
        }
      }

      // Commit any remaining operations
      if (processedCount % 10 != 0) {
        await batch.commit();
      }

      return {
        'success': true,
        'message':
            'Successfully initialized room structures for $processedCount private hostels',
        'hostelsProcessed': processedCount,
      };
    } catch (e) {
      print('Error setting up room structures: $e');
      return {
        'success': false,
        'message': 'Failed to initialize room structures: ${e.toString()}',
      };
    }
  }

  Future<Hostels> getHostelsByName(String hostel_name) async {
    late Hostels hostelByName;
    try {
      final querySnapshot = await db
          .collectionGroup("Private Hostels")
          .where("name", isEqualTo: hostel_name)
          .get();

      DocumentSnapshot<Map<String, dynamic>> query =
          await querySnapshot.docs.first;
      hostelByName = Hostels.fromJson(query.data()!);
      String fullPath = query.reference.path;

      // Example path: "Regions/Ashanti/Cities/Ayeduase/Private Hostels/Wagyingo"
      List<String> pathSegments = fullPath.split('/');

      String region = pathSegments[1];
      String city = pathSegments[3];
      await query.reference.update({'region': region, 'city': city});
    } catch (e) {
      Get.snackbar(
        "Error",
        "An unknown error occurred. Please try again later. \n ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    print("hostelByName: $hostelByName");

    return hostelByName;
  }

  Future<UserModel?> getUserInfo(User? user) async {
    try {
      if (user == null) {
        Get.snackbar(
          "Error",
          "Please sign in to continue",
          snackPosition: SnackPosition.BOTTOM,
        );
        return null;
      }

      // Get user document from Firestore
      final docSnapshot = await db.collection("Users").doc(user.uid).get();

      if (!docSnapshot.exists || docSnapshot.data() == null) {
        Get.snackbar(
          "Error",
          "User data not found.",
          snackPosition: SnackPosition.BOTTOM,
        );
        return null;
      }

      // Convert Firestore document to UserModel
      final userModel = UserModel.fromJson(docSnapshot.data()!);
      print("User model: $userModel");
      return userModel;
    } catch (e) {
      Get.snackbar(
        "Error",
        "An unknown error occurred. Please try again later.\n${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  Future<List<BookedHostels>> getPaidHostels(User user) async {
    List<BookedHostels> bookedHostels = [];
    try {} catch (e) {
      print(e.toString());
    }
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
        .collection("Users")
        .doc(user.uid)
        .collection("Booked hostels")
        .where("paid", isEqualTo: true)
        .get();
    try {
      bookedHostels = querySnapshot.docs
          .map((e) => BookedHostels.fromJson(e.data()))
          .toList();
    } catch (e) {
      print(e.toString());
    }

    print(bookedHostels);
    return bookedHostels;
  }

  Future<List<BookedHostels>> getPendingHostels(User user) async {
    List<BookedHostels> bookedHostels = [];

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
        .collection("Users")
        .doc(user.uid)
        .collection("Booked hostels")
        .where("paid", isEqualTo: false)
        .get();
    try {
      bookedHostels = querySnapshot.docs
          .map((e) => BookedHostels.fromJson(e.data()))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
    }

    debugPrint(bookedHostels.toString());
    return bookedHostels;
  }
}
