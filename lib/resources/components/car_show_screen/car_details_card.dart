import 'package:carnova_user/utils/snack_bar.dart';
import 'package:flutter/material.dart';
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
      "assets/svg/seat-belt-svgrepo-com.svg",
      "assets/svg/gearshift-gear-svgrepo-com.svg",
      // "assets/svg/star-svgrepo-com.svg"
    ];
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          ////// This Feature is Pending Adding time 4 Change to Svg length-1   /////////
          if (index == 4) {
            return GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(customSnackbar(
                    context, true, "This Feature Avalible Soon"));
                // showModalBottomSheet(
                //   isScrollControlled: true,
                //   context: context,
                //   builder: (context) {
                //     return Container(
                //       padding: const EdgeInsets.all(10),
                //       color: appbarColorU,
                //       height: MediaQuery.sizeOf(context).height / 1.7,
                //       child: SingleChildScrollView(
                //         physics: const BouncingScrollPhysics(),
                //         child: Column(
                //           children: [
                //             Text("Reviews", style: reviweTitle),
                //             const ReviewCommentTile(
                //                 review: "its very friendly to use",
                //                 rating: "4.5"),
                //             const ReviewCommentTile(
                //                 review: "Good coundition", rating: "4.2")
                //           ],
                //         ),
                //       ),
                //     );
                //   },
                // );
              },
              child: Stack(
                children: [
                  Container(
                      margin: const EdgeInsets.all(2),
                      width: 90,
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
                                    fit: BoxFit.cover, height: 25, width: 25),
                                Text(cardetails[index], style: style7)
                              ],
                            ),
                            Text("Rating", style: ratingtitle)
                          ],
                        ),
                      )),
                  //////////////////////// Coming soon feature/////////////////
                  Container(
                      margin: const EdgeInsets.all(2),
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: appbarColorU.withOpacity(0.6)),
                      child: Center(
                          child: Icon(
                        Icons.lock,
                        size: 30,
                        color: mainColorU,
                      ))),
                ],
              ),
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
                  SizedBox(
                    height: 20,
                    width: 100,
                    child: index == svgPath.length - 2
                        ? Text("${cardetails[index]} SEAT",
                            style: style5,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center)
                        : Text(cardetails[index],
                            style: style5,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center),
                  )
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
