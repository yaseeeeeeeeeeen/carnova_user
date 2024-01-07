import 'package:carnova_user/modals/booked_vehicle.dart';
import 'package:carnova_user/resources/api_urls/api_urls.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/cancle_bar.dart';
import 'package:carnova_user/resources/components/car_show_screen/car_details_card.dart';
import 'package:carnova_user/resources/components/car_show_screen/vehicle_images_wid.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:flutter/material.dart';
import 'package:carnova_user/resources/components/title_text_wid.dart';
import 'package:carnova_user/utils/appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class BookedVehiclesScreen extends StatelessWidget {
  BookedVehicle vehicle;
  BookedVehiclesScreen({super.key, required this.vehicle});
  @override
  Widget build(BuildContext context) {
    DateTime start = DateFormat('yyyy-MM-dd').parse(vehicle.startDate);
    String formattedStartDate = DateFormat('EEEE, MMMM d').format(start);
    List<String> cardetails = [
      vehicle.vehicleId.brand,
      vehicle.vehicleId.fuel,
      vehicle.vehicleId.transmission,
      "4.5"
      // vehicleData.rating.abs().toString()
    ];
    double heigth = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: scaffoldBg,
      bottomNavigationBar: CancleBookingButton(bookedVehicle: vehicle),
      appBar: customAppBarText(vehicle.vehicleId.name, context, null),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: heigth / 3.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                              "${ApiUrls.baseUrl}/${vehicle.vehicleId.images[0]}"),
                          fit: BoxFit.cover))),
              const SizedBox(height: 5),
              HomeTitles(titles: "Car Details"),
              const SizedBox(height: 10),
              CarDetailsCard(cardetails: cardetails),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: ListTile(
                  title: Text(
                    "Starting Date",
                    style: GoogleFonts.poppins(),
                  ),
                  trailing:
                      Text(formattedStartDate, style: GoogleFonts.poppins()),
                ),
              ),
              const SizedBox(height: 10),
              HomeTitles(titles: "More Images"),
              const SizedBox(height: 10),
              CarMoreImages(images: vehicle.vehicleId.images)
            ],
          ),
        ),
      ),
    );
  }
}
