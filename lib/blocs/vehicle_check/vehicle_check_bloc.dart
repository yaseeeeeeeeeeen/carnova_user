import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:carnova_user/blocs/vehicle_check/vehicle_check_state.dart';
import 'package:carnova_user/modals/all_vehicle_list_modal.dart';
import 'package:carnova_user/modals/booked_vehicle.dart';
import 'package:carnova_user/modals/fetch_modal.dart';
import 'package:carnova_user/repositories/booking_repo.dart';
import 'package:carnova_user/repositories/user_repo.dart';
import 'package:carnova_user/utils/functions/location_picker.dart';
import 'package:geolocator/geolocator.dart';

part 'vehicle_check_event.dart';

class VehicleCheckBloc extends Bloc<VehicleCheckEvent, VehicleCheckState> {
  // late List<Vehicle> allVehicles;
  late List<BookedVehicle> bookedVehicles;
  late List<BookedVehicle> allBookedVehicles;
  late List<BookedVehicle> activeVehicles;
  Position? location;
  VehicleCheckBloc() : super(VehicleCheckInitial()) {
    on<CheckAvaliblityButtonClicked>(checkAvaliblityButtonClicked);
    on<FetchAvalibleVehicles>(fetchAvalibleVehicles);
    on<FetchVehicles>(fetchVehicles);
    on<GetAllVehicles>(getAllVehicles);
    on<VehicleSearchEvent>(vehicleSearchEvent);
    on<FilteringEventFromAllVehicles>(filteringEventFromAllVehicles);
  }

  FutureOr<void> checkAvaliblityButtonClicked(
      CheckAvaliblityButtonClicked event,
      Emitter<VehicleCheckState> emit) async {
    emit(VehicleCheckLoading());
    Position? currentLoaction =
        await LocationPickerFunction().getCurrentLocation();
    if (currentLoaction != null) {
      location = currentLoaction;
      String? address =
          await LocationPickerFunction().getAddress(currentLoaction);
      if (address != null) {
        Map<String, String> data = {
          "startDate": event.startDate,
          "endDate": event.endDate,
          "pickup": address,
          "dropoff": address,
        };
        emit(UserStoreChoiceState(data: data));
      }
    } else {
      emit(LocationPickingFailed());
    }
  }

  FutureOr<void> fetchAvalibleVehicles(
      FetchAvalibleVehicles event, Emitter<VehicleCheckState> emit) async {
    emit(VehicleCheckLoading());
    final response = await UserRepo().storeChoice(event.checkingData);
    response.fold((left) {
      emit(VehilceFetchingFailed(messege: left.message));
    }, (right) {
      if (right['message'] == 'Success') {
        emit(UserStoreChoiceSuccsess());
      }
    });
  }

  FutureOr<void> fetchVehicles(
      FetchVehicles event, Emitter<VehicleCheckState> emit) async {
    emit(VehicleCheckLoading());
    final response = await UserRepo().getAvailableVehicles();
    response.fold((left) {
      emit(VehilceFetchingFailed(messege: left.message));
    }, (right) {
      final List vehicleList = right['vehicles'];
      List<Vehicle> vehicleModel =
          vehicleList.map((e) => Vehicle.fromJson(e)).toList();
      emit(VehicleFetchSuccsessState(
          vehicleModel: vehicleModel, location: location!));
    });
  }

  FutureOr<void> getAllVehicles(
      GetAllVehicles event, Emitter<VehicleCheckState> emit) async {
    emit(VehicleCheckLoading());
    Future.delayed(const Duration(seconds: 2));
    final response = await BookingRepo().getAllVehicles();
    response.fold((left) {
      emit(VehilceFetchingFailed(messege: left.message));
    }, (right) {
      final data = AllVehicleModal.fromJson(right);
      emit(AllVehiclefetchedState(allVehicles: data.vehicles));
    });
  }

  FutureOr<void> vehicleSearchEvent(
      VehicleSearchEvent event, Emitter<VehicleCheckState> emit) async {
    emit(VehicleCheckLoading());
    List<Vehicle2> searchResult = event.datas
        .where((element) =>
            element.name.toLowerCase().contains(event.text.toLowerCase()))
        .toList();
    emit(SearchedList(allVehicles: searchResult));
  }

  FutureOr<void> filteringEventFromAllVehicles(
    FilteringEventFromAllVehicles event,
    Emitter<VehicleCheckState> emit,
  ) async {
    List<Vehicle2> filteredVehicles = event.datas;

    if (event.brand != null ||
        event.priceRange != null ||
        event.fuelType != null) {
      print("Filtering List");

      filteredVehicles = filteredVehicles.where((element) {
        bool brandCondition =
            event.brand == null || element.brand == event.brand;
        bool priceCondition =
            event.priceRange == null || element.price <= event.priceRange!;
        bool fuelCondition =
            event.fuelType == null || element.fuel == event.fuelType;
        return fuelCondition && brandCondition && priceCondition;
      }).toList();
    }

    emit(FilteredList(allVehicles: filteredVehicles));
  }
}
