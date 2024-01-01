import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:carnova_user/blocs/login/login_bloc.dart';
import 'package:carnova_user/data/get_it/get_it.dart';
import 'package:carnova_user/data/shared_preferance/sharedprefrance.dart';
import 'package:carnova_user/modals/user_modal.dart';
import 'package:carnova_user/repositories/signup_repo.dart';
import 'package:carnova_user/repositories/userdata_repo.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupButtonClicked>(signupButtonClicked);
  }

  FutureOr<void> signupButtonClicked(
      SignupButtonClicked event, Emitter<SignupState> emit) async {
    emit(LoadingState());
    final response = await UserSignupRepo().userSignup(event.signupdata);
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      String token = body['token'];
      SharedPref.instance.storeToken(token);
      final responsess = await UserDataRepo().userData(token);
      if (responsess.statusCode == 200) {
        final dataJson = jsonDecode(responsess.body);
        final userdata = UserModal.fromJson(dataJson);
        locator<LoginBloc>().logedUser = userdata;
        emit(SignupSucsessState());
      }
      emit(SignupFailedState(messege: body["message"]));
    } else {
      emit(SignupFailedState(messege: body["message"]));
    }
  }
}
