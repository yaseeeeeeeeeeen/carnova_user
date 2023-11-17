import 'package:flutter/material.dart';
import 'package:carnova_user/modals/vehicle_data._modal.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';

class ActivatedVehicle extends StatelessWidget {
  const ActivatedVehicle({super.key});

  @override
  Widget build(BuildContext context) {
    /// just added in vehicle data list
    final data = vehiclesData[0];
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
                      image: NetworkImage(data.coverPhoto), fit: BoxFit.cover)),
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
                      data.name,
                      style: activeVehicle1,
                    ),
                    Text(
                      "₹${data.price}",
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
