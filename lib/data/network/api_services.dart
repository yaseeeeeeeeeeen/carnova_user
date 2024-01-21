import 'dart:convert';
import 'dart:io';

import 'package:carnova_user/data/get_it/get_it.dart';
import 'package:carnova_user/data/shared_preferance/sharedprefrance.dart';
import 'package:carnova_user/resources/api_urls/api_urls.dart';
import 'package:carnova_user/utils/app_exceptions.dart';
import 'package:either_dart/either.dart';
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
    final header = {'Authorization': 'Bearer $token', 'Cookie': 'jwt=$token'};
    final response = await http.get(url, headers: header);
    return response;
  }

  Future<http.StreamedResponse> profileUpdate(File image) async {
    final token = SharedPref.instance.getToke();
    final url = Uri.parse(ApiUrls.addProfile);
    var request = http.MultipartRequest('PATCH', url);
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Cookie'] = 'jwt=$token';
    var profilePhotoStream = http.ByteStream(image.openRead());
    var profilePhotoLength = await image.length();
    var profilePhotoMultipartFile = http.MultipartFile(
      'profile',
      profilePhotoStream,
      profilePhotoLength,
      filename: 'profilephoto.jpg',
    );
    request.files.add(profilePhotoMultipartFile);
    final response = await request.send();
    return response;
  }

  Future<http.Response> dataUpdate(Map<String, dynamic> data) async {
    final url = Uri.parse(ApiUrls.updateprofile);
    final token = SharedPref.instance.getToke();
    final header = {
      'Authorization': 'Bearer $token',
      'Cookie': 'jwt=$token',
      'Content-Type': 'application/json'
    };

    final body = jsonEncode(data);
    final response = await http.patch(url, body: body, headers: header);
    return response;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

typedef EitherResponse = Future<Either<AppExceptions, dynamic>>;

class ApiService {
  static Map<String, String> header = {"Content-Type": "application/json"};

  static EitherResponse getApi(String url, [String? token]) async {
    if (token != null) {
      header["Authorization"] = "Bearer $token";
      header["Cookie"] = 'jwt=$token';
      header["Content-Type"] = 'application/json';
    }
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri, headers: header);
      final body = getResponse(response);
      return Right(body);
    } on SocketException {
      return Left(InterntExceptions());
    } on http.ClientException {
      return Left(BadRequestExceptions());
    } catch (e) {
      return Left(RequestTimeOutExceptions());
    }
  }

  static EitherResponse postApi(var data, String url, [String? token]) async {
    if (token != null) {
      header["Authorization"] = "Bearer $token";
      header["Cookie"] = 'jwt=$token';
    }
    final uri = Uri.parse(url);
    final body = jsonEncode(data);
    try {
      final response = await http.post(uri, body: body, headers: header);
      print(response.statusCode);
      final responseBody = getResponse(response);
      return Right(responseBody);
    } on SocketException {
      return Left(InterntExceptions());
    } on http.ClientException {
      return Left(BadRequestExceptions());
    } catch (e) {
      return Left(RequestTimeOutExceptions());
    }
  }

  static EitherResponse patchApi(var data, String url, [String? token]) async {
    if (token != null) {
      header["Authorization"] = "Bearer $token";
      header["Cookie"] = 'jwt=$token';
    }
    final uri = Uri.parse(url);
    final body = jsonEncode(data);
    try {
      final response = await http.patch(
        uri,
        body: body,
        headers: header,
      );
      Map<String, dynamic> responseBody = getResponse(response);
      return Right(responseBody);
    } on SocketException {
      return Left(InterntExceptions());
    } on http.ClientException {
      return Left(BadRequestExceptions());
    } catch (e) {
      return Left(RequestTimeOutExceptions());
    }
  }

  static EitherResponse deleteApi(String url, [String? token]) async {
    if (token != null) {
      header["Authorization"] = "Bearer $token";
      header["Cookie"] = 'jwt=$token';
    }
    final uri = Uri.parse(url);
    try {
      final response = await http.delete(
        uri,
        headers: header,
      );
      final responseBody = getResponse(response);
      return Right(responseBody);
    } on SocketException {
      return Left(InterntExceptions());
    } on http.ClientException {
      return Left(BadRequestExceptions());
    } catch (e) {
      return Left(RequestTimeOutExceptions());
    }
  }

  static EitherResponse putApi(var data, String url, [String? token]) async {
    if (token != null) {
      header["Authorization"] = "Bearer $token";
      header["Cookie"] = 'jwt=$token';
    }
    final uri = Uri.parse(url);
    final body = jsonEncode(data);

    try {
      final response = await http.put(
        uri,
        body: body,
        headers: header,
      );
      final responseBody = getResponse(response);
      return Right(responseBody);
    } on SocketException {
      return Left(InterntExceptions());
    } on http.ClientException {
      return Left(BadRequestExceptions());
    } catch (e) {
      return Left(RequestTimeOutExceptions());
    }
  }

  static getResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      throw BadRequestExceptions();
    } else if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw BadRequestExceptions();
    }
  }
}
