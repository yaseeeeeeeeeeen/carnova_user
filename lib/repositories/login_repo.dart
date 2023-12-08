import 'package:carnova_user/data/network/api_services.dart';
import 'package:http/http.dart' as http;

class UserLoginRepo {
  Future<http.Response> userLogin(Map<String, String> mailAndpass) async {
    final response = await ApiServices.instance.userLogin(mailAndpass);
    return response;
  }
}
