// import 'package:user_side/data/netword/api_service.dart';
// import 'package:user_side/data/netword/api_urls.dart';
// import 'package:user_side/data/shared_preference/shared_prefence.dart';

// class UserRepo {
//   final token = SharedPref.instance.getToke();

//   EitherResponse signUpUser(Map<String, dynamic> data) {
//     const url = '${ApiUrls.baseUrl}/${ApiUrls.signUp}';
//     return ApiService.postApi(data, url);
//   }

//   EitherResponse signupOtp(Map<String, dynamic> otp) {
//     const url = '${ApiUrls.baseUrl}/${ApiUrls.otp}';
//     return ApiService.postApi(otp, url);
//   }

//   EitherResponse loginUser(Map<String, String> userData) {
//     const url = '${ApiUrls.baseUrl}/${ApiUrls.login}';
//     return ApiService.postApi(userData, url);
//   }

//   EitherResponse putAvailableVehicle(Map<String, String> checkingData) {
//     const url = '${ApiUrls.baseUrl}/${ApiUrls.putAvailableVehicles}';
//     return ApiService.putApi(checkingData, url, token);
//   }

//   EitherResponse getAvailableVehicles() {
//     const url = '${ApiUrls.baseUrl}/${ApiUrls.getAvailableVehcles}';
//     return ApiService.getApi(url, token);
//   }

//   EitherResponse forgetPasswordEmailChecking(Map<String, String> data) {
//     const url = '${ApiUrls.baseUrl}/${ApiUrls.forgetPassword}';
//     return ApiService.postApi(data, url);
//   }

//   EitherResponse resetPassword(Map<String, String> data, String userId) {
//     final url = '${ApiUrls.baseUrl}/${ApiUrls.resetPassword}/$userId';
//     return ApiService.patchApi(data, url);
//   }

//   EitherResponse fetchUserData(String usertoken) {
//     const url = '${ApiUrls.baseUrl}/${ApiUrls.getUserData}';
//     return ApiService.getApi(url, usertoken);
//   }
// }
import 'package:carnova_user/data/network/api_services.dart';
import 'package:carnova_user/data/shared_preferance/sharedprefrance.dart';
import 'package:carnova_user/resources/api_urls/api_urls.dart';

class UserRepo {
  final token = SharedPref.instance.getToke();
  EitherResponse getAvailableVehicles() {
    const url = ApiUrls.getVehicles;
    return ApiService.getApi(url, token);
  }

  EitherResponse storeChoice(Map<String, String> data) async {
    const url = ApiUrls.putAvailableVehicles;
    return ApiService.putApi(data, url, token);
  }

  EitherResponse resetPassword(Map<String, String> data) async {
    const url = ApiUrls.resetpassword;
    return ApiService.patchApi(data, url,token);
  }
}
