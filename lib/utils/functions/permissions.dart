import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';


class Permissions {
  bool _serviceEnabled = false;
  late LocationPermission _locationPermission;

  Future<void> locationPermissionChecking(BuildContext context) async {
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
   
      // ScaffoldMessenger.of(context).showSnackBar(customSnackbar(
      //   context,
      //   false,
      //   "Location Permission Denied...! Open settings and change this",
      // ));
      return;
    }

    _locationPermission = await Geolocator.checkPermission();
    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
      if (_locationPermission == LocationPermission.denied) {
        return;
      }
    }
  }

  Future<bool> phoneCallPermissionChecking(BuildContext context) async {
    PermissionStatus status = await Permission.phone.status;
    if (status.isDenied) {
      // Request phone call permission
      status = await Permission.phone.request();
      if (status.isDenied) {
        // ScaffoldMessenger.of(context).showSnackBar(customSnackbar(
        //   context,
        //   false,
        //   "Phone Call Permission Denied...! Open settings and change this",
        // ));
        return false;
      }
    }
    return true; // Permission is granted
  }

  Future<bool> galleryPermissionChecking(BuildContext context) async {
    PermissionStatus status = await Permission.storage.status;
    if (status.isDenied) {
      // Request storage/gallery permission
      status = await Permission.storage.request();
      if (status.isDenied) {
        // ScaffoldMessenger.of(context).showSnackBar(customSnackbar(
        //   context,
        //   false,
        //   "Gallery Permission Denied...! Open settings and change this",
        // ));
        return false;
      }
    }
    return true; // Permission is granted
  }

  Future<bool> filesPermissionChecking(BuildContext context) async {
    PermissionStatus status = await Permission.storage.status;
    if (status.isDenied) {
      // Request storage/files permission
      status = await Permission.storage.request();
      if (status.isDenied) {
        // ScaffoldMessenger.of(context).showSnackBar(customSnackbar(
        //   context,
        //   false,
        //   "Files Permission Denied...! Open settings and change this",
        // ));
        return false;
      }
    }
    return true; // Permission is granted
  }
}
