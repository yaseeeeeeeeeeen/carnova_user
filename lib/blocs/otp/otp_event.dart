// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'otp_bloc.dart';

abstract class OtpEvent {}

class OtpSubmitButtonClicked extends OtpEvent {
  Map<String, int> otp;
  OtpSubmitButtonClicked({required this.otp});
}
