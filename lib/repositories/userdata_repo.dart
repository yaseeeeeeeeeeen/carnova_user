import 'package:carnova_user/data/network/api_services.dart';
import 'package:http/http.dart' as http;

class UserDataRepo {
  Future<http.Response> userData(String token) async {
    final response = await ApiServices.instance.getUserData(token);
    return response;
  }
}
