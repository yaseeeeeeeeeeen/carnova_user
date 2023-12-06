import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:carnova_user/repositories/signup_repo.dart';

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
    print(response.statusCode);
    if (response.statusCode == 200) {
      emit(SignupSucsessState());
    } else {
      emit(SignupFailedState());
    }
  }
}
