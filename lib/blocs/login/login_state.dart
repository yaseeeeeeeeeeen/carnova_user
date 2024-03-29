// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

abstract class LoginState {}

final class LoginInitial extends LoginState {}

class LoadingState extends LoginState {}

class LoginSuccsess extends LoginState {}

class LogedUserFetched extends LoginState {}

class LoginFailedState extends LoginState {
  String messege;
  LoginFailedState({required this.messege});
}

class PasswordResetedSuccsess extends LoginState{}

class ForgetPasswordMailSended extends LoginState {
  String otp;
  String id;
  ForgetPasswordMailSended({required this.otp,required this.id});
}
