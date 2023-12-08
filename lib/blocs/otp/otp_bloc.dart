import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:carnova_user/data/network/api_services.dart';
import 'package:carnova_user/data/shared_preferance/sharedprefrance.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitial()) {
    on<OtpSubmitButtonClicked>(otpSubmitButtonClicked);
  }

  FutureOr<void> otpSubmitButtonClicked(
      OtpSubmitButtonClicked event, Emitter<OtpState> emit) async {
    emit(LoadingState());
    final response = await ApiServices.instance.userOtp(event.otp);
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      String token = body['token'];
      print("token is : $token");
      SharedPreference.instance.storeToken(token);
      emit(OtpVerificationSuccsessState());
    } else {
      emit(OtpVerificationFailedState(messege: body["message"]));
    }
  }
}
