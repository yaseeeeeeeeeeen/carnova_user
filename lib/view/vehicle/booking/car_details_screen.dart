import 'package:cached_network_image/cached_network_image.dart';
import 'package:carnova_user/modals/fetch_modal.dart';
import 'package:carnova_user/resources/api_urls/api_urls.dart';
import 'package:carnova_user/resources/components/car_show_screen/agent_tile.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:flutter/material.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/car_book_bar.dart';
import 'package:carnova_user/resources/components/car_show_screen/car_details_card.dart';
import 'package:carnova_user/resources/components/car_show_screen/vehicle_images_wid.dart';
import 'package:carnova_user/resources/components/title_text_wid.dart';
import 'package:carnova_user/utils/appbar.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class CarDataShow extends StatelessWidget {
  CarDataShow(
      {super.key,
      required this.vehicleData,
      required this.isBooked,
      required this.startDate,
      required this.endDate});
  Vehicle vehicleData;
  bool isBooked;
  String startDate;
  String endDate;
  @override
  Widget build(BuildContext context) {
    List<String> cardetails = [
      vehicleData.brand,
      vehicleData.fuel,
      vehicleData.seat.toString(),
      vehicleData.transmission,
      ""
    ];
    double heigth = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: scaffoldBg,
      bottomNavigationBar: CarDataBottomBar(
          price: vehicleData.price.toInt().toString(),
          vehicle: vehicleData,
          startDate: startDate,
          endDate: endDate),
      appBar: customAppBarText(vehicleData.name, context, null),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                  tag: vehicleData.name,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      height: heigth / 3.8,
                      fit: BoxFit.cover,
                      imageUrl:
                          "${ApiUrls.imagegettingUrl}${vehicleData.images[0]}",
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: shimmerbaseColor,
                        highlightColor: shimmerhighlightColor,
                        child: Container(
                            height: heigth / 3.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(url),
                                    fit: BoxFit.cover))),
                      ),
                    ),
                  )),
              const SizedBox(height: 5),
              HomeTitles(titles: "Car Details"),
              const SizedBox(height: 10),
              CarDetailsCard(cardetails: cardetails),
              const SizedBox(height: 10),
              HomeTitles(titles: "Contact"),
              CarAgentTile(vehicledata: vehicleData),
              const SizedBox(height: 10),
              HomeTitles(titles: "More Images"),
              const SizedBox(height: 10),
              CarMoreImages(images: vehicleData.images)
            ],
          ),
        ),
      ),
    );
  }
}
