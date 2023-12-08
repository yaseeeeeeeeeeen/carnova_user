import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  SharedPreference._();
  static final _instance = SharedPreference._();
  static SharedPreference get instance => _instance;

  static const String email = 'email';
  static const String password = 'password';
  static const String token = 'token';

  late SharedPreferences sharedPref;

  initStorage() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  storeToken(userToken) async {
    await sharedPref.setString(token, userToken);
  }

  removeToken() async {
    await sharedPref.remove(token);
  }

  String? getToken() {
   return sharedPref.getString(token);
  }
}
