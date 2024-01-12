import 'package:carnova_user/modals/booked_vehicle.dart';
import 'package:carnova_user/resources/api_urls/api_urls.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class MostRatedDemo extends StatelessWidget {
  MostRatedDemo({super.key, required this.vehicledata});
  // VehicleDataModal vehicledata;
  BookedVehicle vehicledata;
  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = DateTime.parse(vehicledata.startDate);
    String formattedDate = DateFormat('MMMM d, y').format(parsedDate);
    double heigth = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: GestureDetector(
          child: Column(
        children: [
          Hero(
            tag: vehicledata.vehicleId.name,
            child: Container(
              width: width / 1.5 - 10,
              height: heigth / 6,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  image: DecorationImage(
                      image: NetworkImage(
                          "${ApiUrls.baseUrl}/${vehicledata.vehicleId.images[0]}"),
                      fit: BoxFit.cover)),
            ),
          ),
          Container(
              color: Colors.white,
              width: width / 1.5 - 10,
              height: heigth / 16,
              padding: const EdgeInsets.all(5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(vehicledata.vehicleId.name, style: cardtitle),
                        Text("₹${vehicledata.grandTotal}", style: cardtitle),
                      ],
                    ),
                    SizedBox(
                        width: 100,
                        child: Text(
                          formattedDate,
                          style: mailstyle,
                        ))
                  ]))
        ],
      )),
    );
  }
}
