import 'package:carnova_user/data/network/api_services.dart';
import 'package:http/http.dart' as http;

class UserSignupRepo {
 Future<http.Response> userSignup(Map<String, Object> signupdata) async {
    final response = await ApiServices.instance.userSignup(signupdata);
    return response;
  }
}