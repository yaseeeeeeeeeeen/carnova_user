import 'package:carnova_user/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Permissions {
  bool _serviceEnabled = false;
  late LocationPermission _permission;
  locationPermissionCheking(context) async {
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(customSnackbar(context, false,
          "Location Permission Denied...! Open settings and change this"));
      return null;
    }
    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied) {
        return null;
      }
    }
  }

  phoneCallRedirectingPermission() async {}
}
