import 'package:carnova_user/resources/components/textfields_and_buttons/loading_button.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:carnova_user/utils/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListIsEmpty extends StatelessWidget {
  const ListIsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          SizedBox(
            height: heigth / 2,
            width: width / 1.5,
            child: SvgPicture.asset("assets/svg/Car rental-amico (1).svg"),
          ),
          Text(
              "Zero bookings, infinite possibilities! Your car rental adventure is just a click away",
              textAlign: TextAlign.center,
              style: cardtitle),
          const SizedBox(height: 15),
          MyLoadingButton(
            title: "Unlock Your Ride",
            isLoading: false,
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => CustomNavBar(index: 1)),
                  (route) => false);
            },
          )
        ],
      ),
    ));
  }
}

// ignore: must_be_immutable
class VehicleLocationEmpty extends StatelessWidget {
  VehicleLocationEmpty({super.key, required this.location});
  String location;
  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(
            height: heigth / 2.5,
            width: width / 1.5,
            child: SvgPicture.asset("assets/svg/address-not-css.svg"),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Oops! No cars in ",
                  style: cardtitle,
                ),
                TextSpan(text: "'$location'", style: highlightLocation),
                TextSpan(
                  text: " they took a detour. Let's find a ride nearby!",
                  style: cardtitle,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ));
  }
}
