import 'package:get/get.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/firebase/firestore_db.dart';
// import 'package:flutter/material.dart';

class HostelController extends GetxController {
  final FirestoreDb _db = FirestoreDb.instance;

  final RxList<Hostels> popularHostels = <Hostels>[].obs;
  final RxList<Hostels> privateHostels = <Hostels>[].obs;
  final RxList<Hostels> schoolHostels = <Hostels>[].obs;
  final RxList<Regions> regions = <Regions>[].obs;
  RxBool isloading = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   isloading.value = true;
  //   _db.getPopularStream().listen((data) {
  //     popularHostels.assignAll(data);
  //   });

  //   _db.getPrivateHostelsStream().listen((data) {
  //     privateHostels.assignAll(data);
  //   });

  //   // _db.getSchoolHostelsStream().listen((data) {
  //   //   schoolHostels.assignAll(data);
  //   // });

  //   _db.getRegionsStream().listen((data) {
  //     regions.assignAll(data);
  //   });
  //   isloading.value = false;
  // }
@override
void onInit() {
  super.onInit();
  isloading.value = true;

  _db.getPopularStream().listen((data) {
    popularHostels.assignAll(data);
    isloading.value = false; // 👈 first data arrived
  });

  _db.getPrivateHostelsStream().listen((data) {
    privateHostels.assignAll(data);
  });

  _db.getRegionsStream().listen((data) {
    regions.assignAll(data);
  });
}

}
