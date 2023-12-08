import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:carnova_user/data/network/api_services.dart';

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
    if (response.statusCode == 200) {
      emit(OtpVerificationSuccsessState());
    } else {
      emit(OtpVerificationFailedState());
    }
  }
}
