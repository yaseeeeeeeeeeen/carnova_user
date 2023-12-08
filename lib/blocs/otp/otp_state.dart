// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'otp_bloc.dart';

abstract class OtpState {}

final class OtpInitial extends OtpState {}

class OtpVerificationSuccsessState extends OtpState {}

class OtpVerificationFailedState extends OtpState {
  String messege;
  OtpVerificationFailedState({required this.messege});
}

class LoadingState extends OtpState {}
