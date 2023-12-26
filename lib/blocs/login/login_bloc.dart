import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:carnova_user/data/shared_preferance/sharedprefrance.dart';
import 'package:carnova_user/modals/user_modal.dart';
import 'package:carnova_user/repositories/login_repo.dart';
import 'package:carnova_user/repositories/userdata_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
  }

  FutureOr<void> loginButtonClickedEvent(
      LoginButtonClickedEvent event, Emitter<LoginState> emit) async {
    emit(LoadingState());
    final response = await UserLoginRepo().userLogin(event.mailandpass);
    final body = jsonDecode(response.body);

    if (response.statusCode == 201) {
      String token = body['token'];
      SharedPref.instance.storeToken(token);
      final responsess = await UserDataRepo().userData(token);
      if (responsess.statusCode == 200) {
        final dataJson = jsonDecode(responsess.body);
        final userdata = UserModal.fromJson(dataJson);
        logedUser = userdata;

        emit(LoginSuccsess());
      } else {
        emit(LoginFailedState(messege: body["message"]));
      }
    } else {
      emit(LoginFailedState(messege: body["message"]));
    }
  }
}
