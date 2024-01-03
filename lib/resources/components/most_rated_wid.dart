import 'package:carnova_user/modals/vehicle_data._modal.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:carnova_user/view/vehicle/car_details_screen.dart';
import 'package:carnova_user/view/dummy_contents/dummy1.dart';
import 'package:carnova_user/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MostRatedDemo extends StatelessWidget {
  MostRatedDemo({super.key, required this.vehicledata});
  VehicleDataModal vehicledata;
  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CarDataShowD(vehicleData: vehicledata,isBooked: false))),
          child: Column(
            children: [
              Hero(
                tag: vehicledata.name,
                child: Container(
                  width: width / 1.5 - 10,
                  height: heigth / 6,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      image: DecorationImage(
                          image: NetworkImage(vehicledata.coverPhoto),
                          fit: BoxFit.cover)),
                ),
              ),
              Container(
                  color: Colors.white,
                  width: width / 1.5 - 10,
                  height: heigth / 16,
                  padding: const EdgeInsets.all(5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(vehicledata.name, style: cardtitle),
                            Text("₹${vehicledata.price}", style: cardtitle),
                          ],
                        ),
                        SizedBox(
                            height: 20,
                            width: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SvgPicture.asset(
                                  imageU.startsvg,
                                  height: 15,
                                ),
                                Text(
                                  vehicledata.rating.toString(),
                                  style: GoogleFonts.adamina(
                                      color: Colors.black38),
                                )
                              ],
                            ))
                      ]))
            ],
          )),
    );
  }
}
