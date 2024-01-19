// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'vehicle_check_bloc.dart';

abstract class VehicleCheckEvent {}

class CheckAvaliblityButtonClicked extends VehicleCheckEvent {
  String startDate;
  String endDate;
  String? location;
  CheckAvaliblityButtonClicked(
      {required this.startDate, required this.endDate, this.location});
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
  VehicleSearchEvent({required this.text, required this.datas});
}

class FilteringEventFromAllVehicles extends VehicleCheckEvent {
  List<Vehicle2> datas;
  String brand;
  int priceRange;
  int seatCount;
  String fuelType;
  FilteringEventFromAllVehicles(
      {required this.datas,
      required this.seatCount,
      required this.brand,
      required this.priceRange,
      required this.fuelType});
}

class FilterResetButtonClicked extends VehicleCheckEvent {
  List<Vehicle2> datas;
  FilterResetButtonClicked({required this.datas});
}

class LocationSearchButtonClicked extends VehicleCheckEvent {
  String location;
  LocationSearchButtonClicked({required this.location});
}

class CheckAVhicleBookings extends VehicleCheckEvent {
  final String location;
  final String vehicleId;
  final String endDate;
  final String startDate;

  CheckAVhicleBookings(this.location, this.vehicleId, this.endDate, this.startDate);
}

class DeffualtCalanderOpen extends VehicleCheckEvent{}