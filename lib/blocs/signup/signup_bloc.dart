import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:carnova_user/blocs/vehicle_check/vehicle_check_bloc.dart';
import 'package:carnova_user/data/get_it/get_it.dart';
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
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      locator<VehicleCheckBloc>().activeVehicles = [];
      locator<VehicleCheckBloc>().allBookedVehicles = [];
      locator<VehicleCheckBloc>().bookedVehicles = [];
      emit(SignupSucsessState());
    } else {
      emit(SignupFailedState(messege: body["message"]));
    }
  }
}
