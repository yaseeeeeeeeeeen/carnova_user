part of 'password_settings_bloc.dart';

abstract class PasswordSettingsState {}

final class PasswordSettingsInitial extends PasswordSettingsState {}

final class PasswordChangeLoading extends PasswordSettingsState {}

final class PasswordChangeErorr extends PasswordSettingsState {}

final class PasswordChangeFailed extends PasswordSettingsState {
final  String messege;

  PasswordChangeFailed({required this.messege});
}

final class PasswordChangeSuccsess extends PasswordSettingsState {}
