class ApiUrls {
  static const String baseUrl = "http://192.168.86.133:3000";
  static const String userUrl = "$baseUrl/user";
  static const String loginUrl = "$userUrl/login";
  static const String userdata = "$userUrl/getuser";
  static const String signupUrl = "$userUrl/signup";
  static const String otpverificationUrl = "$userUrl/verify-otp";
  static const String addProfile = "$userUrl/update-profile";
  static const String updateprofile = "$userUrl/update-user";
}
