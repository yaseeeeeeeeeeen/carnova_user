part of 'otp_bloc.dart';

abstract class OtpState {}

final class OtpInitial extends OtpState {}

class OtpVerificationSuccsessState extends OtpState {}

class OtpVerificationFailedState extends OtpState {}

class LoadingState extends OtpState {}
