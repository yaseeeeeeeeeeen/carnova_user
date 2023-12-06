import 'dart:async';

import 'package:bloc/bloc.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitial()) {
    on<OtpSubmitButtonClicked>(otpSubmitButtonClicked);
  }

  FutureOr<void> otpSubmitButtonClicked(
      OtpSubmitButtonClicked event, Emitter<OtpState> emit) async {
    emit(LoadingState());
    
  }
}
