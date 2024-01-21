import 'package:carnova_user/blocs/vehicle_check/vehicle_check_bloc.dart';
import 'package:carnova_user/blocs/vehicle_check/vehicle_check_state.dart';
import 'package:carnova_user/resources/components/map_tap.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/loading_button.dart';
import 'package:carnova_user/utils/snack_bar.dart';
import 'package:carnova_user/view/vehicle/booking/all_vehicles_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllVehiclesTileWid extends StatelessWidget {
  const AllVehiclesTileWid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MapTapWid(),
        const SizedBox(height: 10),
        BlocConsumer<VehicleCheckBloc, VehicleCheckState>(
          listener: (context, state) {
            if (state is AllVehiclefetchedState) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      AllVehiclesList(datas: state.allVehicles)));
            } else if (state is VehilceFetchingFailed) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(customSnackbar(context, false, state.messege));
            }
          },
          builder: (context, state) {
            return MyLoadingButton(
                title: "VIEW ALL VEHICLES",
                isLoading: state is VehicleCheckAllVehicleLoading,
                onTap: () {
                  context.read<VehicleCheckBloc>().add(GetAllVehicles());
                });
          },
        ),
      ],
    );
  }
}
