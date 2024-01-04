import 'package:carnova_user/data/get_it/get_it.dart';
import 'package:carnova_user/modals/vehicle_data._modal.dart';
import 'package:carnova_user/resources/api_urls/api_urls.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:carnova_user/view/vehicle/booked_vehicle_scrn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CarUpcomingListTile extends StatelessWidget {
  CarUpcomingListTile({super.key});
  //// addd upcoming booked vehiles list
  final vehicles = getBookedVehicleList();
  final vehiclesinfo = vehiclesData;

  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      color: scaffoldBg,
      padding: const EdgeInsets.all(10),
      height: heigth,
      child: vehicles.isEmpty
          ? const Center(child: Text("VEhicle List is Empty"))
          : ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final data = vehicles[index];
                DateTime parsedDate = DateTime.parse(data.startDate);
                String formattedDate =
                    DateFormat('MMMM d, y').format(parsedDate);
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            BookedVehiclesScreen(vehicle: data)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300)),
                    height: heigth / 7.3,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "${ApiUrls.baseUrl}/${data.vehicleId.images[0]}"),
                                    fit: BoxFit.cover),
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10))),
                            width: width / 2.4,
                          ),
                          Container(
                              padding: const EdgeInsets.only(right: 10),
                              width: width / 2,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: width / 3,
                                          child: Text(data.vehicleId.name,
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                              style: tabcardtext1),
                                        ),
                                        Text("₹${data.grandTotal}",
                                            overflow: TextOverflow.fade,
                                            style: tabcardtext1)
                                      ],
                                    ),
                                    Text(data.vehicleId.brand,
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 13)),
                                    Row(
                                      children: [
                                        const Icon(
                                            Icons.calendar_today_outlined,
                                            size: 15,
                                            color: Colors.black),
                                        const SizedBox(width: 5),
                                        Text(
                                          formattedDate,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on,
                                            size: 15, color: Colors.grey),
                                        const SizedBox(width: 5),
                                        SizedBox(
                                          width: width / 2.4,
                                          child: Text(data.pickup,
                                              overflow: TextOverflow.fade,
                                              style: tileLocation),
                                        )
                                      ],
                                    )
                                  ]))
                        ]),
                  ),
                );
              },
              itemCount: vehicles.length),
    );
  }
}
