// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginButtonClickedEvent extends LoginEvent {
  Map<String, String> mailandpass;
  LoginButtonClickedEvent({required this.mailandpass});
}

class BookingHistoryFetching extends LoginEvent {}

class ForgetPasswordClicked extends LoginEvent {
  String email;
  ForgetPasswordClicked({required this.email});
}


class ResetPasswordWithId extends LoginEvent {
    String id;
  String pass1;
  String pass2;
  ResetPasswordWithId({
    required this.id,
    required this.pass1,
    required this.pass2,
  });
}
