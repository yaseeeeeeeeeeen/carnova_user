// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

abstract class LoginState {}

final class LoginInitial extends LoginState {}

class LoadingState extends LoginState {}

class LoginSuccsess extends LoginState {}

class LoginFailedState extends LoginState {
  String messege;
  LoginFailedState({required this.messege});
}
