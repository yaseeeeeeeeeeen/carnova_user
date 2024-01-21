import 'package:carnova_user/blocs/vehicle_check/vehicle_check_bloc.dart';
import 'package:carnova_user/blocs/vehicle_check/vehicle_check_state.dart';
import 'package:carnova_user/data/get_it/get_it.dart';
import 'package:carnova_user/resources/components/home_screen/all_vehicles_tile.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/loading_button.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/utils/snack_bar.dart';
import 'package:carnova_user/view/vehicle/booking/all_vehicles_list.dart';
import 'package:carnova_user/view/vehicle/booking/booked_vehicle_scrn.dart';
import 'package:carnova_user/view/vehicle/welcome_screen.dart';
import 'package:flutter/material.dart';
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
    final upcomingVehicles = getBookedVehicleList();
    double heigth = MediaQuery.sizeOf(context).height;
    if (upcomingVehicles.isEmpty && activeVehicles.isEmpty) {
      /////////////////welcome screen//////////////////////////////////////
      return const WelcomeScreen();
    }
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
                HomeTitles(titles: "See Vehicles"),
                const SizedBox(height: 10),
                const AllVehiclesTileWid(),
                const SizedBox(height: 10),
                upcomingVehicles.isEmpty
                    ? const SizedBox()
                    : HomeTitles(titles: "Upcoming Bookings"),
                const SizedBox(height: 10),
                Container(
                  height: heigth / 4.3,
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => BookedVehiclesScreen(
                                    vehicle: upcomingVehicles[index])));
                          },
                          child: MostRatedDemo(
                              vehicledata: upcomingVehicles[index]),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 5),
                      itemCount: upcomingVehicles.length,
                      scrollDirection: Axis.horizontal),
                ),
              ],
            ),
          ),
        ));
  }
}
