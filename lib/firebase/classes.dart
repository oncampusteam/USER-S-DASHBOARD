import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

Regions regionsFromJson(String str) => Regions.fromJson(json.decode(str));
String regionsToJson(Regions data) => json.encode(data.toJson());
//
//
Hostels hostelsFromJson(String str) => Hostels.fromJson(json.decode(str));
String hostelsToJson(Hostels data) => json.encode(data.toJson());
//
//
RoomTypes roomTypesFromJson(String str) => RoomTypes.fromJson(json.decode(str));
String roomTypesToJson(RoomTypes data) => json.encode(data.toJson());
//
//
// SchoolHostels schoolhostelsFromJson(String str) =>
//     SchoolHostels.fromJson(json.decode(str));
// String schoolhostelsToJson(SchoolHostels data) => json.encode(data.toJson());

// UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
// String userModelToJson(SchoolHostels data) => json.encode(data.toJson());

class Regions {
  Regions({required this.id, required this.name});
  String name;
  String id;
  factory Regions.fromJson(Map<String, dynamic> json) =>
      Regions(name: json["name"], id: json["id"]);

  Map<String, dynamic> toJson() => {"name": name, "id": id};
}

class Hostels {
  Hostels({
    required this.name,
    required this.amt_per_year,
    required this.description,
    required this.available_rooms,
    required this.distance_car,
    required this.gender,
    required this.distance_walk,
    required this.hostel_images,
    required this.rate,
    required this.amenities,
    required this.bills_utilities,
    required this.security_safety,
    required this.ispopular,
    required this.region,
    required this.city,
    required this.university,
  });

  String name;
  int? amt_per_year;
  String? description;
  int? available_rooms;
  int? distance_car;
  String? gender;
  int? distance_walk;
  List<String?>? hostel_images;
  int? rate;
  List<String?>? amenities;
  List<String?>? bills_utilities;
  List<String?>? security_safety;
  bool? ispopular;
  String? region;
  String? city;
  String? university;

  factory Hostels.fromJson(Map<String, dynamic> json) => Hostels(
    name: json["name"],
    amt_per_year: json["amt_per_year"],
    description: json["description"],
    available_rooms: json["available_rooms"],
    distance_car: json["distance_car"],
    gender: json["gender"],
    distance_walk: json["distance_walk"],
    hostel_images: json["hostel_images"] != null
        ? List<String?>.from(json["hostel_images"])
        : null,
    rate: json["rate"],
    amenities: json["amenities"] != null
        ? List<String?>.from(json["amenities"])
        : null,
    bills_utilities: json["bills_utilities"] != null
        ? List<String?>.from(json["bills_utilities"])
        : null,
    security_safety: json["security_safety"] != null
        ? List<String?>.from(json["security_safety"])
        : null,
    ispopular: json["ispopular"],
    region: json["region"],
    city: json["city"],
    university: json["university"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "amt_per_year": amt_per_year,
    "description": description,
    "available_rooms": available_rooms,
    "distance_car": distance_car,
    "gender": gender,
    "distance_walk": distance_walk,
    "hostel_images": hostel_images != null
        ? List<dynamic>.from(hostel_images!.map((x) => x))
        : null,
    "rate": rate,
    // "amenities": amenities,
    "amenities": amenities != null
        ? List<dynamic>.from(amenities!.map((x) => x))
        : null,
    "ispopular": ispopular,
    "region": region,
    "city": city,
    "university": university,
  };
}

// class SchoolHostels {
//   SchoolHostels({
//     required this.name,
//     required this.region,
//     required this.university,
//   });

//   String name;
//   String region;
//   String university;

//   factory SchoolHostels.fromJson(Map<String, dynamic> json) => SchoolHostels(
//         name: json["name"],
//         region: json["region"],
//         university: json["university"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "region": region,
//         "university": university,
//       };
// }

class UserModel {
  UserModel({
    required this.name,
    required this.id,
    required this.email,
    required this.guardian,
    required this.gender,
    required this.phone,
    required this.program,
    required this.year,
    required this.emergency1,
    required this.emergency2,
    required this.userInfoDone,
  });

  String? name;
  String? id;
  String? email;
  String? guardian;
  String? gender;
  int? phone;
  String? program;
  int? year;
  int? emergency1;
  int? emergency2;
  bool? userInfoDone;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    id: json["id"],
    email: json["email"],
    guardian: json["guardian"],
    gender: json["gender"],
    phone: json["phone"],
    program: json["program"],
    year: json["year"],
    emergency1: json["emergency1"],
    emergency2: json["emergency2"],
    userInfoDone: json["userInfoDone"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "email": email,
    "guardian": guardian,
    "gender": gender,
    "phone": phone,
    "program": program,
    "year": year,
    "emergency1": emergency1,
    "emergency2": emergency2,
    "userInfoDone": userInfoDone,
  };
}

class RoomTypes {
  RoomTypes({
    required this.availableRooms,
    required this.createdAt,
    required this.price,
    required this.totalRooms,
    required this.type,
  });

  int? availableRooms;
  Timestamp? createdAt;
  double? price;
  int? totalRooms;
  String? type;

  factory RoomTypes.fromJson(Map<String, dynamic> json) => RoomTypes(
    availableRooms: json["availableRooms"],
    createdAt: json["createdAt"],
    price: double.parse(json["price"].toString()),
    totalRooms: json["totalRooms"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "availableRooms": availableRooms,
    "createdAt": createdAt,
    "price": price,
    "totalRooms": totalRooms,
    "type": type,
  };
}

class BookedHostels {
  BookedHostels({
    required this.people_booking,
    required this.duration,
    required this.email,
    required this.gender,
    required this.hostel_name,
    required this.isDone,
    required this.move_in,
    required this.move_out,
    required this.name,
    required this.paid,
  });

  int? people_booking;
  int? duration;
  String? email;
  String? gender;
  String? hostel_name;
  bool? isDone;
  String? move_in;
  String? move_out;
  String? name;
  bool? paid;

  factory BookedHostels.fromJson(Map<String, dynamic> json) => BookedHostels(
    people_booking: json["people_booking"],
    duration: json["duration"],
    email: json["email"],
    gender: json["gender"],
    hostel_name: json["hostel_name"],
    isDone: json["isDone"],
    move_in: json["move_in"],
    move_out: json["move_out"],
    name: json["name"],
    paid: json["paid"],
  );

  Map<String, dynamic> toJson() => {
    "people_booking": people_booking,
    "duration": duration,
    "email": email,
    "gender": gender,
    "hostel_name": hostel_name,
    "isDone": isDone,
    "move_in": move_in,
    "move_out": move_out,
    "name": name,
    "paid": paid,
  };
}
