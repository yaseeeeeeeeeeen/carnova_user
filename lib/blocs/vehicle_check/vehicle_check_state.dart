// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'vehicle_check_bloc.dart';

abstract class VehicleCheckState {}

final class VehicleCheckInitial extends VehicleCheckState {}

class VehicleCheckLoading extends VehicleCheckState {}

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
  VehicleFetchSuccsessState({required this.vehicleModel,required this.location});
}
