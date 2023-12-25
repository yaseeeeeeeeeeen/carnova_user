import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: true,
            compassEnabled: false,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: const CameraPosition(
              target:
                  LatLng(11.1526, 75.8924), 
              zoom: 12.0,
            ),
          ),
        ],
      )),
    );
  }
}
