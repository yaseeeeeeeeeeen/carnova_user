// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_bloc.dart';

abstract class SignupEvent {}

class SignupButtonClicked extends SignupEvent {
  Map<String, Object> signupdata;
  SignupButtonClicked({required this.signupdata});
}
