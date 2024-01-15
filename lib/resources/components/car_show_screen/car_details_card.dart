import 'package:flutter/material.dart';

import 'package:carnova_user/resources/components/car_show_screen/review_tile.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarDetailsCard extends StatelessWidget {
  const CarDetailsCard({super.key, required this.cardetails});
  final List cardetails;
  @override
  Widget build(BuildContext context) {
    List<String> svgPath = [
      "assets/svg/car-steering-wheel-svgrepo-com.svg",
      "assets/svg/fuel-svgrepo-com.svg",
      "assets/svg/gearshift-gear-svgrepo-com.svg",
      "assets/svg/seat-belt-svgrepo-com.svg",
      "assets/svg/star-svgrepo-com.svg"
    ];
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          if (index == svgPath.length - 1) {
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      color: appbarColorU,
                      height: MediaQuery.sizeOf(context).height / 1.7,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Text("Reviews", style: reviweTitle),
                            const ReviewCommentTile(
                                review: "its very friendly to use",
                                rating: "4.5"),
                            const ReviewCommentTile(
                                review: "Good coundition", rating: "4.2")
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                  margin: const EdgeInsets.all(2),
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: appbarColorU),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(svgPath[index],
                                fit: BoxFit.cover, height: 30, width: 30),
                            Text(cardetails[index], style: style7)
                          ],
                        ),
                        Text("Rating", style: ratingtitle)
                      ],
                    ),
                  )),
            );
          } else {
            return Container(
              margin: const EdgeInsets.all(2),
              width: 100,
              decoration: BoxDecoration(
                  border: Border.all(color: borderSide),
                  borderRadius: BorderRadius.circular(10),
                  color: mainColorU),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(svgPath[index],
                      height: 25, width: 25, fit: BoxFit.cover),
                  const SizedBox(height: 5),
                  index == svgPath.length - 2
                      ? Text("${cardetails[index]} SEAT", style: style5)
                      : Text(cardetails[index], style: style5)
                ],
              ),
            );
          }
        },
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: svgPath.length,
      ),
    );
  }
}
