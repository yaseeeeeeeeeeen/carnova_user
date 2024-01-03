import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationPickerFunction {
  Position? _currentLocation;
  //late String _currentAddress = '';
  List<String> Locationnames = [];
  bool _serviceEnabled = false;
  late LocationPermission _permission;
  Future<Position?> getCurrentLocation() async {
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      // Handle if location service is not enabled
      return null;
    }

    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied) {
        return null;
      }
    }

    _currentLocation = await Geolocator.getCurrentPosition();
    if (_currentLocation != null) {
      return _currentLocation;
    }
  }

  Future<String?> getAddress(Position postion) async {
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(postion.latitude, postion.longitude);
    Placemark place = placeMarks[0];
    String address =
        "${place.locality}, ${place.administrativeArea}, ${place.country}";
    //   _currentAddress = address;
    return address;
  }
}
