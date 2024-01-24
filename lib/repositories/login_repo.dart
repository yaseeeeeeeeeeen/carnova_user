import 'package:carnova_user/data/network/api_services.dart';
import 'package:carnova_user/resources/api_urls/api_urls.dart';
import 'package:http/http.dart' as http;

class UserLoginRepo {
  Future<http.Response> userLogin(Map<String, String> mailAndpass) async {
    final response = await ApiServices.instance.userLogin(mailAndpass);
    return response;
  }

  EitherResponse forgetPassword(String email) async {
    Map<String, String> data = {"email": email};
    String url = ApiUrls.forgetPassword;
    return ApiService.postApi(data, url);
  }

  EitherResponse resetPassword(String pass1, String pass2, String id) {
    Map<String, dynamic> data = {"newpass": pass1, "confirmpass": pass2};
    String url = "${ApiUrls.resetPassword}$id";
    return ApiService.patchApi(data, url);
  }
    EitherResponse forgetPassChange(String pass1, String pass2, String id) async {
    Map<String, dynamic> data = {"newpass": pass1, "confirmpass": pass2};
    String url = "${ApiUrls.resetPassword}$id";
    return ApiService.patchApi(data, url);
  }
}
