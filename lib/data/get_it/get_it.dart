import 'package:carnova_user/blocs/login/login_bloc.dart';
import 'package:carnova_user/blocs/vehicle_check/vehicle_check_bloc.dart';
import 'package:carnova_user/modals/booked_vehicle.dart';
import 'package:carnova_user/modals/user_modal.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => LoginBloc());
  locator.registerLazySingleton(() => VehicleCheckBloc());
}

UserModal getLoggedInUser() {
  return locator<LoginBloc>().logedUser;
}

void replaceUserData(UserModal updatedUserData) {
  locator<LoginBloc>().logedUser = updatedUserData;
}

List<BookedVehicle> bookedHistory() {
  return locator<VehicleCheckBloc>().allBookedVehicles;
}
void replaceBookedHistory(List<BookedVehicle> updatedData) {
  locator<VehicleCheckBloc>().allBookedVehicles = updatedData;
}

void replaceActive(List<BookedVehicle> updatedData) {
  locator<VehicleCheckBloc>().activeVehicles = updatedData;
}
List<BookedVehicle> getActiveVehicles() {
  return locator<VehicleCheckBloc>().activeVehicles;
}

List<BookedVehicle> getBookedVehicleList() {
  return locator<VehicleCheckBloc>().bookedVehicles;
}

void replaceBookedList(List<BookedVehicle> updatedData) {
  locator<VehicleCheckBloc>().bookedVehicles = updatedData;
}

