import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../bottom_bar_screens_user/appointment_screens/maps_files/direction_repo.dart';
import '../models/direction_model.dart';
import 'package:flutter/material.dart';

class MapScreenController extends GetxController {
  Rx<Marker> origin = const Marker(
    markerId: MarkerId('origin'),
  ).obs;
  Rx<Marker> destination = const Marker(
    markerId: MarkerId('destination'),
  ).obs;
  Rx<Directions> info = Directions().obs;

  void initializeMap(double lat, double lng) async {
    origin.value = Marker(
      markerId: const MarkerId('origin'),
      infoWindow: const InfoWindow(title: 'Destination'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: LatLng(25.455020282300993, 81.83196859924433),
    );
    destination.value = Marker(
      markerId: const MarkerId('destination'),
      infoWindow: const InfoWindow(title: 'Destination'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: LatLng(lat, lng),
    );
    final directions = await DirectionsRepository().getDirections(
        origin: LatLng(25.455020282300993, 81.83196859924433),
        destination: LatLng(25.455020282300993, 81.83196859924433));
    info.value = directions!;
  }

  @override
  void onInit() async {
    // TODO: implement onInit

    super.onInit();
  }
}
