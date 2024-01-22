import 'package:carnova_user/modals/fetch_modal.dart';
import 'package:carnova_user/resources/api_urls/api_urls.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CarListTile extends StatelessWidget {
  CarListTile({super.key, required this.data});
  Vehicle data;
  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300)),
      height: heigth / 7.3,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Hero(
          tag: data.name,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("${ApiUrls.baseUrl}/${data.images[0]}"),
                    fit: BoxFit.cover),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10))),
            width: width / 2.4,
          ),
        ),
        Container(
            padding: const EdgeInsets.only(right: 10),
            width: width / 2,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  Text(data.brand.toUpperCase(),
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 13)),
                  Text(data.transmission,
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 13)),
                ]))
      ]),
    );
  }
}
