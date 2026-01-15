import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:on_campus/firebase/consts.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';


class HostelsDetailMap extends StatefulWidget {
  final Hostels hostel;
  const HostelsDetailMap({super.key, required this.hostel});

  @override
  State<HostelsDetailMap> createState() => _HostelsDetailMapState();
}

class _HostelsDetailMapState extends State<HostelsDetailMap> {
  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 13);
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  //Map location steeze..
  LatLng? initialPose;
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

    location.onLocationChanged.listen((LocationData currentLocation) async {
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
      final coords = await getPolylinePoints();
      generatePolyLineFromPoints(coords);

      setState(() {});
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
    setState(() {
      polylines[id] = polyline;
    });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints(apiKey: GOOGLE_MAPS_API_KEY);
    RoutesApiRequest request = RoutesApiRequest(
      origin: PointLatLng(
        currentPosition!.latitude,
        currentPosition!.longitude,
      ),
      destination: PointLatLng(initialPose!.latitude, initialPose!.longitude),
      travelMode: TravelMode.driving,
      routingPreference: RoutingPreference.trafficAware,
    );

    // Get route using Routes API
    RoutesApiResponse response = await polylinePoints
        .getRouteBetweenCoordinatesV2(request: request);

    if (response.routes.isNotEmpty) {
      print('Duration: ${response.routes.first.durationMinutes} minutes');
      print('Distance: ${response.routes.first.distanceKm} km');

      // Get polyline points
      List<PointLatLng> points = response.routes.first.polylinePoints ?? [];
      points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      Get.snackbar("Error", "${response.errorMessage}");
      print(response.errorMessage);
    }
    return polylineCoordinates;
  }

  @override
  void initState() {
    super.initState();

    final lat = double.tryParse(widget.hostel.latitude ?? '');
    final lng = double.tryParse(widget.hostel.longitude ?? '');

    if (lat != null && lng != null) {
      initialPose = LatLng(lat, lng);
    } else {
      initialPose = const LatLng(6.73968, -1.56516);
      debugPrint('Invalid hostel coordinates');
    }
    getLocation().then(
      (_) => {
        getPolylinePoints().then(
          (coordinates) => {generatePolyLineFromPoints(coordinates)},
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 20),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          widget.hostel.name,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: ((GoogleMapController controller) =>
                  _mapController.complete(controller)),
              initialCameraPosition: CameraPosition(
                target: currentPosition!,
                zoom: 13,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("CurrentLocation"),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue,
                  ),
                  position: currentPosition!,
                  infoWindow: InfoWindow(title: "My Location"),
                ),
                Marker(
                  markerId: MarkerId(widget.hostel.name),
                  icon: BitmapDescriptor.defaultMarker,
                  position: initialPose!,
                  infoWindow: InfoWindow(title: widget.hostel.name),
                ),
              },
              polylines: Set<Polyline>.of(polylines.values),
            ),
    );
  }
}
