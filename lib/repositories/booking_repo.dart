import 'package:carnova_user/data/network/api_services.dart';
import 'package:carnova_user/data/shared_preferance/sharedprefrance.dart';
import 'package:carnova_user/resources/api_urls/api_urls.dart';

class BookingRepo {
  String? token = SharedPref.instance.getToke();
  EitherResponse bookvehicle(Map<String, dynamic> bookingdata) async {
    const url = ApiUrls.bookVehicle;
    return ApiService.postApi(bookingdata, url, token);
  }

  EitherResponse userBookings() async {
    const url = ApiUrls.getBooking;
    return ApiService.getApi(url, token);
  }

  EitherResponse cancelBooking(String bookId, data) async {
    String url = "${ApiUrls.cancelBooking}/$bookId";
    return ApiService.patchApi(data, url, token);
  }
}
