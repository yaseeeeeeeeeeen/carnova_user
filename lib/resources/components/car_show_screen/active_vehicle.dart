import 'package:carnova_user/data/get_it/get_it.dart';
import 'package:carnova_user/resources/api_urls/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';

class ActivatedVehicle extends StatelessWidget {
  ActivatedVehicle({super.key});
  final vehicles = getActiveVehicles();
  @override
  Widget build(BuildContext context) {
    /// just added in vehicle data list
    final data = vehicles[0];
    ////////////////////////////////////////////////////////////////
    double heigth = MediaQuery.sizeOf(context).height;
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300, width: 1)),
        height: heigth / 3,
        child: Column(children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black,
                  image: DecorationImage(
                      image: NetworkImage(
                          "${ApiUrls.imagegettingUrl}${data.vehicleId.images[0]}"),
                      fit: BoxFit.cover)),
              height: heigth / 4.5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                height: heigth / 12,
                width: MediaQuery.sizeOf(context).width / 1.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      data.vehicleId.name,
                      style: activeVehicle1,
                    ),
                    Text(
                      "₹${data.grandTotal}",
                      style: activeVehicle2,
                    ),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 10, left: 20),
                  child: const Row(children: [
                    Icon(Icons.circle, color: Colors.green, size: 15),
                    SizedBox(width: 5),
                    Text("ACTIVE ")
                  ]))
            ],
          )
        ]));
  }
}
