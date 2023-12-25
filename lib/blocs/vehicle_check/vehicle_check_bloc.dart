import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:carnova_user/utils/functions/location_picker.dart';
import 'package:geolocator/geolocator.dart';

part 'vehicle_check_event.dart';
part 'vehicle_check_state.dart';

class VehicleCheckBloc extends Bloc<VehicleCheckEvent, VehicleCheckState> {
  VehicleCheckBloc() : super(VehicleCheckInitial()) {
    on<CheckAvaliblityButtonClicked>(checkAvaliblityButtonClicked);
  }

  FutureOr<void> checkAvaliblityButtonClicked(
      CheckAvaliblityButtonClicked event,
      Emitter<VehicleCheckState> emit) async {
    emit(VehicleCheckLoading());
    Position? currentLoaction =
        await LocationPickerFunction().getCurrentLocation();
    if (currentLoaction != null) {
      print("${currentLoaction.latitude.toString()}");
      String? address =
          await LocationPickerFunction().getAddress(currentLoaction);
      if (address != null) {
        print(address);
        emit(UserLoactionPickedSuccsessState(
            loction: address,
            lat: currentLoaction.latitude,
            long: currentLoaction.longitude));
      } else {
        emit(LocationPickingFailed());
      }
    } else {
      emit(LocationPickingFailed());
    }
  }
}
