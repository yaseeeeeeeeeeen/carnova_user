import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:carnova_user/data/get_it/get_it.dart';
import 'package:carnova_user/data/shared_preferance/sharedprefrance.dart';
import 'package:carnova_user/modals/user_modal.dart';
import 'package:carnova_user/repositories/login_repo.dart';
import 'package:carnova_user/repositories/user_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late UserModal logedUser;
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
  }

  FutureOr<void> loginButtonClickedEvent(
      LoginButtonClickedEvent event, Emitter<LoginState> emit) async {
    emit(LoadingState());
    final response = await UserLoginRepo().userLogin(event.mailandpass);
    final body = jsonDecode(response.body);
    print(response.body);
    if (response.statusCode == 201) {
      String token = body['token'];
      SharedPref.instance.storeToken(token);
      final response1 = await UserRepo().fetchUserData();
      print(response1);
      response1.fold((left) {
        LoginFailedState(messege: left.message);
      }, (right) {
        final userdata = UserModal.fromJson(right);
        locator<LoginBloc>().logedUser = userdata;
        emit(LoginSuccsess());
      });
    } else {
      emit(LoginFailedState(messege: body["message"]));
    }
  }
}
