import 'dart:convert';

import 'package:carnova_user/resources/api_urls/api_urls.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  ApiServices._();
  static final ApiServices _instance = ApiServices._();
  static ApiServices get instance => _instance;

  final headers = {'Content-Type': 'application/json'};
  Future<http.Response> userSignup(Map<String, dynamic> userdata) async {
    final url = Uri.parse(ApiUrls.signupUrl);
    final body = jsonEncode(userdata);
    final response = await http.post(url, body: body, headers: headers);
    print(response.statusCode);
    return response;
  }

  Future<http.Response> userOtp(Map<String, int?> otp) async {
    final url = Uri.parse(ApiUrls.otpverificationUrl);
    final body = jsonEncode(otp);
    final response = await http.post(url, body: body, headers: headers);
    print("otp Verificationn Response === ${response.statusCode}");
    print("otp messege Response === ${response.body}");
    return response;
  }
}
