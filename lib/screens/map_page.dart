import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:on_campus/firebase/consts.dart';
// import 'package:get/get.dart';


class MapPage extends StatefulWidget {
  final List<Hostels> hostels;
  const MapPage({super.key, required this.hostels});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();


  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 13);
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Set<Marker> markers(List<Hostels> hostels) {
    final Set<Marker> markers = {};

    for (int i = 0; i < hostels.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId(hostels[i].name),
          icon: BitmapDescriptor.defaultMarker,

          infoWindow: InfoWindow(title: hostels[i].name),
          position: LatLng(
            double.parse(hostels[i].latitude!),
            double.parse(hostels[i].longitude!),
          ),
        ),
      );
    }
    return markers;
  }

  LatLng initialPose = LatLng(6.73968, -1.56516);
  LatLng? currentPosition;

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

    location.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          currentPosition = LatLng(
            currentLocation.latitude!,
            currentLocation.longitude!,
          );
          
          //khalil you can turn this on if you want the camera or map to follow the currentlocation when it moves
          // _cameraToPosition(currentPosition!);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 20),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text("Map", style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: currentPosition == null || widget.hostels == []
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: ((GoogleMapController controller) =>
                  _mapController.complete(controller)),
              initialCameraPosition: CameraPosition(
                target: currentPosition!,
                zoom: 13,
              ),
              markers: {
                ...markers(widget.hostels),
                Marker(
                  markerId: MarkerId("CurrentLocation"),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue,
                  ),
                  position: currentPosition!,
                  infoWindow: InfoWindow(title: "My Location"),
                ),
              },
            ),
    );
  }
}
