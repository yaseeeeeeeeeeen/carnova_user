import 'package:carnova_user/blocs/vehicle_check/vehicle_check_bloc.dart';
import 'package:carnova_user/blocs/vehicle_check/vehicle_check_state.dart';
import 'package:carnova_user/modals/fetch_modal.dart';
import 'package:carnova_user/resources/components/car_show_screen/car_tile_wid.dart';
import 'package:carnova_user/resources/components/car_show_screen/list_empty_svg.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/my_textfield.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/utils/appbar.dart';
import 'package:carnova_user/utils/bottom_nav_bar.dart';
import 'package:carnova_user/view/vehicle/booking/car_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class FetchedVehicles extends StatelessWidget {
  List<Vehicle> vehicles;
  String location;
  Position position;
  String startDate;
  String enddate;
  FetchedVehicles(
      {super.key,
      required this.vehicles,
      required this.location,
      required this.startDate,
      required this.enddate,
      required this.position});
  TextEditingController locationController = TextEditingController();
  List<Map<String, dynamic>> locationList = [];
  @override
  Widget build(BuildContext context) {
    locationController.text = location;
    return Scaffold(
        backgroundColor: scaffoldBg,
        appBar: customAppBarText("Available", context, () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => CustomNavBar(index: 1)),
              (route) => false);
        }),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          height: 55,
                          margin: const EdgeInsets.only(right: 10),
                          child:
                              BlocListener<VehicleCheckBloc, VehicleCheckState>(
                            listener: (context, state) {},
                            child: MyTextField(
                                onFieldSubmitted: (p0) async {
                                  context.read<VehicleCheckBloc>().add(
                                      LocationSearchButtonClicked(
                                          location: locationController.text));
                                },
                                controller: locationController,
                                hintText: "Search Your Location",
                                obscureText: false,
                                isPassword: false,
                                validation: (value) => null),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: scaffoldBg,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: borderSide)),
                        height: 57,
                        width: 55,
                        child: IconButton(
                            onPressed: () {
                              context.read<VehicleCheckBloc>().add(
                                  CheckAvaliblityButtonClicked(
                                      startDate: startDate,
                                      endDate: enddate,
                                      location: locationController.text));
                            },
                            icon: Icon(Icons.search, color: black)),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<VehicleCheckBloc, VehicleCheckState>(
                    builder: (context, state) {
                      if (state is LocationSearchedSuccsess) {
                        locationList = state.locationList;
                        return ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: mainColorU,
                                    border: Border.all(color: borderSide),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 60,
                                child: ListTile(
                                  onTap: () {
                                    location =
                                        state.locationList[index]["placeName"];
                                    locationController.text =
                                        state.locationList[index]["placeName"];
                                  },
                                  title: Text(
                                      state.locationList[index]["placeName"]),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: state.locationList.length);
                      } else if (state is VehicleCheckLoading) {
                        return Center(
                            child: CircularProgressIndicator(color: black));
                      } else {
                        return vehicles.isNotEmpty
                            ? ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final data = vehicles[index];
                                  return InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CarDataShow(
                                                        endDate: enddate,
                                                        startDate: startDate,
                                                        vehicleData: data,
                                                        isBooked: false)));
                                      },
                                      child: CarListTile(data: data));
                                },
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                                itemCount: vehicles.length)
                            : SizedBox(
                                width: double.infinity,
                                child: Center(
                                    child: VehicleLocationEmpty(
                                        location: location)),
                              );
                      }
                    },
                  ),
                  const SizedBox(height: 50)
                ]))));
  }
}
