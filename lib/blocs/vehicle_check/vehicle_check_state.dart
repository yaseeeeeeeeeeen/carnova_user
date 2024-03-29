// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:geolocator/geolocator.dart';

import 'package:carnova_user/modals/all_vehicle_list_modal.dart';
import 'package:carnova_user/modals/fetch_modal.dart';

abstract class VehicleCheckState {}

final class VehicleCheckInitial extends VehicleCheckState {}

class VehicleCheckLoading extends VehicleCheckState {}
class VehicleCheckAllVehicleLoading extends VehicleCheckState {}

class UserStoreChoiceState extends VehicleCheckState {
  Map<String, String> data;
  UserStoreChoiceState({required this.data});
}

class UserStoreChoiceSuccsess extends VehicleCheckState {}

// class PutVehicleSuccsess extends VehicleCheckState {}

class VehilceFetchingFailed extends VehicleCheckState {
  String messege;
  VehilceFetchingFailed({required this.messege});
}

class LocationPickingFailed extends VehicleCheckState {
  String message = "Location Picking Failed";
}

class VehicleFetchSuccsessState extends VehicleCheckState {
  Position location;
  List<Vehicle> vehicleModel;
  VehicleFetchSuccsessState(
      {required this.vehicleModel, required this.location});
}

class AllVehiclefetchedState extends VehicleCheckState {
  List<Vehicle2> allVehicles;
  AllVehiclefetchedState({required this.allVehicles});
}

class SearchedList extends VehicleCheckState {
  List<Vehicle2> allVehicles;
  SearchedList({required this.allVehicles});
}

class FilteredList extends VehicleCheckState {
  List<Vehicle2> allVehicles;
  FilteredList({required this.allVehicles});
}

class LocationSearchedSuccsess extends VehicleCheckState {
  List<Map<String, dynamic>> locationList;
  LocationSearchedSuccsess({required this.locationList});
}

class CheckVehicleAvalibleSuccess extends VehicleCheckState {}

class AllreadyThisVehicleHaveBooking extends VehicleCheckState {}
class DeffultCalanderState extends VehicleCheckState {}

class CheckVehicleAvalibleFailed extends VehicleCheckState {
  String messege;
  CheckVehicleAvalibleFailed({required this.messege});
}
