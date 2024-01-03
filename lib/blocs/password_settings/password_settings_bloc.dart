import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:carnova_user/repositories/user_repo.dart';

part 'password_settings_event.dart';
part 'password_settings_state.dart';

class PasswordSettingsBloc
    extends Bloc<PasswordSettingsEvent, PasswordSettingsState> {
  PasswordSettingsBloc() : super(PasswordSettingsInitial()) {
    on<ResetPassword>(resetPassword);
    on<ForgetPassword>(forgetPassword);
    on<PasswordVisiblity>(passwordVisiblity);
  }

  FutureOr<void> resetPassword(
      ResetPassword event, Emitter<PasswordSettingsState> emit) async {
    emit(PasswordChangeLoading());
    final data = {
      "oldpass": event.oldpassword,
      "newpass": event.newpassword,
      "confirmpass": event.confirmpassword,
    };
    final response = await UserRepo().resetPassword(data);
    response.fold((left) {
      emit(PasswordChangeFailed(messege: left.message));
    }, (right) {
      emit(PasswordChangeSuccsess());
    });
  }

  FutureOr<void> forgetPassword(
      ForgetPassword event, Emitter<PasswordSettingsState> emit) async {
    emit(PasswordChangeLoading());
  }

  FutureOr<void> passwordVisiblity(
      PasswordVisiblity event, Emitter<PasswordSettingsState> emit) {
    event.visiblity
        ? emit(PasswordVisiblityoff())
        : emit(PasswordVisiblityOn());
  }
}
