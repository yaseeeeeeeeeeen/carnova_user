// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_bloc.dart';

abstract class SignupState {}

final class SignupInitial extends SignupState {}

class LoadingState extends SignupState {}

class SignupSucsessState extends SignupState {}

class SignupFailedState extends SignupState {
  String messege;
  SignupFailedState({required this.messege});
}
