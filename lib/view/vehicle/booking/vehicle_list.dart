import 'package:carnova_user/modals/fetch_modal.dart';
import 'package:carnova_user/resources/components/car_show_screen/car_tile_wid.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/custom_textfiled.dart';
import 'package:carnova_user/utils/appbar.dart';
import 'package:carnova_user/view/vehicle/booking/car_details_screen.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    locationController.text = location;
    return Scaffold(
        appBar: customAppBarText("Available", context, () {
          Navigator.of(context).pop();
        }),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: vehicles.isEmpty
              ? SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(
                      child: Text(
                      
                          "VEHICLES DOES NOT AVALIBLE IN \n $location",textAlign: TextAlign.center)),
                )
              : Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: CustomTextfield(
                                viewonly: false,
                                hint: "",
                                isSufix: false,
                                controller: locationController),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300)),
                          height: 55,
                          width: 60,
                          child: IconButton(
                              onPressed: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => MapScreen(
                                //         locationName: location, postion: position)));
                              },
                              icon: const Icon(Icons.location_on,
                                  color: Colors.black)),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final data = vehicles[index];
                          return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CarDataShow(
                                        endDate: enddate,
                                        startDate: startDate,
                                        vehicleData: data,
                                        isBooked: false)));
                              },
                              child: CarListTile(data: data));
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: vehicles.length)
                  ],
                ),
        ));
  }
}
