import 'dart:convert';

import 'package:carnova_user/resources/api_urls/api_urls.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  ApiServices._();
  static final ApiServices _instance = ApiServices._();
  static ApiServices get instance => _instance;

  final headers = {'Content-Type': 'application/json'};
//Login Services-------------------------------------------------------------------
  Future<http.Response> userLogin(Map<String, String> emailandPass) async {
    final url = Uri.parse(ApiUrls.loginUrl);
    final body = jsonEncode(emailandPass);
    final response = await http.post(url, body: body, headers: headers);
    return response;
  }

  Future<http.Response> userSignup(Map<String, dynamic> userdata) async {
    final url = Uri.parse(ApiUrls.signupUrl);
    final body = jsonEncode(userdata);
    final response = await http.post(url, body: body, headers: headers);
    return response;
  }

  Future<http.Response> userOtp(Map<String, int?> otp) async {
    final url = Uri.parse(ApiUrls.otpverificationUrl);
    final body = jsonEncode(otp);
    final response = await http.post(url, body: body, headers: headers);
    return response;
  }

  Future<http.Response> getUserData(String token) async {
    final url = Uri.parse(ApiUrls.userdata);
    final header = {
      'Authorization': 'Bearer $token',
      'Cookie': 'jwt=$token'
    };
    final response = await http.get(url, headers: header);
    return response;
  }
}
