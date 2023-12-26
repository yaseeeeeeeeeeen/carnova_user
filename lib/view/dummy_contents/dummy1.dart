import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/view/dummy_contents/dummy2.dart';
import 'package:carnova_user/view/dummy_contents/dummy3.dart';
import 'package:flutter/material.dart';
import 'package:carnova_user/modals/vehicle_data._modal.dart';
import 'package:carnova_user/resources/components/car_show_screen/car_book_bar.dart';
import 'package:carnova_user/resources/components/car_show_screen/car_details_card.dart';
import 'package:carnova_user/resources/components/car_show_screen/vehicle_images_wid.dart';
import 'package:carnova_user/resources/components/title_text_wid.dart';
import 'package:carnova_user/utils/appbar.dart';

// ignore: must_be_immutable
class CarDataShowD extends StatelessWidget {
  CarDataShowD({super.key, required this.vehicleData, required this.isBooked});
  VehicleDataModal vehicleData;
  bool isBooked;
  @override
  Widget build(BuildContext context) {
    List<String> cardetails = [
      vehicleData.brand,
      vehicleData.fuel,
      vehicleData.transmission,
     "4.5"
     // vehicleData.rating.abs().toString()
    ];
    double heigth = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: scaffoldBg,
      bottomNavigationBar: CarDataBottomBar(price: vehicleData.price.toString()),
      appBar: customAppBarText(vehicleData.name, context,null),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                  tag: vehicleData.name,
                  child: Container(
                      height: heigth / 3.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(vehicleData.images[0]),
                              fit: BoxFit.cover)))),
              const SizedBox(height: 5),
              HomeTitles(titles: "Car Details"),
              const SizedBox(height: 10),
              CarDetailsCard(cardetails: cardetails),
              const SizedBox(height: 10),
              HomeTitles(titles: "Contact"),
               CarAgentTileD(vehicledata: vehicleData),
              const SizedBox(height: 10),
              HomeTitles(titles: "More Images"),
              const SizedBox(height: 10),
              CarMoreImagesD(images: vehicleData.images)
            ],
          ),
        ),
      ),
    );
  }
}
