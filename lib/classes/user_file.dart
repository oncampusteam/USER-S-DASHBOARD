import 'package:flutter/material.dart';
import 'package:on_campus/firebase/classes.dart';

Map<String, dynamic> userInformation = {
  "previously_viewed": ValueNotifier<Set<Hostels>>(<Hostels>{}),
  "wish_list" : Set<Hostels>,
  
};
