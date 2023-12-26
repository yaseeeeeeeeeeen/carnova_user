import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:carnova_user/modals/fetch_modal.dart';
import 'package:carnova_user/repositories/user_repo.dart';
import 'package:carnova_user/utils/functions/location_picker.dart';
import 'package:geolocator/geolocator.dart';

part 'vehicle_check_event.dart';
part 'vehicle_check_state.dart';

class VehicleCheckBloc extends Bloc<VehicleCheckEvent, VehicleCheckState> {
  Position? location;
  VehicleCheckBloc() : super(VehicleCheckInitial()) {
    on<CheckAvaliblityButtonClicked>(checkAvaliblityButtonClicked);
    on<FetchAvalibleVehicles>(fetchAvalibleVehicles);
    on<FetchVehicles>(fetchVehicles);
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
}


// import 'dart:async';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:user_side/models/vehicle_model.dart';
// import 'package:user_side/repositories/user_repo.dart';

// part 'vehicle_event.dart';
// part 'vehicle_state.dart';

// class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
//   VehicleBloc() : super(VehicleInitial()) {
//     on<FetchAvailableVehicleEvent>(fetchAvailableVehicle);
//     on<FetchVehicleEvent>(fetchVehicleEvent);
//   }

//   FutureOr<void> fetchAvailableVehicle(
//       FetchAvailableVehicleEvent event, Emitter<VehicleState> emit) async {
//     emit(FetchAvailableVehicleLoadingState());
//     final responseData =
//         await UserRepo().putAvailableVehicle(event.checkingData);
//     responseData.fold((error) {
//       emit(FetchAvailableVehicleErrorState(message: error.message));
//     }, (response) {
//       if (response['message'] == 'Success') {
//         emit(FetchVehicleSuccessState());
//       } else {
//         emit(FetchAvailableVehicleFailedState());
//       }
//     });
//   }

//   FutureOr<void> fetchVehicleEvent(
//       FetchVehicleEvent event, Emitter<VehicleState> emit) async {
//     emit(FetchAvailableVehicleLoadingState());
//     final responseData = await UserRepo().getAvailableVehicles();
//     responseData.fold((error) {
//       emit(FetchAvailableVehicleErrorState(message: error.message));
//     }, (response) {
//       final List vehicleList = response['vehicles'];
//       List<Vehicle> vehicleModel =
//           vehicleList.map((e) => Vehicle.fromJson(e)).toList();
//       emit(FetchAvailableVehicleSuccessState(vehicleList: vehicleModel));
//     });
//   }
// }