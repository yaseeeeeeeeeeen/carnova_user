import 'package:cached_network_image/cached_network_image.dart';
import 'package:carnova_user/modals/booked_vehicle.dart';
import 'package:carnova_user/resources/api_urls/api_urls.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

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
        border: Border.all(color: borderSide),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: GestureDetector(
          child: Column(
        children: [
          Hero(
            tag: vehicledata.vehicleId.name,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: CachedNetworkImage(
                width: width / 1.5 - 10,
                height: heigth / 6,
                fit: BoxFit.cover,
                imageUrl:
                    "${ApiUrls.imagegettingUrl}${vehicledata.vehicleId.images[0]}",
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: shimmerbaseColor,
                  highlightColor: shimmerhighlightColor,
                  child: Container(
                    width: width / 1.5 - 10,
                    height: heigth / 6,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        image: DecorationImage(
                            image: NetworkImage(
                                "${ApiUrls.imagegettingUrl}${vehicledata.vehicleId.images[0]}"),
                            fit: BoxFit.cover)),
                  ),
                ),
              ),
            ),
          ),
          Container(
              color: mainColorU,
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
