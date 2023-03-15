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
    markerId: MarkerId('origin'),
  ).obs;
  Rx<Directions> info = Directions().obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    origin.value = Marker(
      markerId: const MarkerId('origin'),
      infoWindow: const InfoWindow(title: 'Origin'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: LatLng(37.773972, -122.431297),
    );
    destination.value = Marker(
      markerId: const MarkerId('origin'),
      infoWindow: const InfoWindow(title: 'Origin'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: LatLng(45.773972, -122.431297),
    );
    final directions = await DirectionsRepository().getDirections(
        origin: origin.value.position,
        destination: LatLng(37.773972, -122.431297));
    info.value = directions!;
    super.onInit();
  }
}
