import 'dart:async';
import 'dart:developer';
import 'package:fgi_y2j/features/shopping_cart/controller/cartController.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as Geocoding;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const LatLng initialTarget = LatLng(5.5911921, -0.3198162);
  final Completer<GoogleMapController> mapController = Completer();
  String? _lightMapStyleJson;

  final Set<Marker> markers = <Marker>{}..add(
      const Marker(
        position: initialTarget,
        markerId: MarkerId('selected-location'),
      ),
    );

  void onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
    setMapStyle(mapController.future);
    moveToCurrentUserLocation();
  }

  void moveToCurrentUserLocation() {
    var location = Location();
    location.getLocation().then((locationData) {
      var target = LatLng(locationData.latitude!, locationData.longitude!);
      moveToLocation(target);
    });
  }

  Future<void> setMapStyle(mapController, {isDarkMode}) async {
    mapController = mapController is Future<GoogleMapController>
        ? await mapController
        : mapController;
    await mapController?.setMapStyle(_lightMapStyleJson);
  }

  /// match the location.
  void moveToLocation(LatLng latLng) {
    mapController.future.then((controller) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: latLng,
            zoom: 15.0,
          ),
        ),
      );
    });
  }


  @override
  void initState() {
    super.initState();
  }
  final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: initialTarget,
          zoom: 15,
        ),
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        onMapCreated: onMapCreated,
        onTap: (latLng) {},
        markers: markers,
      ),
    );
  }
}
