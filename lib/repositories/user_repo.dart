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
    const url = ApiUrls.changepassword;
    return ApiService.patchApi(data, url, token);
  }

  EitherResponse fetchUserData() {
    final token = SharedPref.instance.getToke();
    const url = ApiUrls.userdata;
    return ApiService.getApi(url, token);
  }
}
