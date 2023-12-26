import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._();
  static final _instance = SharedPref._();
  static SharedPref get instance => _instance;

  static const String token = 'token';
  static const String location = 'location';

  late SharedPreferences sharedPref;

  initStorage() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  storeToken(hostToken) async {
    await sharedPref.setString(token, hostToken);
  }

  removeToken() async {
    await sharedPref.remove(token);
  }

  storeLocation(String value) async {
    await sharedPref.setString(location, value);
  }

  String? getLocation() {
    return sharedPref.getString(location);
  }

  String? getToke() {
    return sharedPref.getString(token);
  }
}