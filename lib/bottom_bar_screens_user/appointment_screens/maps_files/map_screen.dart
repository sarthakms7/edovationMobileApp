import 'dart:ffi';

import 'package:edovation/controllers/map_screen_controller.dart';
import 'package:edovation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../models/direction_model.dart';
import 'direction_repo.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var controller;
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.431297),
    zoom: 11.5,
  );

  late GoogleMapController _googleMapController;

  @override
  void initState() {
    controller = Get.put(MapScreenController());
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Location'),
        backgroundColor: "02075D".toColor(),
        actions: [
          if (controller.origin.value != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: controller.origin.value.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.green,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('ORIGIN'),
            ),
          if (controller.destination.value != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: controller.destination.value.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.blue,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('DEST'),
            )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: {
              if (controller.origin.value != null) controller.origin.value,
              if (controller.destination.value != null)
                controller.destination.value
            },
            // polylines: {
            //   if (controller.info.value != null)
            //     Polyline(
            //       polylineId: const PolylineId('overview_polyline'),
            //       color: Colors.red,
            //       width: 5,
            //       points: controller.info.value.polylinePoints!
            //           .map((e) => LatLng(e.latitude, e.longitude))
            //           .toList(),
            //     ),
            // },
            // onLongPress: () => _addMarker(),
          ),
          if (controller.info.value != null)
            Positioned(
              top: 20.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '${controller.info.value.totalDistance}, ${controller.info.value.totalDuration}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
          controller.info.value != null
              ? CameraUpdate.newLatLngBounds(
                  controller.info.value.bounds ??
                      LatLngBounds(
                          southwest: LatLng(23.23, 23.45),
                          northeast: LatLng(23.23, 23.45)),
                  100.0)
              : CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(
          Icons.center_focus_strong,
          color: Colors.white,
        ),
      ),
    );
  }

  void _addMarker(LatLng pos) async {
    if (controller.origin.value == null ||
        (controller.origin.value != null &&
            controller.destination.value != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      setState(() {
        controller.origin.value = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        // // Reset destination
        // controller.destination.value = null;

        // // Reset info
        // controller.info.value = null;
      });
    } else {
      // Origin is already set
      // Set destination
      setState(() {
        controller.destination.value = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });

      // Get directions
      final directions = await DirectionsRepository().getDirections(
          origin: controller.origin.value.position, destination: pos);
      setState(() => controller.info.value = directions!);
    }
  }
}
