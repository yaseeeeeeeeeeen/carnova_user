class ApiUrls {
  static const String baseUrl = "http://10.4.6.91:3000";
  static const String userUrl = "$baseUrl/user";
  static const String loginUrl = "$userUrl/login";
  static const String userdata = "$userUrl/getuser";
  static const String signupUrl = "$userUrl/signup";
  static const String otpverificationUrl = "$userUrl/verify-otp";
  static const String addProfile = "$userUrl/update-profile";
  static const String updateprofile = "$userUrl/update-user";
  static const String getVehicles = "$userUrl/vehicles";
  static const String putAvailableVehicles = '$userUrl/store-choice';
  static const String resetpassword = '$userUrl/reset-password';
}
