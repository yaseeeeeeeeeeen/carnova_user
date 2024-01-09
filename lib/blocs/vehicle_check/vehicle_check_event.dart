// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'vehicle_check_bloc.dart';

abstract class VehicleCheckEvent {}

class CheckAvaliblityButtonClicked extends VehicleCheckEvent {
  String startDate;
  String endDate;
  CheckAvaliblityButtonClicked(
      {required this.startDate, required this.endDate});
}

class FetchAvalibleVehicles extends VehicleCheckEvent {
  Map<String, String> checkingData;
  FetchAvalibleVehicles({required this.checkingData});
}

class FetchVehicles extends VehicleCheckEvent {}

class GetAllVehicles extends VehicleCheckEvent {}

class VehicleSearchEvent extends VehicleCheckEvent {
  List<Vehicle2> datas;
  String text;
  VehicleSearchEvent({required this.text,required this.datas});
}
