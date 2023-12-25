// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'vehicle_check_bloc.dart';

abstract class VehicleCheckState {}

final class VehicleCheckInitial extends VehicleCheckState {}

class VehicleCheckLoading extends VehicleCheckState {}

class UserLoactionPickedSuccsessState extends VehicleCheckState {
  String loction;
  double lat;
  double long;
  UserLoactionPickedSuccsessState({
    required this.loction,
    required this.lat,
    required this.long,
  });

}

class LocationPickingFailed extends VehicleCheckState {
  String message = "Location Picking Failed";
}
