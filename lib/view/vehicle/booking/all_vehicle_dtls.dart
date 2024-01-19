import 'package:carnova_user/modals/all_vehicle_list_modal.dart';
import 'package:carnova_user/resources/api_urls/api_urls.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/book_in_allvehicles.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:carnova_user/resources/components/car_show_screen/car_details_card.dart';
import 'package:carnova_user/resources/components/car_show_screen/vehicle_images_wid.dart';
import 'package:carnova_user/resources/components/title_text_wid.dart';
import 'package:carnova_user/utils/appbar.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../../resources/constant/text_styles.dart';

// ignore: must_be_immutable
class AllVehileDetaisScreen extends StatelessWidget {
  AllVehileDetaisScreen({
    super.key,
    required this.vehicleData,
  });
  Vehicle2 vehicleData;
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
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: scaffoldBg,
      bottomNavigationBar: AllVehicleScreenBottom(
          price: vehicleData.price.toInt().toString(), vehicle: vehicleData),
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
                  child: Container(
                      height: heigth / 3.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "${ApiUrls.imagegettingUrl}${vehicleData.images[0]}"),
                              fit: BoxFit.cover)))),
              const SizedBox(height: 5),
              HomeTitles(titles: "Car Details"),
              const SizedBox(height: 10),
              CarDetailsCard(cardetails: cardetails),
              const SizedBox(height: 10),
              HomeTitles(titles: "Contact"),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                height: heigth / 10,
                child: Center(
                  child: ListTile(
                    title: Text(
                      softWrap: false,
                      overflow: TextOverflow.visible,
                      vehicleData.createdBy.name,
                      style: caragentName,
                    ),
                    subtitle: const Text("Car Agent"),
                    trailing: SizedBox(
                      height: heigth / 12,
                      width: width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              callAgent(vehicleData.createdBy.phone.toString());
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: heigth / 30,
                              child: SvgPicture.asset(imageU.phoneSvg,
                                  height: heigth / 32, fit: BoxFit.contain),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              openMap("${vehicleData.name} Avalible Here",
                                  vehicleData.lat, vehicleData.long);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: heigth / 40,
                              child: SvgPicture.asset(imageU.gmapSvg,
                                  height: heigth / 26, fit: BoxFit.contain),
                            ),
                          )
                        ],
                      ),
                    ),
                    leading: SizedBox(
                      width: width / 8,
                      child: vehicleData.createdBy.profile.isNotEmpty
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "${ApiUrls.baseUrl}/${vehicleData.createdBy.profile}"),
                            )
                          : CircleAvatar(
                              backgroundImage: AssetImage(imageU.profileDemo),
                            ),
                    ),
                  ),
                ),
              ),
              // CarAgentTile(vehicledata: vehicleReal),
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

openMap(String messege, double lat, double long) async {
  MapsLauncher.launchCoordinates(lat, long, messege);
}

callAgent(String number) async {
  await FlutterPhoneDirectCaller.callNumber(number);
}
