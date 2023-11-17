import 'package:carnova_user/resources/constant/colors_userside.dart';
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
        backgroundColor: scaffoldBg,
        appBar: customAppBarU(context),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                HomeTitles(titles: "Active"),
                const SizedBox(height: 10),
                const ActivatedVehicle(),
                const SizedBox(height: 10),
                HomeTitles(titles: "Top Brands"),
                const SizedBox(height: 10),
                const MapTapWid(),
                const SizedBox(height: 10),
                HomeTitles(titles: "Most Rated"),
                const SizedBox(height: 10),
                Container(
                  height: heigth / 4.3,
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
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
              ],
            ),
          ),
        ));
  }
}
