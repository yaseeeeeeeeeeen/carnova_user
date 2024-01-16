import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:carnova_user/blocs/vehicle_check/vehicle_check_bloc.dart';
import 'package:carnova_user/data/get_it/get_it.dart';
import 'package:carnova_user/data/shared_preferance/sharedprefrance.dart';
import 'package:carnova_user/modals/booked_vehicle.dart';
import 'package:carnova_user/modals/user_modal.dart';
import 'package:carnova_user/repositories/booking_repo.dart';
import 'package:carnova_user/repositories/login_repo.dart';
import 'package:carnova_user/repositories/user_repo.dart';
import 'package:intl/intl.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late UserModal logedUser;
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
    on<BookingHistoryFetching>(bookingHistoryFetching);
    on<ForgetPasswordClicked>(forgetPasswordClicked);
  }

  FutureOr<void> loginButtonClickedEvent(
      LoginButtonClickedEvent event, Emitter<LoginState> emit) async {
    emit(LoadingState());
    final response = await UserLoginRepo().userLogin(event.mailandpass);
    final body = jsonDecode(response.body);
    if (response.statusCode == 201) {
      String token = body['token'];
      SharedPref.instance.storeToken(token);
      final response1 = await UserRepo().fetchUserData();
      response1.fold((left) {
        LoginFailedState(messege: left.message);
      }, (right) {
        final userdata = UserModal.fromJson(right);
        locator<LoginBloc>().logedUser = userdata;
        emit(LogedUserFetched());
      });
    } else {
      emit(LoginFailedState(messege: body["message"]));
    }
  }

  FutureOr<void> bookingHistoryFetching(
      BookingHistoryFetching event, Emitter<LoginState> emit) async {
    emit(LoadingState());
    final userBooking = await BookingRepo().userBookings();
    userBooking.fold((left) {
      locator<VehicleCheckBloc>().bookedVehicles = [];
      locator<VehicleCheckBloc>().allBookedVehicles = [];
      locator<VehicleCheckBloc>().activeVehicles = [];
      emit(LoginSuccsess());
    }, (right) {
      print("DATA FROM LOGIN $right");
      DateTime currentDate = DateTime.now();
      DateFormat('yyyy-MM-dd').format(currentDate);
      final List vehicleList = right as List;
      final datas = vehicleList.map((e) => BookedVehicle.fromJson(e)).toList();
      locator<VehicleCheckBloc>().allBookedVehicles = datas;
      //////////////////// DIVIED BOOKED AND NOT BOOKED////////////////////////////////
      final bookedonly =
          datas.where((element) {
                 final startDate = DateTime.parse(element.startDate);
     //   final endDate = DateTime.parse(element.endDate);
        return startDate.isBefore(currentDate) &&
        //    endDate.isAfter(currentDate) &&
            element.status == "Booked";
          }).toList();
      locator<VehicleCheckBloc>().bookedVehicles = bookedonly;
      ////////////////// ACTIVE VEHICLE SORTING/////////////////////////////////
      locator<VehicleCheckBloc>().activeVehicles = datas.where((element) {
        final startDate = DateTime.parse(element.startDate);
        final endDate = DateTime.parse(element.endDate);
        return startDate.isBefore(currentDate) &&
            endDate.isAfter(currentDate) &&
            element.status == "Booked";
      }).toList();
      emit(LoginSuccsess());
    });
  }
//////////////////// WORK PENDING////////////////////////////////////////////////////////////////////////
  FutureOr<void> forgetPasswordClicked(
      ForgetPasswordClicked event, Emitter<LoginState> emit) async {
    emit(LoadingState());
    final response = await UserLoginRepo().forgetPassword(event.email);
    response.fold((left) {}, (right) {

    });
  }
}
