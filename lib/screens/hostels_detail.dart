import 'dart:math';
import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:on_campus/screens/media.dart';
import 'package:on_campus/classes/classes.dart';
import 'package:on_campus/firebase/consts.dart';
import 'package:on_campus/screens/enquire.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_campus/firebase/firestore_db.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:on_campus/screens/hostels_detail_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_campus/firebase/favorites_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:on_campus/widgets/hostel_details_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:on_campus/screens/Home%20Page%20Views/payment.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
// import 'package:on_campus/screens/bottom_nav.dart';
// import 'package:on_campus/classes/user_file.dart';
// import 'package:on_campus/screens/Home Page Views/home.dart' as home;

// import 'package:on_campus/classes/user_file.dart';
// import 'package:on_campus/screens/get_icon.dart';

class HostelDetails extends StatefulWidget {
  final Hostels hostel;
  // final bool favorite;
  // final int index;
  // final String type;
  const HostelDetails({
    super.key,
    required this.hostel,
    // required this.favorite,
    // required this.index,
    // required this.type,
  });

  @override
  State<HostelDetails> createState() => _HostelDetailsState();
}

String generateSixDigitCode() {
  // Generates a number between 100,000 and 999,999
  int code = Random.secure().nextInt(900000) + 100000;
  return code.toString();
}

// List<List<Map<String, dynamic>>> roomdifference = [];
List<Map<String, dynamic>> currentRoom = [];
int offset = 0;

int capacity(String roomtype) {
  if (roomtype == "1in1") {
    return 1;
  }
  if (roomtype == "2in1") {
    return 2;
  }
  if (roomtype == "3in1") {
    return 3;
  }
  if (roomtype == "4in1") {
    return 4;
  }
  if (roomtype == "5in1") {
    return 5;
  }
  if (roomtype == "6in1") {
    return 6;
  }
  if (roomtype == "7in1") {
    return 7;
  }
  if (roomtype == "8in1") {
    return 8;
  }
  if (roomtype == "9in1") {
    return 9;
  }
  if (roomtype == "10in1") {
    return 10;
  }
  return 0;
}

List<List<Map<String, dynamic>>> sort(
  List<Map<String, dynamic>> rooms,
  int capacity,
) {
  List<Map<String, dynamic>> roomsWithBedSpace = [];
  List<Map<String, dynamic>> roomsWithOutBedSpace = [];
  debugPrint("This is the value of rooms: ${rooms.length}");
  for (Map<String, dynamic> room in rooms) {
    if (capacity == 1) {
      roomsWithOutBedSpace.add(room);
      // return [roomsWithOutBedSpace, roomsWithBedSpace];
    }
    else if (room["tenant"] == 0) {
      roomsWithOutBedSpace.add(room);
    }
    else if (room["tenant"]> 0 && room["tenant"] < capacity) {
      roomsWithBedSpace.add(room);
    }
  }
  return [roomsWithOutBedSpace, roomsWithBedSpace];
}

Stream<List<Map<String, dynamic>>> availableRoomIdsStream({
  required String regionName,
  required String cityName,
  required String categoryName,
  required String hostelName,
  required String roomType,
}) {
  // debugPrint("$regionName, $cityName, $categoryName, $hostelName, $roomType");
  return FirebaseFirestore.instance
      .collection("Region")
      .doc(regionName)
      .collection("Cities")
      .doc(cityName)
      .collection("${categoryName}s")
      .doc(hostelName)
      .collection("roomTypes")
      .doc(roomType)
      .collection("rooms")
      .where("isAvailable", isEqualTo: true)
      .snapshots()
      .map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data();
          // debugPrint("This is the doc data return : ${doc.data()}");
          return {
            "createdAt": data["createdAt"],
            "isAvailable": data["isAvailable"],
            "number": data["number"],
            "type": data["type"],
            "tenant": data["tenant"],
            "id": doc.id,
          };
        }).toList();
      });
}

String gender = "";
String selectedGender = "";
ScrollController controller = ScrollController();
List<TextEditingController> occupantNames = [];
List<TextEditingController> occupantEmails = [];
List<TextEditingController> occupantPhones = [];
TextEditingController numPeople = TextEditingController();
GlobalKey key = GlobalKey();
String roomtype = "";
int availableRooms = 0;
// String roomId = "";

class _HostelDetailsState extends State<HostelDetails> {
  final FavoritesController favCtrl = Get.put(FavoritesController());
  int selectedIndex = 0;
  List<RoomTypes> roomTypes = [];
  bool isLoading = false;
  bool isChecked = false;
  User? user = FirebaseAuth.instance.currentUser;

  LatLng? initialPose;
  LatLng? currentPosition;

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 13);
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Location location = Location();

  Future<void> getLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    location.onLocationChanged.listen((LocationData currentLocation) async {
      try {
        if (currentLocation.latitude != null &&
            currentLocation.longitude != null) {
          if (mounted) {
            setState(() {
              currentPosition = LatLng(
                currentLocation.latitude ?? 0,
                currentLocation.longitude ?? 0,
              );

              //khalil you can turn this on if you want the camera or map to follow the currentlocation when it moves
              // _cameraToPosition(currentPosition!);
            });
          }
        }
        final coords = await getPolylinePoints();
        generatePolyLineFromPoints(coords);

        if (mounted) {
          setState(() {});
        }
      } catch (e) {
        debugPrint(
          "This is an error in hostels_details.dart\n and this is the error : $e",
        );
      }
    });
  }

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  Map<PolylineId, Polyline> polylines = {};

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.black,
      points: polylineCoordinates,
      width: 8,
    );
    // Made changes, if not working remove mounted and find a way to fix the solution ##NOTICE
    if (mounted) {
      setState(() {
        polylines[id] = polyline;
      });
    }
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints(apiKey: GOOGLE_MAPS_API_KEY);
    RoutesApiRequest request = RoutesApiRequest(
      origin: PointLatLng(
        currentPosition?.latitude ?? 0,
        currentPosition?.longitude ?? 0,
      ),
      destination: PointLatLng(
        initialPose?.latitude ?? 0,
        initialPose?.longitude ?? 0,
      ),
      travelMode: TravelMode.driving,
      routingPreference: RoutingPreference.trafficAware,
    );

    // Get route using Routes API
    RoutesApiResponse response = await polylinePoints
        .getRouteBetweenCoordinatesV2(request: request);

    if (response.routes.isNotEmpty) {
      // debugPrint('Duration: ${response.routes.first.durationMinutes} minutes');
      // print('Distance: ${response.routes.first.distanceKm} km');

      // Get polyline points
      List<PointLatLng> points = response.routes.first.polylinePoints ?? [];
      points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      Get.snackbar("Error Getting Polyline Points", "${response.errorMessage}");
      debugPrint(response.errorMessage);
    }
    return polylineCoordinates;
  }

  final ScrollController _scrollController = ScrollController();
  final TextEditingController dateControllerMovein = TextEditingController(
    text: DateFormat('MM-dd-yyyy').format(DateTime.now()),
  );
  final TextEditingController dateControllerMoveout = TextEditingController(
    text: DateFormat('MM-dd-yyyy').format(
      DateTime(
        DateTime.now().year + 1,
        DateTime.now().month,
        DateTime.now().day,
      ),
    ),
  );

  final Map<String, GlobalKey> _sectionKeys = {};
  final _formkey = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();

  String roomTypeText(String string) {
    if (string == "2in1") return "2 in a";
    if (string == "1in1") return "1 in a";
    if (string == "3in1") return "3 in a";
    if (string == "4in1") return "4 in a";
    if (string == "5in1") return "5 in a";
    if (string == "6in1") return "6 in a";
    if (string == "7in1") return "7 in a";
    if (string == "8in1") return "8 in a";
    if (string == "9in1") return "9 in a";
    if (string == "10in1") return "10 in a";

    return "";
  }

  Future<void> getRoomTypes() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    roomTypes = await FirestoreDb.instance.roomTypes(widget.hostel);

    setState(() {
      isLoading = false;
    });
  }

  void occupantFields({
    required int count,
    required StateSetter setModalState,
    required List<TextEditingController> occupantNames,
    required List<TextEditingController> occupantEmails,
    required List<TextEditingController> occupantPhones,
  }) {
    if (count >= 1 && count <= 4) {
      setModalState(() {
        occupantNames.clear();
        occupantEmails.clear();
        occupantPhones.clear();

        for (int i = 0; i < count; i++) {
          occupantNames.add(TextEditingController());
          occupantEmails.add(TextEditingController());
          occupantPhones.add(TextEditingController());
        }
      });
    } else {
      Get.snackbar(
        "Incorrect value",
        "You can book for up to 4 occupants only",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // late bool favorite;
  @override
  void initState() {
    super.initState();

    //debugPrint("This is the value from widget.fvorite : ${widget.favorite}");
    // favorite = widget.favorite;
    //debugPrint("this is the value of $favorite");
    getRoomTypes().then((_) {
      for (var room in roomTypes) {
        _sectionKeys[room.type ?? "null"] = GlobalKey();
      }
      for (final tile in tileList) {
        _sectionKeys[tile.name] = GlobalKey();
      }
    });
    // occupantFields(1);

    final lat = double.tryParse(widget.hostel.latitude ?? '');
    final lng = double.tryParse(widget.hostel.longitude ?? '');

    if (lat != null && lng != null) {
      initialPose = LatLng(lat, lng);
    } else {
      initialPose = const LatLng(6.73968, -1.56516);
      debugPrint('Invalid hostel coordinates');
    }
    try {
      getLocation().then(
        (_) => {
          getPolylinePoints().then(
            (coordinates) => {generatePolyLineFromPoints(coordinates)},
          ),
        },
      );
    } catch (e) {
      debugPrint(
        "This is an error in initState of hostels_detail.dart, funct getLocation : $e",
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String? sectionString) {
    final context = _sectionKeys[sectionString]?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.1,
      );
    }
  }

  List<Photos> tileList = [
    Photos(name: "Overview"),
    Photos(name: "Description"),
    Photos(name: "Amenities"),
    Photos(name: "Room type"),
    Photos(name: "Policies"),
    Photos(name: "Faqs"),
  ];
  List<Swipper> swipers = [
    Swipper(image: "assets/search/search_imgs.jpeg"),
    Swipper(image: "assets/search/search_imgs_1.jpeg"),
    Swipper(image: "assets/search/search_imgs_2.jpeg"),
    Swipper(image: "assets/search/search_imgs_3.jpeg"),
    Swipper(image: "assets/search/search_imgs_4.jpeg"),
  ];

  int duration = 1;

  dynamic showDate() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return setDate(setModalState);
          },
        );
      },
    );
  }

  Widget selectWidget(StateSetter setModalState) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),

      height: MediaQuery.of(context).size.height * 0.35,
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 5.h,
              width: 30.w,
              decoration: BoxDecoration(
                color: const Color(0xFF79747E),
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
            5.verticalSpace,
            Text(
              "Select Info",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp.clamp(0, 16),
                letterSpacing: 0.2,
              ),
            ),
            15.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gender",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp.clamp(0, 16),
                        letterSpacing: 0.2,
                      ),
                    ),
                    Text(
                      "Choose your gender",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        color: const Color(0xFF333333),
                        fontSize: 9.sp.clamp(0, 9),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    genderSelector(setModalState, "M"),
                    25.horizontalSpace,
                    genderSelector(setModalState, "F"),
                  ],
                ),
              ],
            ),
            15.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Duration",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp.clamp(0, 16),
                        letterSpacing: 0.2,
                      ),
                    ),
                    Text(
                      "Maximum 4 years",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        color: const Color(0xFF333333),
                        fontSize: 10.sp.clamp(0, 10),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (duration >= 2) {
                          setModalState(() {
                            duration--;
                          });
                        }
                      },
                      child: Container(
                        height: 30.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                              color: Colors.black.withOpacity(0.05),
                            ),
                          ],
                        ),
                        child: const Align(
                          child: Text(
                            "-",
                            style: TextStyle(color: Color(0xFF00EFD1)),
                          ),
                        ),
                      ),
                    ),
                    5.horizontalSpace,
                    Text(
                      "$duration",
                      style: TextStyle(
                        fontSize: 16.sp.clamp(0, 16),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    5.horizontalSpace,
                    GestureDetector(
                      onTap: () {
                        if (duration <= 3) {
                          setModalState(() {
                            duration++;
                          });
                        }
                      },
                      child: Container(
                        height: 30.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                              color: const Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                          ],
                        ),
                        child: const Align(
                          child: Text(
                            "+",
                            style: TextStyle(color: Color(0xFF00EFD1)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            50.verticalSpace,
            SizedBox(
              height: Constant.height * 0.06,
              width: double.infinity,
              child: FilledButton(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                    ),
                  ),
                  backgroundColor: const WidgetStatePropertyAll(
                    Color.fromARGB(255, 0, 239, 209),
                  ),
                ),
                onPressed: () async {
                  // setModalState(() {
                  //   // isLoading = true;
                  // });
                  // final user = FirebaseAuth.instance.currentUser;
                  // await FirebaseFirestore.instance
                  //     .collection('Users')
                  //     .doc(user!.uid)
                  //     .collection('Booked hostels')
                  //     .doc(widget.hostel.name) // Set your own ID
                  //     .set({
                  //       'gender': selectedGender == "M" ? "male" : "female",
                  //       'duration': duration,
                  //     }, SetOptions(merge: true));

                  // setModalState(() {
                  //   // isLoading = false;
                  // });
                  showDate();
                  // setDate(setModalState);
                },
                child:
                    // isLoading
                    //     ? Align(
                    //         alignment: Alignment.center,
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             SizedBox(
                    //               width: 15,
                    //               height: 15,
                    //               child: CircularProgressIndicator(
                    //                 color: Colors.white,
                    //               ),
                    //             ),
                    //             SizedBox(width: 5),
                    //             Text("Please wait.."),
                    //           ],
                    //         ),
                    //       )
                    //     :
                    SizedBox(
                      height: Constant.height * 0.03,
                      child: FittedBox(
                        child: Text(
                          "Continue",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w600,
                            fontSize: 17.sp.clamp(0, 17),
                          ),
                        ),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget book(
    StateSetter setModalState,
    TextEditingController numPeople,
    TextEditingController name,
    TextEditingController emailAddress,
    List<TextEditingController> occupantEmails,
    List<TextEditingController> occupantNames,
    List<TextEditingController> occupantPhones,
    int Function() roomCapacity,
  ) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      height: Constant.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),

      padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 10.h),
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: Constant.width,
              child: Align(
                child: Container(
                  height: 5.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF79747E),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
              ),
            ),
            5.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "20% Off",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp.clamp(0, 12),
                    letterSpacing: 0.15.w,
                    color: const Color(0xFF00EFD1),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_border_outlined,
                      size: 15.h,
                      color: const Color(0xFF00EFD1),
                    ),
                    Text(
                      "4.5",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.15.w,
                        fontSize: 12.sp.clamp(0, 12),
                        color: const Color(0xFF323232),
                      ),
                    ),
                    Text(
                      " (180 reviews)",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.15.w,
                        fontSize: 12.sp.clamp(0, 12),
                        color: const Color.fromRGBO(50, 50, 50, 0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            5.verticalSpace,
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.hostel.hostel_images?[0]["imageUrl"] ?? "",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${roomCapacity()} in a Room Bedroom Apartment",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "GH₵ 4000/"),
                          TextSpan(
                            text: "Academic year",
                            style: TextStyle(fontSize: 8),
                          ),
                        ],
                      ),
                    ),
                    Text("Available Rooms", style: TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),
            const Divider(color: Color.fromRGBO(120, 120, 120, 0.3)),
            SizedBox(height: 5),
            Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Constant.width * 0.6,
                    child: FittedBox(
                      child: Text(
                        "Number of people booking?",
                        style: TextStyle(
                          fontSize: 15.sp.clamp(0, 15),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2.w,
                          color: const Color(0xFF323232),
                        ),
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  TextFormField(
                    // initialValue: "1",
                    enableInteractiveSelection: false,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        int count = int.tryParse(value) ?? 1;
                        occupantFields(
                          count: count,
                          setModalState: setModalState,
                          occupantNames: occupantNames,
                          occupantEmails: occupantEmails,
                          occupantPhones: occupantPhones,
                        );
                        setModalState(() {});
                      }
                    },
                    enabled: isChecked,
                    controller: numPeople,
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.grey),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(1),
                    ],
                    decoration: InputDecoration(
                      // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF00EFD1)),
                      ),
                      labelText: "1",
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1,
                          style: BorderStyle.none,
                          color: const Color.fromRGBO(158, 158, 158, 0.3),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      // if (value == null || value.isEmpty) {
                      //   return 'Please enter a number';
                      // }
                      final num = int.parse(value ?? "1");
                      if (num > roomCapacity()) {
                        setState(() {
                          // //debugPrint("suppose to jump");
                          controller.jumpTo(0);
                        });
                        return 'Enter a number between 1 and ${roomCapacity()}';
                      }

                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 4),
                    child: Text(
                      "Min 1 - Max ${roomCapacity()}",
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  SizedBox(height: 10),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < occupantNames.length; i++)
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                height: Constant.height * 0.03,
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Occupant ${i + 1}",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 15.sp.clamp(0, 15),
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.2.w,
                                      color: const Color(0xFF323232),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),

                            TextFormField(
                              enableInteractiveSelection: false,
                              controller: occupantNames[i],
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.grey),
                              decoration: InputDecoration(
                                labelText: i == 0
                                    ? "Full name of person Booking"
                                    : "Full Name of person booking for",
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF00EFD1),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 1,
                                    style: BorderStyle.none,
                                    color: const Color.fromRGBO(
                                      158,
                                      158,
                                      158,
                                      0.3,
                                    ),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  FocusScope.of(key.currentContext!).unfocus();
                                  if (i == 0 || i == 1) {
                                    setState(() {
                                      controller.jumpTo(Constant.height * 0.15);
                                    });
                                  }
                                  if (i == 2 || i == 3) {
                                    setState(() {
                                      controller.jumpTo(Constant.height * 0.9);
                                    });
                                  }
                                  if (i == 4 || i == 5) {
                                    setState(() {
                                      controller.jumpTo(
                                        Constant.height * 0.9 * (2),
                                      );
                                    });
                                  }
                                  // if (i == 6 || i == 7) {
                                  //   setState(() {
                                  //     controller.jumpTo(Constant.height * 0.85 * (3));
                                  //   });
                                  // }
                                  // if (i == 8 || i == 9) {
                                  //   setState(() {
                                  //     controller.jumpTo(Constant.height * 0.85 * (4));
                                  //   });
                                  // }

                                  return i == 0
                                      ? "Please enter the name of the person booking"
                                      : "Please the name of the person booking for";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10.h),
                            TextFormField(
                              enableInteractiveSelection: false,
                              controller: occupantPhones[i],
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.grey),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                labelText: i == 0
                                    ? "Enter the person booking phone number"
                                    : "Enter the number of the person booking for",
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),

                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF00EFD1),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 1,
                                    style: BorderStyle.none,
                                    color: const Color.fromRGBO(
                                      158,
                                      158,
                                      158,
                                      0.3,
                                    ),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  FocusScope.of(key.currentContext!).unfocus();
                                  if (i == 0 || i == 1) {
                                    setState(() {
                                      controller.jumpTo(Constant.height * 0.15);
                                    });
                                  }
                                  if (i == 2 || i == 3) {
                                    setState(() {
                                      controller.jumpTo(Constant.height * 0.9);
                                    });
                                  }
                                  if (i == 4 || i == 5) {
                                    setState(() {
                                      controller.jumpTo(
                                        Constant.height * 0.9 * (2),
                                      );
                                    });
                                  }
                                  return i == 0
                                      ? 'Please enter the person booking phone number'
                                      : "Please enter the person booking for phone number";
                                }
                                if (value.isNotEmpty) {
                                  if (value.length < 10) {
                                    FocusScope.of(
                                      key.currentContext!,
                                    ).unfocus();
                                    if (i == 0 || i == 1) {
                                      setState(() {
                                        controller.jumpTo(
                                          Constant.height * 0.15,
                                        );
                                      });
                                    }
                                    if (i == 2 || i == 3) {
                                      setState(() {
                                        controller.jumpTo(
                                          Constant.height * 0.9,
                                        );
                                      });
                                    }
                                    if (i == 4 || i == 5) {
                                      setState(() {
                                        controller.jumpTo(
                                          Constant.height * 0.9 * (2),
                                        );
                                      });
                                    }
                                    return "The Phone number is not up to 10";
                                  }
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10.h),
                            TextFormField(
                              controller: occupantEmails[i],
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.grey),

                              decoration: InputDecoration(
                                labelText: i == 0
                                    ? "Person booking email"
                                    : "Occupant email",
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF00EFD1),
                                  ),
                                ),
                                fillColor: Colors.white,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 1,
                                    style: BorderStyle.none,
                                    color: const Color.fromRGBO(
                                      158,
                                      158,
                                      158,
                                      0.3,
                                    ),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                // if (value == null || value.isEmpty) {
                                //   return i==0 ? 'Please enter the person booking email address': "Please enter the person booking for email address";
                                // }
                                final emailRegex = RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                );

                                // 3️ Check if it matches
                                if (value != "") {
                                  // //debugPrint(
                                  //   "This is the value of value: $value",
                                  // );
                                  FocusScope.of(key.currentContext!).unfocus();
                                  if (i == 0 || i == 1) {
                                    setState(() {
                                      controller.jumpTo(Constant.height * 0.15);
                                    });
                                  }
                                  if (i == 2 || i == 3) {
                                    setState(() {
                                      controller.jumpTo(Constant.height * 0.9);
                                    });
                                  }
                                  if (i == 4 || i == 5) {
                                    setState(() {
                                      controller.jumpTo(
                                        Constant.height * 0.9 * (2),
                                      );
                                    });
                                  }
                                  // return "The Phone number is not up to 10";
                                  // }
                                  if (!emailRegex.hasMatch(value ?? "")) {
                                    return 'Enter a valid email address';
                                  }
                                }
                                return null;
                              },
                            ),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  top: 4,
                                ),
                                child: Text(
                                  "Optional",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w400,
                                    color: const Color.fromRGBO(0, 0, 0, 0.6),
                                  ),
                                ),
                              ),
                            ),
                            15.verticalSpace,
                          ],
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Color(0xFF00EFD1),
                        value: isChecked,
                        onChanged: (bool? newValue) {
                          setModalState(() {
                            isChecked = newValue!;
                            if (isChecked == false) {
                              occupantFields(
                                count: 1,
                                setModalState: setModalState,
                                occupantNames: occupantNames,
                                occupantEmails: occupantEmails,
                                occupantPhones: occupantPhones,
                              );
                              numPeople.text = "1";
                            }
                          });
                        },
                      ),
                      Text(
                        "Booking for others",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  SizedBox(height: 40.h),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    height: Constant.height * 0.06,
                    width: double.infinity,
                    child: FilledButton(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.r),
                            ),
                          ),
                        ),
                        backgroundColor: const WidgetStatePropertyAll(
                          Color.fromARGB(255, 0, 239, 209),
                        ),
                      ),
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          // setModalState(() {
                          //   isLoading = true;
                          // });

                          // final user = FirebaseAuth.instance.currentUser;

                          // List<Map<String, dynamic>> occupants = [];

                          // for (int i = 1; i < occupantNames.length; i++) {
                          //   occupants.add({
                          //     'name': occupantNames[i].text.trim(),
                          //     'email': occupantEmails[i].text.trim(),
                          //     'phoneNumber': occupantPhones[i].text.trim(),
                          //   });
                          // }
                          // await FirebaseFirestore.instance
                          //     .collection('Users')
                          //     .doc(user!.uid)
                          //     .collection('Booked hostels')
                          //     .doc(widget.hostel.name) // Set your own ID
                          //     .set({
                          //       'hostel_name': widget.hostel.name,
                          //       'paid': false,
                          //       'isDone': false,
                          //       'people_booking': int.parse(numPeople.text),
                          //       'name': occupantNames[0].text,
                          //       'occupants': occupants,
                          //       'email': occupantEmails[0].text,
                          //       'phone_number': occupantPhones[0].text,
                          //       'time': Timestamp.now(),
                          //     }, SetOptions(merge: true));

                          // final int totalPeople =
                          //     int.tryParse(numPeople.text) ?? 0;

                          // if (totalPeople == 0) return;

                          // final List<Map<String, dynamic>> students = [];

                          // for (int j = 0; j < totalPeople; j++) {
                          //   students.add({
                          //     "name": occupantNames[j].text.trim(),
                          //     "id": "Test$j",
                          //     "email": occupantEmails[j].text.trim(),
                          //     "phone": occupantPhones[j].text.trim(),
                          //     "hostel_booked": widget.hostel.name,
                          //     "roomType": "${roomCapacity()}in1",
                          //     "booked_by": j == 0
                          //         ? "self"
                          //         : occupantNames[0].text.trim(),
                          //     "createdAt": DateTime.now(),
                          //     "verified": false,
                          //   });
                          // }

                          // await FirebaseFirestore.instance
                          //     .collection('Managers')
                          //     .doc(widget.hostel.manager_id)
                          //     .set({
                          //       'students': FieldValue.arrayUnion(students),
                          //     }, SetOptions(merge: true));

                          // setModalState(() {
                          //   isLoading = false;
                          // });
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder:
                                    (
                                      BuildContext context,
                                      StateSetter setModalState,
                                    ) {
                                      return selectWidget(setModalState);
                                    },
                              );
                            },
                          );
                        }
                      },
                      child:
                          // isLoading
                          //     ? Align(
                          //         alignment: Alignment.center,
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             SizedBox(
                          //               width: 15,
                          //               height: 15,
                          //               child: CircularProgressIndicator(
                          //                 color: Colors.white,
                          //               ),
                          //             ),
                          //             SizedBox(width: 5),
                          //             Text("Please wait.."),
                          //           ],
                          //         ),
                          //       )
                          //     :
                          SizedBox(
                            height: Constant.height * 0.03,
                            child: FittedBox(
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.sp.clamp(0, 20),
                                ),
                              ),
                            ),
                          ),
                    ),
                  ),
                ],
              ),
            ),
            if (keyboardHeight > 0) SizedBox(height: keyboardHeight),
          ],
        ),
      ),
    );
  }

  Widget setDate(StateSetter setModalState) {
    return SingleChildScrollView(
      child: Container(
        height: Constant.height * 0.6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),

        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
        child: Form(
          key: _formkey2,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Align(
                  child: Container(
                    height: 5.h,
                    width: 30.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF79747E),
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                  ),
                ),
              ),
              5.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "20% Off",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp.clamp(0, 12),
                      letterSpacing: 0.15.w,
                      color: const Color(0xFF00EFD1),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_border_outlined,
                        size: 15.h,
                        color: const Color(0xFF00EFD1),
                      ),
                      Text(
                        "4.5",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.15.w,
                          fontSize: 12.sp.clamp(0, 12),
                          color: const Color(0xFF323232),
                        ),
                      ),
                      Text(
                        " (180 reviews)",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.15.w,
                          fontSize: 12.sp.clamp(0, 12),
                          color: const Color.fromRGBO(50, 50, 50, 0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              5.verticalSpace,
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.hostel.hostel_images?[0]["imageUrl"] ?? "",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "4in Room Bedroom Apartment",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: "GH₵ 4000/"),
                            TextSpan(
                              text: "Academic year",
                              style: TextStyle(fontSize: 8),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Available Rooms:",
                            style: TextStyle(fontSize: 10),
                          ),
                          SizedBox(width: 10.w),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(color: Color.fromRGBO(120, 120, 120, 0.3)),
              SizedBox(height: 5),

              Text(
                "Book Hostel",
                style: TextStyle(
                  fontSize: 18.sp.clamp(0, 18),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2.w,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 7),
              Text(
                "Move in",
                style: TextStyle(
                  fontSize: 15.sp.clamp(0, 15),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2.w,
                  color: const Color(0xFF323232),
                ),
              ),
              7.verticalSpace,
              SizedBox(
                height: 60,
                child: TextFormField(
                  focusNode: FocusNode(canRequestFocus: false),
                  cursorColor: Colors.white,
                  controller: dateControllerMovein,
                  readOnly: true,
                  // onTap: () {
                  //   _selectDate(
                  //     context,
                  //     dateControllerMovein,
                  //     dateControllerMoveout,
                  //   );
                  // },
                  decoration: InputDecoration(
                    labelText: "date",
                    labelStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1,
                        style: BorderStyle.none,
                        color: const Color.fromRGBO(158, 158, 158, 0.3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFF00EFD1)),
                    ),
                    suffix: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        // _selectDate(
                        //   context,
                        //   dateControllerMovein,
                        //   dateControllerMoveout,
                        // );
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please pick a date';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 4),
                child: Text("MM/DD/YYYY", style: TextStyle(fontSize: 10)),
              ),
              SizedBox(height: 10),
              Text(
                "Move out",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15.sp.clamp(0, 15),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2.w,
                  color: const Color(0xFF323232),
                ),
              ),
              SizedBox(height: 7.h),
              SizedBox(
                height: 60,
                child: TextFormField(
                  focusNode: FocusNode(canRequestFocus: false),
                  cursorColor: Colors.white,
                  controller: dateControllerMoveout,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "date",
                    labelStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1,
                        style: BorderStyle.none,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFF00EFD1)),
                    ),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 4),
                child: Text("MM/DD/YYYY", style: TextStyle(fontSize: 10)),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: Constant.height * 0.06,
                width: double.infinity,
                child: FilledButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      ),
                    ),
                    backgroundColor: const WidgetStatePropertyAll(
                      Color.fromARGB(255, 0, 239, 209),
                    ),
                  ),

                  // onPressed: () async {
                  //   int roomCapacity() {
                  //     if (roomtype != "") {
                  //       if (roomtype == "1in1") {
                  //         return 1;
                  //       }
                  //       if (roomtype == "2in1") {
                  //         return 2;
                  //       }
                  //       if (roomtype == "3in1") {
                  //         return 3;
                  //       }
                  //       if (roomtype == "4in1") {
                  //         return 4;
                  //       }
                  //       if (roomtype == "5in1") {
                  //         return 5;
                  //       }
                  //       if (roomtype == "6in1") {
                  //         return 6;
                  //       }
                  //       if (roomtype == "7in1") {
                  //         return 7;
                  //       }
                  //       if (roomtype == "8in1") {
                  //         return 8;
                  //       }
                  //       if (roomtype == "9in1") {
                  //         return 9;
                  //       }
                  //       if (roomtype == "10in1") {
                  //         return 10;
                  //       }
                  //     }
                  //     return 0;
                  //   }

                  //   if (_formkey2.currentState!.validate()) {
                  //     setModalState(() {
                  //       isLoading = true;
                  //     });
                  //     int roomCap = roomCapacity();
                  //     final user = FirebaseAuth.instance.currentUser;
                  //     List<Map<String, dynamic>> occupants = [];

                  //     for (int i = 1; i < occupantNames.length; i++) {
                  //       occupants.add({
                  //         'name': occupantNames[i].text.trim(),
                  //         'email': occupantEmails[i].text.trim(),
                  //         'phoneNumber': occupantPhones[i].text.trim(),
                  //       });
                  //     }

                  //     Map<String, dynamic>? _findRoomForGroup(
                  //       int groupSize,
                  //       int capacity,
                  //       List<Map<String, dynamic>> rooms,
                  //     ) {
                  //       for (final room in rooms) {
                  //         final int tenant = room["tenant"];
                  //         if (tenant + groupSize <= capacity) {
                  //           return room;
                  //         }
                  //       }
                  //       return null;
                  //     }

                  //     // bool split = false;
                  //     void addOccupants(Map<String,dynamic> room, int totalPeople) async {
                  //       final List<Map<String, dynamic>> students = [];

                  //       if (offset == 0) {
                  //         await FirebaseFirestore.instance
                  //             .collection('Users')
                  //             .doc(user?.uid)
                  //             .collection('Booked hostels')
                  //             .doc(widget.hostel.name) // Set your own ID
                  //             .set({
                  //               'hostel_name': widget.hostel.name,
                  //               'paid': false,
                  //               // 'isDone': false,
                  //               'people_booking': int.parse(numPeople.text),
                  //               'name': occupantNames[0].text,
                  //               'occupants': occupants,
                  //               'email': occupantEmails[0].text,
                  //               'phone_number': occupantPhones[0].text,
                  //               'time': Timestamp.now(),
                  //               'move_in': dateControllerMovein.text,
                  //               'move_out': dateControllerMoveout.text,
                  //               'isDone': true,
                  //               'gender': selectedGender == "M"
                  //                   ? "male"
                  //                   : "female",
                  //               'duration': duration,
                  //               'amount': widget.hostel.amt_per_year,
                  //               'roomId': room["id"],
                  //             }, SetOptions(merge: true));
                  //       }

                  //       // final int totalPeople = int.tryParse(numPeople.text) ?? 0;

                  //       if (totalPeople == 0) return;

                  //       for (int j = 0 + offset; j < totalPeople + offset; j++) {
                  //         students.add({
                  //           "name": occupantNames[j].text.trim(),
                  //           "id":
                  //               "${occupantNames[j].text.trim().split(" ")[0]}${generateSixDigitCode()}",
                  //           "email": occupantEmails[j].text.trim(),
                  //           "phone": occupantPhones[j].text.trim(),
                  //           "hostel_booked": widget.hostel.name,
                  //           "roomType": "$roomCap in a room",
                  //           "booked_by": j == 0
                  //               ? "self"
                  //               : occupantNames[0].text.trim(),
                  //           "createdAt": DateTime.now(),
                  //           "verified": false,
                  //           'move_in': dateControllerMovein.text,
                  //           'move_out': dateControllerMoveout.text,
                  //           'gender': selectedGender == "M" ? "male" : "female",
                  //           'duration': duration,
                  //           'paid': false,
                  //           'status': 'pending',
                  //           'paymentStatus': 'pending',
                  //           'commissionAmount':
                  //               widget.hostel.amt_per_year ?? 0 * 0.15,
                  //           'paymentMethod': '',
                  //           'amount': 0,
                  //           'paymentRef': "",
                  //           'institution_name': widget.hostel.institution_name,
                  //           'roomId': room["id"]
                  //         });
                  //         offset = offset + 1;
                  //       }

                  //       await FirebaseFirestore.instance
                  //           .collection('Managers')
                  //           .doc(widget.hostel.manager_id)
                  //           .set({
                  //             'students': FieldValue.arrayUnion(students),
                  //           }, SetOptions(merge: true));

                  //      if(room["tenant"] + totalPeople == roomCap){
                  //        await FirebaseFirestore.instance
                  //           .collection("Region")
                  //           .doc(widget.hostel.region)
                  //           .collection("Cities")
                  //           .doc(widget.hostel.city)
                  //           .collection(widget.hostel.category)
                  //           .doc(widget.hostel.name)
                  //           .collection("roomTypes")
                  //           .doc(roomtype)
                  //           .set({
                  //             'available_rooms': availableRooms != 0
                  //                 ? --availableRooms
                  //                 : 0,
                  //           });

                  //       await FirebaseFirestore.instance
                  //           .collection("Region")
                  //           .doc(widget.hostel.region)
                  //           .collection("Cities")
                  //           .doc(widget.hostel.city)
                  //           .collection(widget.hostel.category)
                  //           .doc(widget.hostel.name)
                  //           .collection("roomTypes")
                  //           .doc(roomtype)
                  //           .collection("rooms")
                  //           .doc(room["id"])
                  //           .set({'isAvailable': false});
                  //      }
                  //     }

                  //     List<String> allocateRecursively({
                  //       required int peopleBooking,
                  //       required int roomCap,
                  //       required List<Map<String, dynamic>> rooms,
                  //     }) {
                  //       List<String> allocatedRooms = [];

                  //       void _allocate(int people) {
                  //         if (people <= 0) return;

                  //         // 1️⃣ Try placing the whole group first
                  //         final room = _findRoomForGroup(
                  //           people,
                  //           roomCap,
                  //           rooms,
                  //         );

                  //         if (room != null) {
                  //           allocatedRooms.add(room["id"]);
                  //           room["tenant"] += people; // update local state
                  //           return;
                  //         }

                  //         // 2️⃣ If can't place, split the group
                  //         int left = people ~/ 2; // integer division
                  //         int right = people - left; // handles odd numbers

                  //         // Example:
                  //         // 5 → 2 & 3
                  //         // 7 → 3 & 4

                  //         _allocate(left);
                  //         _allocate(right);
                  //       }

                  //       _allocate(peopleBooking);

                  //       return allocatedRooms;
                  //     }

                  //     allocateRecursively(
                  //       peopleBooking: int.parse(numPeople.text),
                  //       roomCap: roomCap,
                  //       rooms: currentRoom,
                  //     );

                  //     setModalState(() {
                  //       isLoading = false;
                  //     });
                  //     Get.to(
                  //       () => Payment(user: user!, subject: "Payment"),
                  //       transition: Transition.fadeIn,
                  //       duration: const Duration(milliseconds: 600),
                  //       curve: Curves.easeIn,
                  //     );
                  //   }
                  // },
                  // onPressed: () async {

                  // Future<void> bookRoomsTransaction({
                  //     required List<Map<String, dynamic>> allocations,
                  //     required int roomCap,
                  //     required User user,
                  //   }) async {
                  //     final firestore = FirebaseFirestore.instance;

                  //     await firestore.runTransaction((transaction) async {
                  //       for (final allocation in allocations) {
                  //         final roomId = allocation["roomId"];
                  //         final List<int> indexes = allocation["occupantIndexes"];

                  //         final roomRef = firestore
                  //             .collection("Region")
                  //             .doc(widget.hostel.region)
                  //             .collection("Cities")
                  //             .doc(widget.hostel.city)
                  //             .collection(widget.hostel.category)
                  //             .doc(widget.hostel.name)
                  //             .collection("roomTypes")
                  //             .doc(roomtype)
                  //             .collection("rooms")
                  //             .doc(roomId);

                  //         final roomSnap = await transaction.get(roomRef);

                  //         if (!roomSnap.exists) {
                  //           throw Exception("Room not found");
                  //         }

                  //         final int tenant = roomSnap["tenant"];

                  //         if (tenant + indexes.length > roomCap) {
                  //           throw Exception("Room already full");
                  //         }

                  //         // 🔹 Update tenant
                  //         transaction.update(roomRef, {
                  //           "tenant": tenant + indexes.length,
                  //           "isAvailable": tenant + indexes.length == roomCap ? false : true,
                  //         });

                  //         // 🔹 Add students
                  //         for (final i in indexes) {
                  //           final studentRef = firestore
                  //               .collection("Managers")
                  //               .doc(widget.hostel.manager_id)
                  //               .collection("students")
                  //               .doc();

                  //           transaction.set(studentRef, {
                  //             "name": occupantNames[i].text.trim(),
                  //             "email": occupantEmails[i].text.trim(),
                  //             "phone": occupantPhones[i].text.trim(),
                  //             "roomId": roomId,
                  //             "hostel": widget.hostel.name,
                  //             "createdAt": FieldValue.serverTimestamp(),
                  //             "status": "pending",
                  //           });
                  //         }
                  //       }
                  //     });
                  //   }

                  //   List<Map<String, dynamic>> allocateRecursivelyWithIndexes({
                  //   required int peopleBooking,
                  //   required int roomCap,
                  //   required List<Map<String, dynamic>> rooms,
                  // }) {
                  //   final List<Map<String, dynamic>> allocations = [];
                  //   int currentIndex = 0;

                  //   Map<String, dynamic>? findRoom(int groupSize) {
                  //     for (final room in rooms) {
                  //       if (room["tenant"] + groupSize <= roomCap) {
                  //         return room;
                  //       }
                  //     }
                  //     return null;
                  //   }

                  //   void allocate(int people) {
                  //       if (people <= 0) return;

                  //       final room = findRoom(people);

                  //       // ✅ Direct placement
                  //       if (room != null) {
                  //         allocations.add({
                  //           "roomId": room["id"],
                  //           "occupantIndexes":
                  //               List.generate(people, (i) => currentIndex + i),
                  //         });

                  //         room["tenant"] += people;
                  //         currentIndex += people;
                  //         return;
                  //       }

                  //       // ❌ If only 1 person and no room fits → REAL failure
                  //       if (people == 1) {
                  //         throw Exception("No available bed space for booking");
                  //       }

                  //       // 🔹 Safe split (people >= 2 guaranteed here)
                  //       final int left = people ~/ 2;
                  //       final int right = people - left;

                  //       allocate(left);
                  //       allocate(right);
                  //     }

                  //   allocate(peopleBooking);
                  //   return allocations;
                  // }

                  //   if (!_formkey2.currentState!.validate()) return;

                  //   setModalState(() => isLoading = true);

                  //   try {
                  //     final int peopleBooking = int.parse(numPeople.text);
                  //     final int roomCap = capacity(roomtype);
                  //     final user = FirebaseAuth.instance.currentUser!;

                  //     // 1️⃣ Decide allocation
                  //     final allocations = allocateRecursivelyWithIndexes(
                  //       peopleBooking: peopleBooking,
                  //       roomCap: roomCap,
                  //       rooms: currentRoom,
                  //     );

                  //     // 2️⃣ Commit atomically
                  //     await bookRoomsTransaction(
                  //       allocations: allocations,
                  //       roomCap: roomCap,
                  //       user: user,
                  //     );

                  //     // 3️⃣ Success
                  //     Get.snackbar("Success", "Booking completed successfully");
                  //   } catch (e) {
                  //     Get.snackbar("Booking Failed", e.toString());
                  //   } finally {
                  //     setModalState(() => isLoading = false);
                  //   }
                  // },
                  onPressed: () async {
                    if (!_formkey2.currentState!.validate()) return;

                    setModalState(() => isLoading = true);

                    try {
                      final firestore = FirebaseFirestore.instance;
                      final user = FirebaseAuth.instance.currentUser!;
                      final int peopleBooking = int.parse(numPeople.text);
                      final int roomCap = capacity(roomtype);

                      // 🔹 Build occupants list
                      final List<Map<String, dynamic>> occupants = [];
                      for (int i = 0; i < occupantNames.length; i++) {
                        occupants.add({
                          "name": occupantNames[i].text.trim(),
                          "email": occupantEmails[i].text.trim(),
                          "phone": occupantPhones[i].text.trim(),
                        });
                      }

                      /// ================================
                      /// 1️⃣ GREEDY ALLOCATION (NO RECURSION)
                      /// ================================
                      List<Map<String, dynamic>> allocateGreedy({
                        required int peopleBooking,
                        required int roomCap,
                        required List<Map<String, dynamic>> rooms,
                      }) {
                        final List<Map<String, dynamic>> allocations = [];
                        int remaining = peopleBooking;
                        int currentIndex = 0;

                        rooms.sort((a, b) {
                          final aFree = roomCap - a["tenant"];
                          final bFree = roomCap - b["tenant"];
                          return bFree.compareTo(aFree);
                        });

                        for (final room in rooms) {
                          if (remaining <= 0) break;

                          final int freeBeds = roomCap - room["tenant"] as int;
                          if (freeBeds <= 0) continue;

                          final int assign = freeBeds >= remaining
                              ? remaining
                              : freeBeds;

                          allocations.add({
                            "roomId": room["id"],
                            "occupantIndexes": List.generate(
                              assign,
                              (i) => currentIndex + i,
                            ),
                          });

                          room["tenant"] += assign; // local mutation
                          currentIndex += assign;
                          remaining -= assign;
                        }

                        if (remaining < 0) {
                          throw Exception("Not enough available bed space");
                        }

                        return allocations;
                      }

                      final allocations = allocateGreedy(
                        peopleBooking: peopleBooking,
                        roomCap: roomCap,
                        rooms: currentRoom,
                      );

                      debugPrint("Allocatoins: $allocations");

                      /// ================================
                      /// 2️⃣ FIRESTORE TRANSACTION
                      /// ================================
                      await firestore.runTransaction((transaction) async {
                        for (final allocation in allocations) {
                          final String roomId = allocation["roomId"];
                          final List<int> indexes =
                              allocation["occupantIndexes"];

                          final roomRef = firestore
                              .collection("Region")
                              .doc(widget.hostel.region)
                              .collection("Cities")
                              .doc(widget.hostel.city)
                              .collection("${widget.hostel.category}s")
                              .doc(widget.hostel.name)
                              .collection("roomTypes")
                              .doc(roomtype)
                              .collection("rooms")
                              .doc(roomId);

                          final roomSnap = await transaction.get(roomRef);

                          if (!roomSnap.exists) {
                            throw Exception("Room not found");
                          }

                          final int tenant = roomSnap["tenant"];
                          if (tenant + indexes.length > roomCap) {
                            throw Exception("Room already filled");
                          }

                          // 🔹 Update room
                          transaction.update(roomRef, {
                            "tenant": tenant + indexes.length,
                            "isAvailable": tenant + indexes.length < roomCap,
                          });

                          debugPrint("ALLOCATIONS: $allocations");
                          // 🔹 Add students
                          final managerRef = firestore
                              .collection("Managers")
                              .doc(widget.hostel.manager_id);

                          // Build a list of student maps to add
                          final List<Map<String, dynamic>> studentsToAdd = [];

                          for (final i in indexes) {
                            studentsToAdd.add({
                              "name": occupantNames[i].text.trim(),
                              "email": occupantEmails[i].text.trim(),
                              "phone": occupantPhones[i].text.trim(),
                              "hostel": widget.hostel.name,
                              "roomType": "$roomCap in a room",
                              "roomId": roomId,
                              "booked_by": i == 0
                                  ? "self"
                                  : occupantNames[0].text.trim(),
                              "gender": selectedGender == "M"
                                  ? "male"
                                  : "female",
                              "move_in": dateControllerMovein.text,
                              "move_out": dateControllerMoveout.text,
                              "duration": duration,
                              "status": "pending",
                              "paid": false,
                              "createdAt": DateTime.now(),
                              "verified": false,
                              "id": "${occupantNames[i].text.trim().split(" ")[0]}${generateSixDigitCode()}",

                            });
                          }

                          // Update the "students" array in the manager document
                          transaction.set(managerRef, {
                            "students": FieldValue.arrayUnion(studentsToAdd),
                          }, SetOptions(merge: true));
                        }

                        // 🔹 Save booking summary once
                        final bookingRef = firestore
                            .collection("Users")
                            .doc(user.uid)
                            .collection("Booked hostels")
                            .doc(widget.hostel.name);

                        transaction.set(bookingRef, {
                          "hostel_name": widget.hostel.name,
                          "people_booking": peopleBooking,
                          "occupants": occupants,
                          "gender": selectedGender == "M" ? "male" : "female",
                          "move_in": dateControllerMovein.text,
                          "move_out": dateControllerMoveout.text,
                          "duration": duration,
                          "paid": false,
                          "createdAt": DateTime.now(),
                        }, SetOptions(merge: true));
                      });

                      // 🎉 SUCCESS
                      Get.snackbar("Success", "Room booked successfully");
                    } catch (e) {
                      Get.snackbar("Booking Failed", e.toString());
                    } finally {
                      setModalState(() => isLoading = false);
                    }
                  },

                  child: isLoading
                      ? Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 15,
                                height: 15,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text("Please wait.."),
                            ],
                          ),
                        )
                      : SizedBox(
                          height: Constant.height * 0.03,
                          child: FittedBox(
                            child: Text(
                              "Proceed to payment",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp.clamp(0, 20),
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Material(
        child: SafeArea(
          child: Scaffold(
            body: SizedBox(
              height: Constant.height,
              width: Constant.width,
              child: Stack(
                children: [
                  Positioned(
                    // top: Constant.height * 0.06,
                    child: SizedBox(
                      height: Constant.height,
                      // height: Constant.height - (Constant.height * 0.06),
                      width: Constant.width,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: Constant.height * 0.5,
                                  width: MediaQuery.of(context).size.width,
                                  color: const Color(0xFFF5F8FF),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.r),
                                    child: Swiper(
                                      controller: SwiperController(),
                                      autoplay: true,
                                      curve: Curves.easeIn,
                                      autoplayDelay: 5000,
                                      itemCount:
                                          widget.hostel.hostel_images!.length,
                                      itemBuilder: (context, index) {
                                        // Swipper swiper = swipers[index];
                                        String? string = widget
                                            .hostel
                                            .hostel_images![index]["imageUrl"];
                                        return CachedNetworkImage(
                                          imageUrl: string ?? "",
                                          width: MediaQuery.sizeOf(
                                            context,
                                          ).width,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              SpinKitThreeBounce(
                                                color: const Color.fromARGB(
                                                  255,
                                                  0,
                                                  239,
                                                  209,
                                                ),
                                                size: 50.0,
                                              ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  height: Constant.height * 0.5,
                                  // color: Colors.red,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color.fromRGBO(0, 0, 0, 0),
                                        // Color.fromRGBO(0, 0, 0, 0.2),
                                        // Color.fromRGBO(0, 0, 0, 0.4),
                                        Color.fromRGBO(0, 0, 0, 0.53),
                                        // Color.fromRGBO(0, 0, 0, 0.8),
                                        // Color.fromRGBO(0, 0, 0, 1),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Constant.height * 0.5,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: Constant.height * 0.5,
                                      color: Colors.transparent,
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(height: 16.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                  // await Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(builder: (_) => BottomNav(username: userInformation["username"])),
                                                  //   );
                                                  // setState(() {
                                                  //   debugPrint("Setting state");
                                                  // });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    left: 20.h,
                                                  ),
                                                  height: 45.h,
                                                  width: 45.w,

                                                  decoration: BoxDecoration(
                                                    color: const Color.fromRGBO(
                                                      255,
                                                      255,
                                                      255,
                                                      0.6,
                                                    ),
                                                    shape: BoxShape.circle,
                                                    // borderRadius: BorderRadius.circular(
                                                    //   8.r,
                                                    // ),
                                                  ),
                                                  child: Icon(
                                                    Icons.chevron_left,
                                                    color: Colors.black,
                                                    size: 24,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      right: 10.h,
                                                    ),
                                                    //
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          const Color.fromRGBO(
                                                            255,
                                                            255,
                                                            255,
                                                            0.6,
                                                          ),
                                                    ),
                                                    height: 45.h,
                                                    width: 45.w,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          top: 0,
                                                          left: 0,
                                                          right: 0,
                                                          bottom: 0,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                  12.r,
                                                                ),
                                                            child: Image.asset(
                                                              "assets/hostels_detail/share.png",
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // SizedBox(width: 5.h),
                                                  GestureDetector(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                        right: 20.h,
                                                      ),
                                                      //
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            const Color.fromRGBO(
                                                              255,
                                                              255,
                                                              255,
                                                              0.6,
                                                            ),
                                                      ),
                                                      height: 45.h,
                                                      width: 45.w,
                                                      child: Stack(
                                                        children: [
                                                          Positioned(
                                                            top: 0,
                                                            left: 0,
                                                            right: 0,
                                                            bottom: 0,
                                                            child: Obx(() {
                                                              final isFav = favCtrl
                                                                  .isFavorite(
                                                                    widget
                                                                        .hostel
                                                                        .id,
                                                                  );

                                                              return GestureDetector(
                                                                onTap: () => favCtrl
                                                                    .toggleFavorite(
                                                                      widget
                                                                          .hostel
                                                                          .id,
                                                                    ),

                                                                child: Icon(
                                                                  isFav
                                                                      ? Icons
                                                                            .favorite
                                                                      : Icons
                                                                            .favorite_border,
                                                                  color:
                                                                      Color.fromARGB(
                                                                        255,
                                                                        0,
                                                                        239,
                                                                        209,
                                                                      ),
                                                                ),
                                                              );
                                                            }),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Container(
                                            height: Constant.height * 0.22,
                                            // color: Colors.red,
                                            margin: EdgeInsets.symmetric(
                                              vertical: 5.h,
                                              horizontal: 15.h,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Align(
                                                  child: Container(
                                                    height:
                                                        Constant.height * 0.25,
                                                    margin: EdgeInsets.only(
                                                      top: 50.h,
                                                      left: 10.h,
                                                    ),
                                                    // color: Colors.red,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          // color: Colors.green,
                                                          height:
                                                              Constant.height *
                                                              0.04,
                                                          width:
                                                              Constant.width *
                                                              0.65,
                                                          child: FittedBox(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              widget
                                                                  .hostel
                                                                  .name,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                fontSize: 24.sp
                                                                    .clamp(
                                                                      0,
                                                                      24,
                                                                    ),
                                                                letterSpacing:
                                                                    0.1.w,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                left: 0.w,
                                                              ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              // SizedBox(height: 5.h),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    // color: Colors.pink,
                                                                    height:
                                                                        Constant
                                                                            .height *
                                                                        0.09,
                                                                    width:
                                                                        Constant
                                                                            .width *
                                                                        0.6,
                                                                    child: Stack(
                                                                      children: [
                                                                        Container(
                                                                          // color: Colors
                                                                          //     .yellow,
                                                                          height:
                                                                              Constant.height *
                                                                              0.05,
                                                                          width:
                                                                              Constant.width *
                                                                              0.6,
                                                                          child: Row(
                                                                            children: [
                                                                              SizedBox(
                                                                                height:
                                                                                    Constant.height *
                                                                                    0.04,
                                                                                width:
                                                                                    Constant.width *
                                                                                    0.06,
                                                                                child: Image.asset(
                                                                                  "assets/hostels_detail/location_white.png",
                                                                                  fit: BoxFit.fitHeight,
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height:
                                                                                    Constant.height *
                                                                                    0.02,
                                                                                child: FittedBox(
                                                                                  child: Text(
                                                                                    "${widget.hostel.city}, ${widget.hostel.region} Region",
                                                                                    style: TextStyle(
                                                                                      fontFamily: "Roboto",
                                                                                      fontWeight: FontWeight.w500,
                                                                                      color: Colors.white,
                                                                                      fontSize: 12.sp.clamp(
                                                                                        0,
                                                                                        12,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Positioned(
                                                                          top:
                                                                              Constant.height *
                                                                              0.041,
                                                                          left:
                                                                              0,
                                                                          right:
                                                                              0,
                                                                          child: Align(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child: SizedBox(
                                                                              width:
                                                                                  Constant.width *
                                                                                  0.06,
                                                                              height:
                                                                                  Constant.height *
                                                                                  0.015,
                                                                              child: Image.asset(
                                                                                "assets/hostels_detail/Rectangle 50.png",
                                                                                fit: BoxFit.contain,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Positioned(
                                                                          top:
                                                                              Constant.height *
                                                                              0.045,
                                                                          left:
                                                                              0,
                                                                          // right: 0,
                                                                          child: Container(
                                                                            // color: Colors.orange,
                                                                            width:
                                                                                Constant.width *
                                                                                0.6,
                                                                            height:
                                                                                Constant.height *
                                                                                0.05,
                                                                            child: Row(
                                                                              children: [
                                                                                Container(
                                                                                  // color: Colors.brown,
                                                                                  width:
                                                                                      Constant.width *
                                                                                      0.06,
                                                                                  height:
                                                                                      Constant.height *
                                                                                      0.045,
                                                                                  child: Image.asset(
                                                                                    "assets/hostels_detail/University_white.png",
                                                                                    fit: BoxFit.contain,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height:
                                                                                      Constant.height *
                                                                                      0.04,
                                                                                  child: FittedBox(
                                                                                    child: Text(
                                                                                      " Main Campus, ${widget.hostel.university ?? "University"}\n ${widget.hostel.city}",
                                                                                      style: TextStyle(
                                                                                        fontFamily: "Roboto",
                                                                                        fontWeight: FontWeight.w500,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              // 15.verticalSpace,
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SizedBox(
                                                                    height:
                                                                        Constant
                                                                            .height *
                                                                        0.03,
                                                                    child: const Icon(
                                                                      Icons
                                                                          .directions_walk_sharp,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        Constant
                                                                            .height *
                                                                        0.022,
                                                                    width:
                                                                        Constant
                                                                            .width *
                                                                        0.1,
                                                                    child: FittedBox(
                                                                      child: Text(
                                                                        // " 1 hour 08 min",
                                                                        "${widget.hostel.distance_walk} mins",
                                                                        style: TextStyle(
                                                                          fontFamily:
                                                                              "Roboto",
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize: 12.sp.clamp(
                                                                            0,
                                                                            12,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  10.horizontalSpace,
                                                                  SizedBox(
                                                                    height:
                                                                        Constant
                                                                            .height *
                                                                        0.022,

                                                                    child: Image.asset(
                                                                      "assets/hostels_detail/driving.png",
                                                                      fit: BoxFit
                                                                          .fitHeight,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        Constant
                                                                            .height *
                                                                        0.022,
                                                                    width:
                                                                        Constant
                                                                            .width *
                                                                        0.1,
                                                                    child: FittedBox(
                                                                      child: Text(
                                                                        " ${widget.hostel.distance_car} mins",
                                                                        style: TextStyle(
                                                                          fontFamily:
                                                                              "Roboto",
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize: 12.sp.clamp(
                                                                            0,
                                                                            12,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  10.horizontalSpace,
                                                                  SizedBox(
                                                                    height:
                                                                        Constant
                                                                            .height *
                                                                        0.022,
                                                                    child: FittedBox(
                                                                      child: Image.asset(
                                                                        "assets/hostels_detail/Bus_white.png",
                                                                        fit: BoxFit
                                                                            .fitHeight,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        Constant
                                                                            .height *
                                                                        0.022,
                                                                    width:
                                                                        Constant
                                                                            .width *
                                                                        0.1,
                                                                    child: FittedBox(
                                                                      child: Text(
                                                                        " ${widget.hostel.distance_car} mins",
                                                                        style: TextStyle(
                                                                          fontFamily:
                                                                              "Roboto",
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize: 12.sp.clamp(
                                                                            0,
                                                                            12,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 10.h,
                                                  ),
                                                  height: Constant.height * 0.5,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Container(
                                                      // color: Colors.blue,
                                                      margin: EdgeInsets.only(
                                                        right: 10.h,
                                                        top: 15.h,
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    10.r,
                                                                  ),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    10.r,
                                                                  ),
                                                              child: CachedNetworkImage(
                                                                imageUrl:
                                                                    widget
                                                                        .hostel
                                                                        .hostel_images?[2]["imageUrl"] ??
                                                                    "",
                                                                width:
                                                                    Constant
                                                                        .width *
                                                                    0.115,
                                                                height:
                                                                    Constant
                                                                        .height *
                                                                    0.05,
                                                                fit: BoxFit
                                                                    .cover,
                                                                placeholder:
                                                                    (
                                                                      context,
                                                                      url,
                                                                    ) => SpinKitThreeBounce(
                                                                      color:
                                                                          const Color.fromARGB(
                                                                            255,
                                                                            0,
                                                                            239,
                                                                            209,
                                                                          ),
                                                                      size:
                                                                          10.0,
                                                                    ),
                                                                errorWidget:
                                                                    (
                                                                      context,
                                                                      url,
                                                                      error,
                                                                    ) => Icon(
                                                                      Icons
                                                                          .error,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          // SizedBox(height: 10.h),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    10.r,
                                                                  ),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    10.r,
                                                                  ),
                                                              child: CachedNetworkImage(
                                                                height:
                                                                    Constant
                                                                        .height *
                                                                    0.05,
                                                                width:
                                                                    Constant
                                                                        .width *
                                                                    0.115,
                                                                imageUrl:
                                                                    widget
                                                                        .hostel
                                                                        .hostel_images?[1]["imageUrl"] ??
                                                                    "",
                                                                fit: BoxFit
                                                                    .cover,
                                                                placeholder:
                                                                    (
                                                                      context,
                                                                      url,
                                                                    ) => SpinKitThreeBounce(
                                                                      color:
                                                                          const Color.fromARGB(
                                                                            255,
                                                                            0,
                                                                            239,
                                                                            209,
                                                                          ),
                                                                      size:
                                                                          10.0,
                                                                    ),
                                                                errorWidget:
                                                                    (
                                                                      context,
                                                                      url,
                                                                      error,
                                                                    ) => Icon(
                                                                      Icons
                                                                          .error,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          // SizedBox(height: 10.h),
                                                          GestureDetector(
                                                            onTap: () {
                                                              // Get.to(
                                                              //   () => MediaScreen(
                                                              //     type:
                                                              //         "photos",
                                                              //     media:
                                                              //         (widget.hostel.hostel_images ??
                                                              //                 [])
                                                              //             .whereType<
                                                              //               String
                                                              //             >()
                                                              //             .toList(),
                                                              //   ),
                                                              // );
                                                            },
                                                            child: Container(
                                                              height:
                                                                  Constant
                                                                      .height *
                                                                  0.05,
                                                              width:
                                                                  Constant
                                                                      .width *
                                                                  0.115,
                                                              decoration: BoxDecoration(
                                                                border: Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 2.w,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      10.r,
                                                                    ),
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      10.r,
                                                                    ),
                                                                child: SizedBox(
                                                                  height:
                                                                      Constant
                                                                          .height *
                                                                      0.05,
                                                                  width:
                                                                      Constant
                                                                          .width *
                                                                      0.115,
                                                                  child: Stack(
                                                                    children: [
                                                                      CachedNetworkImage(
                                                                        imageUrl:
                                                                            widget.hostel.hostel_images?[0]["imageUrl"] ??
                                                                            "",
                                                                        width:
                                                                            Constant.width *
                                                                            0.115,
                                                                        height:
                                                                            Constant.height *
                                                                            0.05,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        placeholder:
                                                                            (
                                                                              context,
                                                                              url,
                                                                            ) => SpinKitThreeBounce(
                                                                              color: const Color.fromARGB(
                                                                                255,
                                                                                0,
                                                                                239,
                                                                                209,
                                                                              ),
                                                                              size: 10.0,
                                                                            ),
                                                                        errorWidget:
                                                                            (
                                                                              context,
                                                                              url,
                                                                              error,
                                                                            ) => Icon(
                                                                              Icons.error,
                                                                            ),
                                                                      ),
                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                          color: Color.fromRGBO(
                                                                            51,
                                                                            51,
                                                                            51,
                                                                            0.1,
                                                                          ),
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(
                                                                            "+${(widget.hostel.hostel_images?.length ?? 0) - 3 > 0 ? (widget.hostel.hostel_images!.length - 3) : 0}",
                                                                            style: TextStyle(
                                                                              fontFamily: "Poppins",
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 12.sp,
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              color: const Color(0xFFF5F8FF),
                              child: Column(
                                children: [
                                  Container(
                                    // padding: const EdgeInsets.symmetric(
                                    //   horizontal: 15.0,
                                    // ),
                                    child: SizedBox(
                                      height: 70.h,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: Constant.height * 0.05,
                                            width: Constant.width * 0.27,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16).r,
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: Align(
                                              child: SizedBox(
                                                height: Constant.height * 0.022,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      "assets/hostels_detail/photo.png",
                                                      fit: BoxFit.contain,
                                                    ),
                                                    Container(
                                                      // color: Colors.amber,
                                                      height:
                                                          Constant.height *
                                                          0.021,
                                                      // width: Constant.width * 0.1,
                                                      child: FittedBox(
                                                        child: Text(
                                                          " Photos",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Work Sans",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 13.sp
                                                                .clamp(0, 13),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: Constant.height * 0.05,
                                            width: Constant.width * 0.27,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: Align(
                                              child: SizedBox(
                                                height: Constant.height * 0.02,
                                                width: Constant.width * 0.28,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      "assets/hostels_detail/video.png",
                                                      fit: BoxFit.contain,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          Constant.height *
                                                          0.021,
                                                      child: FittedBox(
                                                        child: Text(
                                                          " Videos",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Work Sans",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 13.sp
                                                                .clamp(0, 13),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: Constant.height * 0.05,
                                            width: Constant.width * 0.28,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: SizedBox(
                                              height: Constant.height * 0.045,
                                              width: Constant.width * 0.27,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "assets/hostels_detail/360 Degree Rotate.png",
                                                    fit: BoxFit.contain,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        Constant.height * 0.021,
                                                    child: FittedBox(
                                                      child: Text(
                                                        " View",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Work Sans",
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 13.sp.clamp(
                                                            0,
                                                            13,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFFFFF),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color.fromRGBO(
                                            158,
                                            158,
                                            158,
                                            0.5,
                                          ),
                                          spreadRadius: 3.r,
                                          blurRadius: 8.r,
                                          // offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    height: Constant.height * 0.06,
                                    width: Constant.width,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: tileList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                            Photos tile = tileList[index];
                                            return Center(
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selectedIndex = index;
                                                  });
                                                  _scrollToSection(tile.name);
                                                },
                                                child: AnimatedContainer(
                                                  height:
                                                      Constant.height * 0.06,
                                                  duration: const Duration(
                                                    milliseconds: 300,
                                                  ),
                                                  margin:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                      ),
                                                  // padding:
                                                  //     const EdgeInsets.symmetric(
                                                  //       vertical: 8,
                                                  //     ),
                                                  decoration: BoxDecoration(
                                                    // color: Colors.blue,
                                                    border:
                                                        selectedIndex == index
                                                        ? Border(
                                                            bottom: BorderSide(
                                                              color:
                                                                  const Color(
                                                                    0xFF00EFD1,
                                                                  ),
                                                              width: 1.5.w,
                                                            ),
                                                          )
                                                        : null,
                                                  ),
                                                  child: Align(
                                                    child: SizedBox(
                                                      height:
                                                          Constant.height *
                                                          0.02,
                                                      child: FittedBox(
                                                        child: Text(
                                                          tile.name,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                "Poppins",
                                                            color:
                                                                selectedIndex ==
                                                                    index
                                                                ? null
                                                                : Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  Container(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 20.w,
                                        right: 20.w,
                                        top: 5.h,
                                        bottom: 10.h,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            key: _sectionKeys['Description'],
                                            alignment: Alignment.topLeft,
                                            child: SizedBox(
                                              height: Constant.height * 0.035,
                                              child: FittedBox(
                                                child: Text(
                                                  "Description",
                                                  style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20.sp.clamp(
                                                      0,
                                                      20,
                                                    ),
                                                    letterSpacing: 0.15.w,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            widget.hostel.description ?? "",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: const Color(0xFF787878),
                                              fontSize: 12.sp.clamp(0, 12),
                                            ),
                                          ),
                                          const Divider(
                                            color: Color.fromRGBO(
                                              120,
                                              120,
                                              120,
                                              0.7,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Read More",
                                              style: TextStyle(
                                                fontFamily: "Poppins",
                                                letterSpacing: 0.15.w,
                                                color: const Color(0xFF00EFD1),
                                                fontSize: 15.sp.clamp(0, 15),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.h),

                                  /// Amenities
                                  ///  &
                                  /// Bills & Utilities
                                  /// &
                                  /// Security
                                  Container(
                                    // color: const Color.fromRGBO(255, 255, 255, 1),
                                    color: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 25.h,
                                    ),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          key: _sectionKeys["Amenities"],
                                          child: SizedBox(
                                            height: Constant.height * 0.035,
                                            child: FittedBox(
                                              child: Text(
                                                "Amenities",
                                                style: TextStyle(
                                                  fontSize: 20.sp.clamp(0, 20),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10.h),

                                        utilities(
                                          hostel: widget.hostel,
                                          context: context,
                                          type: "Amenities",
                                          amenities: true,
                                        ),

                                        SizedBox(height: 20.h),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: SizedBox(
                                            height: Constant.height * 0.032,
                                            child: FittedBox(
                                              child: Text(
                                                "Bills & Utilities",
                                                style: TextStyle(
                                                  letterSpacing: 0.15.w,
                                                  fontSize: 16.sp.clamp(0, 16),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(height: 10.h),
                                        utilities(
                                          hostel: widget.hostel,
                                          context: context,
                                          type: "Bills & Utilities",
                                          bills: true,
                                        ),
                                        SizedBox(height: 20.h),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: SizedBox(
                                            // color: Colors.blue,
                                            height: Constant.height * 0.033,
                                            child: FittedBox(
                                              child: Text(
                                                "Security & Safety",
                                                style: TextStyle(
                                                  fontSize: 16.sp.clamp(0, 16),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        utilities(
                                          hostel: widget.hostel,
                                          type: "Security & Saftety",
                                          context: context,
                                          security: true,
                                        ),
                                        SizedBox(height: 20.h),
                                      ],
                                    ),
                                  ),

                                  // /// Amenities
                                  ///  &
                                  /// Bills & Utilities
                                  /// &
                                  /// Security
                                  ///
                                  ///
                                  SizedBox(height: 20.h),
                                  Container(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        // left: 30.w,
                                        top: 20.h,
                                      ),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        key: _sectionKeys['Room type'],
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: 30.w,
                                              ),
                                              height: Constant.height * 0.035,
                                              child: FittedBox(
                                                child: Text(
                                                  "Room Types(${roomTypes.length})",
                                                  style: TextStyle(
                                                    fontSize: 20.sp.clamp(
                                                      0,
                                                      20,
                                                    ),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              physics: BouncingScrollPhysics(),
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 30.w),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          // left: 4,
                                                          vertical: 8,
                                                        ),
                                                    child: SizedBox(
                                                      child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          elevation: 0,
                                                          padding:
                                                              EdgeInsets.symmetric(
                                                                horizontal: 10,
                                                                vertical: 5,
                                                              ),
                                                          foregroundColor:
                                                              Colors.white,
                                                          backgroundColor:
                                                              Color(0xFF00EFD1),
                                                        ),
                                                        onPressed: () {
                                                          _scrollToSection(
                                                            "Room type",
                                                          );
                                                        },
                                                        child: SizedBox(
                                                          height:
                                                              Constant.height *
                                                              0.025,
                                                          child: FittedBox(
                                                            child: Text(
                                                              "All",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Manrope",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12.sp,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    color: Colors.white,
                                                    child: Row(
                                                      children: [
                                                        ...List.generate(roomTypes.length, (
                                                          index,
                                                        ) {
                                                          bool isRoomAvailable =
                                                              true;
                                                          RoomTypes rooms =
                                                              roomTypes[index];
                                                          if (rooms.availableRooms ==
                                                                  null ||
                                                              rooms.availableRooms ==
                                                                  0) {
                                                            setState(() {
                                                              isRoomAvailable =
                                                                  false;
                                                            });
                                                          }
                                                          return Row(
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets.only(
                                                                      left: 8,
                                                                      top: 8,
                                                                      bottom: 8,
                                                                    ),
                                                                child: SizedBox(
                                                                  // height: 30,
                                                                  child: ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                      elevation:
                                                                          0,
                                                                      padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            5,
                                                                      ),
                                                                      // foregroundColor:
                                                                      //     Colors.black,
                                                                      backgroundColor:
                                                                          Color(
                                                                            0xFFEFEFEF,
                                                                          ),
                                                                    ),
                                                                    onPressed: () {
                                                                      _scrollToSection(
                                                                        rooms
                                                                            .type,
                                                                      );
                                                                    },
                                                                    child: SizedBox(
                                                                      height:
                                                                          Constant
                                                                              .height *
                                                                          0.025,
                                                                      child: FittedBox(
                                                                        child: Text(
                                                                          "${roomTypeText(rooms.type ?? "")} Room",
                                                                          style: TextStyle(
                                                                            fontFamily:
                                                                                "Manrope",
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize:
                                                                                12.sp,
                                                                            color: Color(
                                                                              0xFF101219,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),

                                                              // if ((index - 1) ==
                                                              //     roomTypes.length)
                                                              //   SizedBox(width: 30.w),
                                                            ],
                                                          );
                                                        }),
                                                        SizedBox(width: 30.w),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Divider(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  isLoading
                                      ? CircularProgressIndicator(
                                          color: Color(0xFF00EFD1),
                                        )
                                      : SingleChildScrollView(
                                          controller: _scrollController,
                                          child: Column(
                                            children: List.generate(roomTypes.length, (
                                              index,
                                            ) {
                                              bool isRoomAvailable = true;
                                              RoomTypes room = roomTypes[index];
                                              if (room.availableRooms == null ||
                                                  room.availableRooms == 0) {
                                                setState(() {
                                                  isRoomAvailable = false;
                                                });
                                              }
                                              return Column(
                                                children: [
                                                  Container(
                                                    color: Colors.white,
                                                    key:
                                                        _sectionKeys[room.type],
                                                    // color: Colors.white,
                                                    margin: EdgeInsets.only(
                                                      bottom: 25.w,
                                                      // left: 20.h,
                                                      // right: 20.h
                                                    ),
                                                    padding:
                                                        EdgeInsets.only(
                                                          top: 25.h,
                                                          bottom: 25.h,
                                                          left: 25.w,
                                                        ),
                                                    child: StreamBuilder<List<Map<String, dynamic>>>(
                                                      stream:
                                                          availableRoomIdsStream(
                                                            regionName:
                                                                widget
                                                                    .hostel
                                                                    .region ??
                                                                "",
                                                            cityName:
                                                                widget
                                                                    .hostel
                                                                    .city ??
                                                                "",
                                                            categoryName: widget
                                                                .hostel
                                                                .category,
                                                            hostelName: widget
                                                                .hostel
                                                                .name,
                                                            roomType:
                                                                roomTypes[index]
                                                                    .type ??
                                                                "",
                                                          ),
                                                      builder: (context, snapshot) {
                                                        if (!snapshot.hasData) {
                                                          return CircularProgressIndicator();
                                                        }
                                                        final rooms =
                                                            snapshot.data!;

                                                        debugPrint(
                                                          "This is the length of the rooms fetched: ${rooms.length}",
                                                        );

                                                        List<
                                                          Map<String, dynamic>
                                                        >
                                                        roomsWithBedSpace = [];
                                                        List<
                                                          Map<String, dynamic>
                                                        >
                                                        roomsWithoutBedSpace =
                                                            [];

                                                        List<
                                                          List<
                                                            Map<String, dynamic>
                                                          >
                                                        >
                                                        roomdiff = [];
                                                        return Column(
                                                          children: [
                                                            Container(
                                                              // color: Colors.green,
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          20,
                                                                        ).r,
                                                                    child: SizedBox(
                                                                      height:
                                                                          Constant
                                                                              .height *
                                                                          0.1,
                                                                      width:
                                                                          Constant
                                                                              .width *
                                                                          0.25,
                                                                      child: FittedBox(
                                                                        child: Image.asset(
                                                                          "assets/hostels_detail/roomTypeImage.png",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Expanded(
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          padding: EdgeInsets.only(right: 25.h),
                                                                          // width:
                                                                          //     Constant
                                                                          //         .width *
                                                                          //     0.7,
                                                                          child: FittedBox(
                                                                            child: Text(
                                                                              "${roomTypeText(room.type ?? "")} Room Bedroom Apartment",
                                                                              maxLines: 2,
                                                                              style: TextStyle(
                                                                                fontSize: 16.sp.clamp(
                                                                                  0,
                                                                                  16,
                                                                                ),
                                                                                // letterSpacing: 0.2.w,
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5.h,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              Constant.height *
                                                                              0.03,
                                                                          child: FittedBox(
                                                                            child: SizedBox(
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                    "From ",
                                                                                    style: TextStyle(
                                                                                      fontSize: 12.sp.clamp(
                                                                                        0,
                                                                                        12,
                                                                                      ),
                                                                                      fontFamily: "Inter",
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    "¢${room.price}",
                                                                                    style: TextStyle(
                                                                                      fontSize: 18.sp.clamp(
                                                                                        0,
                                                                                        18,
                                                                                      ),
                                                                                      fontFamily: "Poppins",
                                                                                      fontWeight: FontWeight.w600,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    "/ ${room.billingCycle}",
                                                                                    style: TextStyle(
                                                                                      fontSize: 11.sp.clamp(
                                                                                        0,
                                                                                        11,
                                                                                      ),
                                                                                      fontFamily: "Poppins",
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5.h,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            SizedBox(
                                                                              width: Constant.width * 0.22,
                                                                              child: FittedBox(
                                                                                child: Text(
                                                                                  "Available Rooms:",
                                                                                  style: TextStyle(
                                                                                    fontSize: 12.sp.clamp(
                                                                                      0,
                                                                                      12,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 5.w,
                                                                            ),
                                                                            sort(
                                                                                  rooms,
                                                                                  capacity(
                                                                                    room.type ??
                                                                                        "",
                                                                                  ),
                                                                                ).isNotEmpty
                                                                                ? Builder(
                                                                                    builder:
                                                                                        (
                                                                                          context,
                                                                                        ) {
                                                                                          roomdiff = sort(
                                                                                            rooms,
                                                                                            capacity(
                                                                                              room.type ??
                                                                                                  "",
                                                                                            ),
                                                                                          );
                                                                                          return Row(
                                                                                            children: [
                                                                                              roomdiff[0].isNotEmpty
                                                                                                  ? Container(
                                                                                                      height:
                                                                                                          Constant.height *
                                                                                                          0.03,
                                                                                                      width:
                                                                                                          Constant.width *
                                                                                                          0.2,
                                                                                                      decoration: BoxDecoration(
                                                                                                        borderRadius: BorderRadius.circular(
                                                                                                          23.r,
                                                                                                        ),
                                                                                                        color: Colors.red,
                                                                                                      ),
                                                                                                      child: Align(
                                                                                                        child: SizedBox(
                                                                                                          height:
                                                                                                              Constant.height *
                                                                                                              0.015,
                                                                                                          child: FittedBox(
                                                                                                            child: Text(
                                                                                                              "${roomdiff[0].length} Empty Rooms",
                                                                                                              style: TextStyle(
                                                                                                                color: Colors.white,
                                                                                                                fontFamily: "Poppins",
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    )
                                                                                                  : Container(),
                                                                                              SizedBox(
                                                                                                width: 5,
                                                                                              ),
                                                                                              roomdiff[1].isNotEmpty
                                                                                                  ? Container(
                                                                                                      height:
                                                                                                          Constant.height *
                                                                                                          0.03,
                                                                                                      width:
                                                                                                          Constant.width *
                                                                                                          0.2,
                                                                                                      decoration: BoxDecoration(
                                                                                                        borderRadius: BorderRadius.circular(
                                                                                                          23.r,
                                                                                                        ),
                                                                                                        color: Color.fromRGBO(
                                                                                                          35,
                                                                                                          162,
                                                                                                          109,
                                                                                                          0.1,
                                                                                                        ),
                                                                                                      ),
                                                                                                      child: Align(
                                                                                                        child: SizedBox(
                                                                                                          height:
                                                                                                              Constant.height *
                                                                                                              0.015,
                                                                                                          child: FittedBox(
                                                                                                            child: Text(
                                                                                                              "${roomdiff[1].length} Bed Space",
                                                                                                              style: TextStyle(
                                                                                                                color: Color(
                                                                                                                  0xFF00EFD1,
                                                                                                                ),
                                                                                                                fontFamily: "Poppins",
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    )
                                                                                                  : Container(),
                                                                                            ],
                                                                                          );
                                                                                        },
                                                                                  )
                                                                                : Container(
                                                                                    decoration: BoxDecoration(
                                                                                      color: const Color.fromRGBO(
                                                                                        35,
                                                                                        162,
                                                                                        109,
                                                                                        1,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(
                                                                                        15.r,
                                                                                      ),
                                                                                    ),
                                                                                    width: 55.w,
                                                                                    height: 25.h,
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        "Sold out",
                                                                                        style: TextStyle(
                                                                                          fontSize: 10.sp.clamp(
                                                                                            0,
                                                                                            10,
                                                                                          ),
                                                                                          fontWeight: FontWeight.w500,
                                                                                          color: const Color(
                                                                                            0xFF00EFD1,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  // Image.asset("assets/hostels_detail/bed.jpeg"),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                      MediaQuery.sizeOf(
                                                                        context,
                                                                      ).width *
                                                                      0.4,
                                                                  child: Row(
                                                                    children: [
                                                                      Image.asset(
                                                                        "assets/hostels_detail/home.png",
                                                                        height:
                                                                            24.h,
                                                                        width:
                                                                            24.w,
                                                                      ),
                                                                      Container(
                                                                        margin: EdgeInsets.only(
                                                                          top: 5
                                                                              .h,
                                                                        ),
                                                                        child: Text(
                                                                          " Bedroom 1",
                                                                          style: TextStyle(
                                                                            fontFamily:
                                                                                "Work Sans",
                                                                            fontSize: 14.sp.clamp(
                                                                              0,
                                                                              14,
                                                                            ),
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: const Color(
                                                                              0xFF323232,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Image.asset(
                                                                      "assets/hostels_detail/bathtub.png",
                                                                      height:
                                                                          24.h,
                                                                      width:
                                                                          24.w,
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                        top:
                                                                            5.h,
                                                                      ),
                                                                      child: Text(
                                                                        " Bathroom 1",
                                                                        style: TextStyle(
                                                                          fontFamily:
                                                                              "Work Sans",
                                                                          fontSize: 14.sp.clamp(
                                                                            0,
                                                                            14,
                                                                          ),
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color(
                                                                            0xFF323232,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 20.h,
                                                            ),
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                      MediaQuery.sizeOf(
                                                                        context,
                                                                      ).width *
                                                                      0.4,
                                                                  child: Row(
                                                                    children: [
                                                                      Image.asset(
                                                                        "assets/hostels_detail/bed.png",
                                                                        height:
                                                                            24.h,
                                                                        width:
                                                                            24.w,
                                                                      ),
                                                                      Text(
                                                                        " 2 Beds",
                                                                        style: TextStyle(
                                                                          fontFamily:
                                                                              "Work Sans",
                                                                          color: const Color(
                                                                            0xFF323232,
                                                                          ),
                                                                          fontSize: 14.sp.clamp(
                                                                            0,
                                                                            14,
                                                                          ),
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Image.asset(
                                                                      "assets/hostels_detail/home.png",
                                                                      height:
                                                                          24.h,
                                                                      width:
                                                                          24.w,
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                        top:
                                                                            5.h,
                                                                      ),
                                                                      child: Text(
                                                                        " Private Bedroom",
                                                                        style: TextStyle(
                                                                          fontFamily:
                                                                              "Work Sans",
                                                                          fontSize: 14.sp.clamp(
                                                                            0,
                                                                            14,
                                                                          ),
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 20.h,
                                                            ),
                                                            Container(
                                                              // color: Colors.green,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    // color: Colors.blue,
                                                                    width:
                                                                        MediaQuery.sizeOf(
                                                                          context,
                                                                        ).width *
                                                                        0.35,
                                                                    child: Container(
                                                                      height:
                                                                          55.h,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              16.r,
                                                                            ),
                                                                        border: Border.all(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      child: Center(
                                                                        child: SizedBox(
                                                                          width:
                                                                              Constant.width *
                                                                              0.3,
                                                                          child: FittedBox(
                                                                            child: Text(
                                                                              "View more details",
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 14.sp,
                                                                                fontFamily: "Work Sans",
                                                                                color: Color(
                                                                                  0xFF323232,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  // SizedBox(width: 40.h),
                                                                  Container(
                                                                    width:
                                                                        Constant
                                                                            .width *
                                                                        0.48,
                                                                    // color:
                                                                    // Colors.yellow,
                                                                    child: Row(
                                                                      children: [
                                                                        SvgPicture.asset(
                                                                          'assets/user_interface_icons/Hostel_detail_screens/ic_add.svg',
                                                                          width:
                                                                              20,
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          "More",
                                                                          style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize:
                                                                                14.sp,
                                                                            fontFamily:
                                                                                "Work Sans",
                                                                            color: Color(
                                                                              0xFF323232,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 20.h,
                                                            ),
                                                            Divider(
                                                              color:
                                                                  const Color.fromRGBO(
                                                                    120,
                                                                    120,
                                                                    120,
                                                                    0.7,
                                                                  ),
                                                              height: .2.h,
                                                            ),
                                                            SizedBox(
                                                              height: 20.h,
                                                            ),
                                                            SizedBox(
                                                              width: Constant
                                                                  .width,
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    height:
                                                                        Constant
                                                                            .height *
                                                                        0.03,
                                                                    width:
                                                                        MediaQuery.sizeOf(
                                                                          context,
                                                                        ).width *
                                                                        0.4,
                                                                    child: FittedBox(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child: Text(
                                                                        "Academic Year",
                                                                        style: TextStyle(
                                                                          fontSize: 15.sp.clamp(
                                                                            0,
                                                                            15,
                                                                          ),
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: SizedBox(
                                                                      height:
                                                                          Constant
                                                                              .width *
                                                                          0.04,
                                                                      child: FittedBox(
                                                                        child: Text(
                                                                          "Move in: 08 Aug 2024",
                                                                          style: TextStyle(
                                                                            fontSize: 13.sp.clamp(
                                                                              0,
                                                                              13,
                                                                            ),
                                                                            color: const Color(
                                                                              0xFF323232,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 15.h,
                                                            ),
                                                            Container(
                                                              // color: Colors.pink,
                                                              width: Constant
                                                                  .width,
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    // color: Colors.orange,
                                                                    width:
                                                                        MediaQuery.sizeOf(
                                                                          context,
                                                                        ).width *
                                                                        0.4,
                                                                    child: Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            "Price Estimate",
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style: TextStyle(
                                                                              fontSize: 12.sp.clamp(
                                                                                0,
                                                                                12,
                                                                              ),
                                                                              letterSpacing: 0.2.w,
                                                                              color: const Color(
                                                                                0xFF787878,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          // SizedBox(
                                                                          //   height:
                                                                          //       10.h,
                                                                          // ),
                                                                          Container(
                                                                            // color: Colors.brown,
                                                                            height:
                                                                                Constant.height *
                                                                                0.03,
                                                                            width:
                                                                                Constant.width *
                                                                                0.43,
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(
                                                                                  height:
                                                                                      Constant.height *
                                                                                      0.028,
                                                                                  child: FittedBox(
                                                                                    child: Text(
                                                                                      "GH¢${room.price}/",
                                                                                      style: TextStyle(
                                                                                        fontSize: 18.sp.clamp(
                                                                                          0,
                                                                                          18,
                                                                                        ),
                                                                                        fontWeight: FontWeight.w500,
                                                                                        color: Color(
                                                                                          0xFF323232,
                                                                                        ),
                                                                                        fontFamily: "Poppins",
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  child: FittedBox(
                                                                                    child: Text(
                                                                                      "year",
                                                                                      style: TextStyle(
                                                                                        fontSize: 12.sp.clamp(
                                                                                          0,
                                                                                          12,
                                                                                        ),
                                                                                        color: const Color(
                                                                                          0xFF787878,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: SizedBox(
                                                                      // color: Colors.blue,
                                                                      width:
                                                                          MediaQuery.sizeOf(
                                                                            context,
                                                                          ).width *
                                                                          0.3,
                                                                      child: Center(
                                                                        child: Align(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child: SizedBox(
                                                                            width:
                                                                                110.w,
                                                                            height:
                                                                                Constant.height *
                                                                                0.05,
                                                                            child: ElevatedButton(
                                                                              onPressed: () {
                                                                                currentRoom = rooms;

                                                                                // roomdifference = roomdiff;
                                                                                numPeople = TextEditingController(
                                                                                  text: "1",
                                                                                );
                                                                                TextEditingController
                                                                                name = TextEditingController();
                                                                                // TextEditingController
                                                                                // phoneNum =
                                                                                //     TextEditingController();
                                                                                TextEditingController
                                                                                emailAddress = TextEditingController();
                                                                                // List<
                                                                                //   TextEditingController
                                                                                // >
                                                                                occupantNames = [
                                                                                  TextEditingController(),
                                                                                ];
                                                                                // List<
                                                                                //   TextEditingController
                                                                                // >
                                                                                occupantEmails = [
                                                                                  TextEditingController(),
                                                                                ];

                                                                                occupantPhones = [
                                                                                  TextEditingController(),
                                                                                ];

                                                                                if (user !=
                                                                                    null) {
                                                                                  Get.snackbar(
                                                                                    'Success',
                                                                                    'Task saved!',
                                                                                  );
                                                                                  showModalBottomSheet(
                                                                                    context: context,
                                                                                    isScrollControlled: true,
                                                                                    builder:
                                                                                        (
                                                                                          BuildContext context,
                                                                                        ) {
                                                                                          return StatefulBuilder(
                                                                                            key: key,
                                                                                            builder:
                                                                                                (
                                                                                                  BuildContext context,
                                                                                                  StateSetter setModalState,
                                                                                                ) {
                                                                                                  return Container(
                                                                                                    height:
                                                                                                        Constant.height *
                                                                                                        0.85,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: Colors.white,
                                                                                                      borderRadius: BorderRadius.only(
                                                                                                        topLeft: Radius.circular(
                                                                                                          20,
                                                                                                        ),
                                                                                                        topRight: Radius.circular(
                                                                                                          20,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    padding: EdgeInsets.only(
                                                                                                      bottom: MediaQuery.of(
                                                                                                        context,
                                                                                                      ).viewInsets.bottom,
                                                                                                    ),
                                                                                                    child: ClipRRect(
                                                                                                      borderRadius: BorderRadius.only(
                                                                                                        topLeft: Radius.circular(
                                                                                                          20,
                                                                                                        ),
                                                                                                        topRight: Radius.circular(
                                                                                                          20,
                                                                                                        ),
                                                                                                      ),
                                                                                                      child: SingleChildScrollView(
                                                                                                        // controller: controller,
                                                                                                        child: book(
                                                                                                          setModalState,
                                                                                                          numPeople,
                                                                                                          name,
                                                                                                          // phoneNum,
                                                                                                          emailAddress,
                                                                                                          occupantEmails,
                                                                                                          occupantNames,
                                                                                                          occupantPhones,
                                                                                                          () {
                                                                                                            roomtype =
                                                                                                                room.type ??
                                                                                                                "";
                                                                                                            if (room.type !=
                                                                                                                null) {
                                                                                                              if (room.type ==
                                                                                                                  "1in1") {
                                                                                                                return 1;
                                                                                                              }
                                                                                                              if (room.type ==
                                                                                                                  "2in1") {
                                                                                                                return 2;
                                                                                                              }
                                                                                                              if (room.type ==
                                                                                                                  "3in1") {
                                                                                                                return 3;
                                                                                                              }
                                                                                                              if (room.type ==
                                                                                                                  "4in1") {
                                                                                                                return 4;
                                                                                                              }
                                                                                                              if (room.type ==
                                                                                                                  "5in1") {
                                                                                                                return 5;
                                                                                                              }
                                                                                                              if (room.type ==
                                                                                                                  "6in1") {
                                                                                                                return 6;
                                                                                                              }
                                                                                                              if (room.type ==
                                                                                                                  "7in1") {
                                                                                                                return 7;
                                                                                                              }
                                                                                                              if (room.type ==
                                                                                                                  "8in1") {
                                                                                                                return 8;
                                                                                                              }
                                                                                                              if (room.type ==
                                                                                                                  "9in1") {
                                                                                                                return 9;
                                                                                                              }
                                                                                                              if (room.type ==
                                                                                                                  "10in1") {
                                                                                                                return 10;
                                                                                                              }
                                                                                                            }
                                                                                                            return 0;
                                                                                                          },
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  );
                                                                                                },
                                                                                          );
                                                                                        },
                                                                                  ).whenComplete(
                                                                                    () {
                                                                                      // numPeople.dispose();

                                                                                      setState(
                                                                                        () {
                                                                                          isChecked = false;
                                                                                        },
                                                                                      );

                                                                                      // for (var c in occupantNames) {
                                                                                      //   c.dispose();
                                                                                      // }
                                                                                      // for (var c in occupantEmails) {
                                                                                      //   c.dispose();
                                                                                      // }
                                                                                    },
                                                                                  );
                                                                                  // roomId = roomIds[0];
                                                                                } else {
                                                                                  Get.snackbar(
                                                                                    'Error',
                                                                                    'Please sign in to continue.',
                                                                                  );
                                                                                }
                                                                              },
                                                                              style: ElevatedButton.styleFrom(
                                                                                elevation: 0,
                                                                                shape: ContinuousRectangleBorder(
                                                                                  side: BorderSide.none,
                                                                                  borderRadius: BorderRadius.circular(
                                                                                    30.r,
                                                                                  ),
                                                                                ),
                                                                                backgroundColor: const Color.fromARGB(
                                                                                  255,
                                                                                  33,
                                                                                  243,
                                                                                  201,
                                                                                ),
                                                                              ),
                                                                              child: SizedBox(
                                                                                height:
                                                                                    Constant.height *
                                                                                    0.025,
                                                                                child: FittedBox(
                                                                                  child: Text(
                                                                                    "Book now",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontSize: 14.sp.clamp(
                                                                                        0,
                                                                                        14,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  // SizedBox(height: 10.h),
                                                ],
                                              );
                                            }),
                                          ),
                                        ),
                                  // SizedBox(height: 10.h),
                                  Container(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.all(20.r),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            key: _sectionKeys['Policies'],
                                            child: SizedBox(
                                              height: Constant.height * 0.035,
                                              child: FittedBox(
                                                child: Text(
                                                  "Cancellation Policies",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20.sp.clamp(
                                                      0,
                                                      20,
                                                    ),
                                                    letterSpacing: 0.2.w,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: Constant.height * 0.03,
                                                width: Constant.width * 0.7,
                                                child: FittedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Cooling off period",
                                                    style: TextStyle(
                                                      fontSize: 15.sp.clamp(
                                                        0,
                                                        15,
                                                      ),
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xFF323232),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {},
                                                child: SizedBox(
                                                  height:
                                                      Constant.height * 0.03,
                                                  // width: Constant.width,
                                                  child: FittedBox(
                                                    child: Text(
                                                      "View",
                                                      style: TextStyle(
                                                        fontSize: 15.sp.clamp(
                                                          0,
                                                          15,
                                                        ),
                                                        color: const Color(
                                                          0xFF00EFD1,
                                                        ),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  Container(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.all(20.r),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: SizedBox(
                                              height: Constant.height * 0.035,
                                              child: FittedBox(
                                                child: Text(
                                                  "Payment Details",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20.sp.clamp(
                                                      0,
                                                      20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: Constant.height * 0.03,
                                                width: Constant.width * 0.7,
                                                child: FittedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Booking deposit",
                                                    style: TextStyle(
                                                      fontSize: 15.sp.clamp(
                                                        0,
                                                        15,
                                                      ),
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xFF323232),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {},
                                                child: SizedBox(
                                                  height:
                                                      Constant.height * 0.03,
                                                  // width: Constant.width,
                                                  child: FittedBox(
                                                    child: Text(
                                                      "View",
                                                      style: TextStyle(
                                                        fontSize: 15.sp.clamp(
                                                          0,
                                                          15,
                                                        ),
                                                        color: const Color(
                                                          0xFF00EFD1,
                                                        ),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.h),
                                          Divider(height: .2.h),
                                          SizedBox(height: 20.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: Constant.height * 0.03,
                                                width: Constant.width * 0.7,
                                                child: FittedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Payment installment plan",
                                                    style: TextStyle(
                                                      fontSize: 15.sp.clamp(
                                                        0,
                                                        15,
                                                      ),
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xFF323232),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {},
                                                child: SizedBox(
                                                  height:
                                                      Constant.height * 0.03,
                                                  // width: Constant.width,
                                                  child: FittedBox(
                                                    child: Text(
                                                      "View",
                                                      style: TextStyle(
                                                        fontSize: 15.sp.clamp(
                                                          0,
                                                          15,
                                                        ),
                                                        color: const Color(
                                                          0xFF00EFD1,
                                                        ),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.h),
                                          Divider(height: .2.h),
                                          SizedBox(height: 20.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: Constant.height * 0.03,
                                                width: Constant.width * 0.7,
                                                child: FittedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Mode of payment",
                                                    style: TextStyle(
                                                      fontSize: 15.sp.clamp(
                                                        0,
                                                        15,
                                                      ),
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xFF323232),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {},
                                                child: SizedBox(
                                                  height:
                                                      Constant.height * 0.03,
                                                  // width: Constant.width,
                                                  child: FittedBox(
                                                    child: Text(
                                                      "View",
                                                      style: TextStyle(
                                                        fontSize: 15.sp.clamp(
                                                          0,
                                                          15,
                                                        ),
                                                        color: const Color(
                                                          0xFF00EFD1,
                                                        ),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.h),
                                          Divider(height: .2.h),
                                          SizedBox(height: 20.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: Constant.height * 0.03,
                                                width: Constant.width * 0.7,
                                                child: FittedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Guarantor requirement",
                                                    style: TextStyle(
                                                      fontSize: 15.sp.clamp(
                                                        0,
                                                        15,
                                                      ),
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xFF323232),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {},
                                                child: SizedBox(
                                                  height:
                                                      Constant.height * 0.03,
                                                  // width: Constant.width,
                                                  child: FittedBox(
                                                    child: Text(
                                                      "View",
                                                      style: TextStyle(
                                                        fontSize: 15.sp.clamp(
                                                          0,
                                                          15,
                                                        ),
                                                        color: const Color(
                                                          0xFF00EFD1,
                                                        ),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  Container(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.all(20.r),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: SizedBox(
                                              height: Constant.height * 0.035,
                                              child: FittedBox(
                                                child: Text(
                                                  "Location",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20.sp.clamp(
                                                      0,
                                                      20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20.h),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10.0.w,
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.to(
                                                  () => HostelsDetailMap(
                                                    hostel: widget.hostel,
                                                  ),
                                                  transition: Transition.fadeIn,
                                                  duration: const Duration(
                                                    milliseconds: 800,
                                                  ),
                                                  curve: Curves.easeIn,
                                                );
                                              },
                                              child: SizedBox(
                                                width: MediaQuery.sizeOf(
                                                  context,
                                                ).width.w,
                                                height: 400.h,
                                                // color: Colors.red,
                                                child: Image.asset(
                                                  "assets/hostels_detail/citymap.jpg",
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  Container(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.all(20.r),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            key: _sectionKeys["Faqs"],
                                            child: SizedBox(
                                              height: Constant.height * 0.035,
                                              child: FittedBox(
                                                child: Text(
                                                  "Frequently Asked Questions (FAQs)",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20.sp.clamp(
                                                      0,
                                                      20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: Constant.height * 0.03,
                                                width: Constant.width * 0.7,
                                                child: FittedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Can I bring a TV?",
                                                    style: TextStyle(
                                                      fontSize: 15.sp.clamp(
                                                        0,
                                                        15,
                                                      ),
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xFF323232),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {},
                                                child: SizedBox(
                                                  height:
                                                      Constant.height * 0.03,
                                                  // width: Constant.width,
                                                  child: FittedBox(
                                                    child: Text(
                                                      "View",
                                                      style: TextStyle(
                                                        fontSize: 15.sp.clamp(
                                                          0,
                                                          15,
                                                        ),
                                                        color: const Color(
                                                          0xFF00EFD1,
                                                        ),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.h),
                                          Divider(height: .2.h),
                                          SizedBox(height: 20.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: Constant.height * 0.03,
                                                width: Constant.width * 0.7,
                                                child: FittedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Can I make a group booking?",
                                                    style: TextStyle(
                                                      fontSize: 15.sp.clamp(
                                                        0,
                                                        15,
                                                      ),
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xFF323232),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {},
                                                child: SizedBox(
                                                  height:
                                                      Constant.height * 0.03,
                                                  // width: Constant.width,
                                                  child: FittedBox(
                                                    child: Text(
                                                      "View",
                                                      style: TextStyle(
                                                        fontSize: 15.sp.clamp(
                                                          0,
                                                          15,
                                                        ),
                                                        color: const Color(
                                                          0xFF00EFD1,
                                                        ),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.h),
                                          Divider(height: .2.h),
                                          SizedBox(height: 20.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: Constant.height * 0.03,
                                                width: Constant.width * 0.7,
                                                child: FittedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Can I have friends stay over?",
                                                    style: TextStyle(
                                                      fontSize: 15.sp.clamp(
                                                        0,
                                                        15,
                                                      ),
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xFF323232),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {},
                                                child: SizedBox(
                                                  height:
                                                      Constant.height * 0.03,
                                                  // width: Constant.width,
                                                  child: FittedBox(
                                                    child: Text(
                                                      "View",
                                                      style: TextStyle(
                                                        fontSize: 15.sp.clamp(
                                                          0,
                                                          15,
                                                        ),
                                                        color: const Color(
                                                          0xFF00EFD1,
                                                        ),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.h),
                                          Divider(height: .2.h),
                                          SizedBox(height: 20.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: Constant.height * 0.03,
                                                width: Constant.width * 0.7,
                                                child: FittedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Do you have a cleaner",
                                                    style: TextStyle(
                                                      fontSize: 15.sp.clamp(
                                                        0,
                                                        15,
                                                      ),
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xFF323232),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {},
                                                child: SizedBox(
                                                  height:
                                                      Constant.height * 0.03,
                                                  // width: Constant.width,
                                                  child: FittedBox(
                                                    child: Text(
                                                      "View",
                                                      style: TextStyle(
                                                        fontSize: 15.sp.clamp(
                                                          0,
                                                          15,
                                                        ),
                                                        color: const Color(
                                                          0xFF00EFD1,
                                                        ),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.h),
                                          Divider(height: .2.h),
                                          SizedBox(height: 20.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: Constant.height * 0.03,
                                                width: Constant.width * 0.7,
                                                child: FittedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Is beddings & linen provided",
                                                    style: TextStyle(
                                                      fontSize: 15.sp.clamp(
                                                        0,
                                                        15,
                                                      ),
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xFF323232),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {},
                                                child: SizedBox(
                                                  height:
                                                      Constant.height * 0.03,
                                                  // width: Constant.width,
                                                  child: FittedBox(
                                                    child: Text(
                                                      "View",
                                                      style: TextStyle(
                                                        fontSize: 15.sp.clamp(
                                                          0,
                                                          15,
                                                        ),
                                                        color: const Color(
                                                          0xFF00EFD1,
                                                        ),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.h),
                                          Divider(height: .2.h),
                                          SizedBox(height: 20.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: Constant.height * 0.03,
                                                width: Constant.width * 0.7,
                                                child: FittedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "What our rents covered",
                                                    style: TextStyle(
                                                      fontSize: 15.sp.clamp(
                                                        0,
                                                        15,
                                                      ),
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xFF323232),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {},
                                                child: SizedBox(
                                                  height:
                                                      Constant.height * 0.03,
                                                  // width: Constant.width,
                                                  child: FittedBox(
                                                    child: Text(
                                                      "View",
                                                      style: TextStyle(
                                                        fontSize: 15.sp.clamp(
                                                          0,
                                                          15,
                                                        ),
                                                        color: const Color(
                                                          0xFF00EFD1,
                                                        ),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: "Poppins",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.h),
                                          Divider(height: .2.h),
                                          SizedBox(height: 20.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: Constant.height * 0.03,
                                                width: Constant.width * 0.7,
                                                child: FittedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Do i need a guarantor?",
                                                    style: TextStyle(
                                                      fontSize: 15.sp.clamp(
                                                        0,
                                                        15,
                                                      ),
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {},
                                                child: SizedBox(
                                                  height:
                                                      Constant.height * 0.03,
                                                  // width: Constant.width,
                                                  child: FittedBox(
                                                    child: Text(
                                                      "View",
                                                      style: TextStyle(
                                                        fontSize: 15.sp.clamp(
                                                          0,
                                                          15,
                                                        ),
                                                        color: const Color(
                                                          0xFF00EFD1,
                                                        ),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: "Poppins",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 150.h),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromRGBO(158, 158, 158, 0.5),
                            spreadRadius: 3.r,
                            blurRadius: 12.r,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          bottom: 15,
                          left: 20,
                          right: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 150.w,
                              height: Constant.height * 0.05,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Get.to(
                                  //   () => Enquire(hostel: widget.hostel),
                                  //   transition: Transition.fadeIn,
                                  //   duration: const Duration(milliseconds: 800),
                                  //   curve: Curves.easeIn,
                                  // );

                                  _scrollToSection("Room Type");
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Color(0xFF00EFD1)),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  backgroundColor: const Color.fromRGBO(
                                    0,
                                    239,
                                    209,
                                    0.1,
                                  ),
                                ),
                                child: SizedBox(
                                  height: Constant.height * 0.025,
                                  child: FittedBox(
                                    child: Text(
                                      "View Rooms",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF00EFD1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp.clamp(0, 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 150.w,
                              height: Constant.height * 0.05,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(
                                    () => Enquire(hostel: widget.hostel),
                                    transition: Transition.fadeIn,
                                    duration: const Duration(milliseconds: 800),
                                    curve: Curves.easeIn,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  backgroundColor: const Color(0xFF00EFD1),
                                ),
                                child: SizedBox(
                                  height: Constant.height * 0.025,
                                  child: FittedBox(
                                    child: Text(
                                      "Enquire now",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp.clamp(0, 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget customTextField({
  required TextEditingController controller,
  required String labelText,
}) {
  return TextField(
    //   onChanged: (){},
    //   focusNode:,
    controller: controller,
    obscureText: false,
    enableSuggestions: true,
    autocorrect: false,
    cursorColor: Colors.white,
    style: const TextStyle(color: Colors.grey),
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      filled: true,
      fillColor: Colors.white,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          width: 1,
          style: BorderStyle.none,
          color: const Color.fromRGBO(158, 158, 158, 0.3),
        ),
      ),
    ),
    keyboardType: TextInputType.visiblePassword,
  );
}

Widget genderSelector(StateSetter setModalState, String gender) {
  bool isGender = selectedGender == gender;
  return GestureDetector(
    onTap: () {
      setModalState(() {
        selectedGender = gender;
        //debugPrint(selectedGender);
      });
    },
    child: Container(
      height: 30.h,
      width: 30.w,
      decoration: BoxDecoration(
        color: isGender ? Color(0xFF00EFD1) : Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 4),
            color: const Color.fromRGBO(0, 0, 0, 0.5),
          ),
        ],
      ),
      child: Align(
        child: Text(
          gender,
          style: TextStyle(color: isGender ? Colors.white : Color(0xFF00EFD1)),
        ),
      ),
    ),
  );
}
