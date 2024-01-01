// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'password_settings_bloc.dart';

abstract class PasswordSettingsEvent {}

class ResetPassword extends PasswordSettingsEvent {
  String oldpassword;
  String newpassword;
  String confirmpassword;
  ResetPassword({
    required this.oldpassword,
    required this.newpassword,
    required this.confirmpassword
  });
}

class ForgetPassword extends PasswordSettingsEvent {
  String email;
  ForgetPassword({required this.email});
}
