import 'package:carnova_user/blocs/vehicle_check/vehicle_check_bloc.dart';
import 'package:carnova_user/blocs/vehicle_check/vehicle_check_state.dart';
import 'package:carnova_user/data/get_it/get_it.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/loading_button.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/view/vehicle/all_vehicles_list.dart';
import 'package:flutter/material.dart';
import 'package:carnova_user/modals/vehicle_data._modal.dart';
import 'package:carnova_user/resources/components/car_show_screen/active_vehicle.dart';
import 'package:carnova_user/resources/components/map_tap.dart';
import 'package:carnova_user/resources/components/most_rated_wid.dart';
import 'package:carnova_user/resources/components/title_text_wid.dart';
import 'package:carnova_user/resources/constant/imagepath_user.dart';
import 'package:carnova_user/utils/appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

UserSideImages imageU = UserSideImages();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final activeVehicles = getActiveVehicles();
    double heigth = MediaQuery.sizeOf(context).height;
    // double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: scaffoldBg,
        appBar: customAppBarU(context),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                activeVehicles.isEmpty
                    ? const SizedBox()
                    : HomeTitles(titles: "Active"),
                activeVehicles.isEmpty
                    ? const SizedBox()
                    : const SizedBox(height: 10),
                activeVehicles.isEmpty ? const SizedBox() : ActivatedVehicle(),
                const SizedBox(height: 10),
                HomeTitles(titles: "Top Brands"),
                const SizedBox(height: 10),
                const MapTapWid(),
                const SizedBox(height: 10),
                BlocConsumer<VehicleCheckBloc, VehicleCheckState>(
                  listener: (context, state) {
                    if (state is AllVehiclefetchedState) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AllVehiclesList()));
                    }
                  },
                  builder: (context, state) {
                    return MyLoadingButton(
                        title: "VIEW ALL VEHICLES",
                        isLoading: state is VehicleCheckLoading,
                        onTap: () {
                          context
                              .read<VehicleCheckBloc>()
                              .add(GetAllVehicles());
                        });
                  },
                ),
                const SizedBox(height: 10),
                HomeTitles(titles: "Upcoming Bookings"),
                const SizedBox(height: 10),
                Container(
                  height: heigth / 4.3,
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return MostRatedDemo(vehicledata: vehiclesData[index]);
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 5),
                      itemCount: 3,
                      scrollDirection: Axis.horizontal),
                ),
              ],
            ),
          ),
        ));
  }
}
