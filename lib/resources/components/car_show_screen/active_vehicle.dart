import 'package:cached_network_image/cached_network_image.dart';
import 'package:carnova_user/modals/booked_vehicle.dart';
import 'package:carnova_user/resources/api_urls/api_urls.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:flutter/material.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ActivatedVehicle extends StatelessWidget {
  ActivatedVehicle({super.key, required this.data});
  BookedVehicle data;
  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.sizeOf(context).height;
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: mainColorU,
            border: Border.all(color: borderSide, width: 1)),
        height: heigth / 3,
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              height: heigth / 4.5,
              imageUrl: "${ApiUrls.imagegettingUrl}${data.vehicleId.images[0]}",
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: shimmerbaseColor,
                highlightColor: shimmerhighlightColor,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: black,
                        image: DecorationImage(
                            image: NetworkImage(url), fit: BoxFit.cover)),
                    height: heigth / 4.5),
              ),
            ),
          ),
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
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2.2,
                      child: Text(
                        data.vehicleId.name,
                        overflow: TextOverflow.ellipsis,
                        style: activeVehicle1,
                      ),
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
