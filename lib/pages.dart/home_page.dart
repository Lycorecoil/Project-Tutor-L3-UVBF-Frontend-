import 'dart:async';
import 'package:driver/global.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> googleMapCompleterController =
      Completer<GoogleMapController>();
  GoogleMapController? controllerGoogleMap;
  Position? currentPositionOfUser;

  getCurrentLocation() async {
    Position userPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPositionOfUser = userPosition;
    LatLng userLatLng = LatLng(
        currentPositionOfUser!.latitude, currentPositionOfUser!.longitude);
    CameraPosition positionCamera =
        CameraPosition(target: userLatLng, zoom: 19);
    controllerGoogleMap!
        .animateCamera(CameraUpdate.newCameraPosition(positionCamera));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        padding: const EdgeInsets.only(top: 26, bottom: 0),
        mapType: MapType.normal,
        myLocationEnabled: true,
        initialCameraPosition: KGooglePlex,
        onMapCreated: (GoogleMapController mapController) {
          controllerGoogleMap = mapController;
          googleMapCompleterController.complete(controllerGoogleMap);
          getCurrentLocation();
        },
      ),
    );
  }
}
