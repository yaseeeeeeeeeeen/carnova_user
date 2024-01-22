class ApiUrls {
//  https://carnova.onrender.com
  static const String baseUrl = "https://server.carnova.online";
  static const String userUrl = "$baseUrl/user";
  static const String loginUrl = "$userUrl/login";
  static const String userdata = "$userUrl/getuser";
  static const String signupUrl = "$userUrl/signup";
  static const String otpverificationUrl = "$userUrl/verify-otp";
  static const String addProfile = "$userUrl/update-profile";
  static const String updateprofile = "$userUrl/update-user";
  static const String getVehicles = "$userUrl/vehicles";
  static const String putAvailableVehicles = '$userUrl/store-choice';
  static const String changepassword = '$userUrl/change-password';
  static const String bookVehicle = "$userUrl/book-vehicle";
  static const String getBooking = "$userUrl/user-booking";
  static const String cancelBooking = '$userUrl/cancel-booking';
  static const String getAllVehicles = '$userUrl/getVehicles';
  static const String forgetPassword = '$userUrl/forgot-password';
  static const String resetPassword = '$userUrl/reset-password/';
  static const String vehicleAvaliblity = '$userUrl/vehicle-available';
  static const String imagegettingUrl = "$baseUrl/admin/getFile/";
}
