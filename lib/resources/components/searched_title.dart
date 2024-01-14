import 'package:cached_network_image/cached_network_image.dart';
import 'package:carnova_user/modals/all_vehicle_list_modal.dart';
import 'package:carnova_user/resources/api_urls/api_urls.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchTileWid extends StatelessWidget {
  SearchTileWid({super.key, required this.data});
  Vehicle2 data;
  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      decoration: BoxDecoration(
          color: mainColorU,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderSide)),
      height: heigth / 7.3,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Hero(
          tag: data.name,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10), topLeft: Radius.circular(10)),
            child: CachedNetworkImage(
              imageUrl: "${ApiUrls.baseUrl}/${data.images[0]}",
              width: width / 2.6,
              height: heigth / 7.2,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey.shade500,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "${ApiUrls.baseUrl}/${data.images[0]}"),
                          fit: BoxFit.cover),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                  width: width / 2.6,
                ),
              ),
            ),
          ),
        ),
        Container(
            padding: const EdgeInsets.only(right: 15),
            width: width / 2,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(data.name,
                              style: tabcardtext1,
                              overflow: TextOverflow.ellipsis)),
                      Text("₹${data.price}", style: tabcardtext1)
                    ],
                  ),
                  Text("${data.brand.toUpperCase()} (${data.model})",
                      style: style6),
                  Text("Owner : ${data.createdBy.name}", style: style6)
                ]))
      ]),
    );
  }
}
