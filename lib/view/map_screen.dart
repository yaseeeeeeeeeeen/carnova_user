import 'package:carnova_user/utils/appbar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  Position postion;
  String locationName;
  MapScreen({super.key, required this.locationName, required this.postion});
  late GoogleMapController mapController;
  final locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarText("LOCATION", context, () {
        Navigator.of(context).pop();
      }),
      body: SafeArea(
          child: Stack(
        children: [
          GoogleMap(
            compassEnabled: false,
            buildingsEnabled: true,
            mapToolbarEnabled: false,
            mapType: MapType.hybrid,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(postion.latitude, postion.longitude),
              zoom: 16.0,
            ),
          ),
        ],
      )),
    );
  }
}
