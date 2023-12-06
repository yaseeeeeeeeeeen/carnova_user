part of 'signup_bloc.dart';

abstract class SignupState {}

final class SignupInitial extends SignupState {}

class LoadingState extends SignupState{}

class SignupSucsessState extends SignupState{}

class SignupFailedState extends SignupState{}