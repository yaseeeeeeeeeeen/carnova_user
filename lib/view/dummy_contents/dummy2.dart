import 'package:carnova_user/modals/fetch_modal.dart';
import 'package:carnova_user/modals/vehicle_data._modal.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:carnova_user/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maps_launcher/maps_launcher.dart';

class CarAgentTileD extends StatelessWidget {
  const CarAgentTileD({super.key, required this.vehicledata});
  final VehicleDataModal vehicledata;
  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      height: heigth / 10,
      child: Center(
        child: ListTile(
          title: Text(
            "Roberto Carlos",
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
                    callAgent("8848917803");
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: heigth / 30,
                    child: SvgPicture.asset(imageU.phoneSvg,
                        height: heigth / 30, fit: BoxFit.contain),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    openMap("${vehicledata.name} Avalible Here");
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
            child: CircleAvatar(
              backgroundImage: AssetImage(imageU.profileDemo),
            ),
          ),
        ),
      ),
    );
  }
}

openMap(String messege) async {
  MapsLauncher.launchCoordinates(11.1557, 75.8912, messege);
}

callAgent(String number) async {
  await FlutterPhoneDirectCaller.callNumber(number);
}
