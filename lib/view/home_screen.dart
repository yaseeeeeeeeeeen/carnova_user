import 'package:flutter/material.dart';
import 'package:carnova_user/modals/vehicle_data._modal.dart';
import 'package:carnova_user/resources/components/active_vehicle.dart';
import 'package:carnova_user/resources/components/map_tap.dart';
import 'package:carnova_user/resources/components/most_rated_wid.dart';
import 'package:carnova_user/resources/components/title_text_wid.dart';
import 'package:carnova_user/resources/constant/imagepath_user.dart';
import 'package:carnova_user/utils/appbar.dart';

UserSideImages imageU = UserSideImages();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.sizeOf(context).height;
    // double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        appBar: customAppBarU(context),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeTitles(titles: "Currently"),
                const ActivatedVehicle(),
                HomeTitles(titles: "Top Brands"),
                const MapTapWid(),
                HomeTitles(titles: "Most Rated"),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  height: heigth / 5.9,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return MostRatedDemo(vehicledata: vehiclesData[index]);
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 5),
                      itemCount: vehiclesData.length,
                      scrollDirection: Axis.horizontal),
                ),
                const SizedBox(height: 70)
              ],
            ),
          ),
        ));
  }
}
