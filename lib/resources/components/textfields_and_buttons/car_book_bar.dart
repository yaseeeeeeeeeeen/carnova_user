import 'package:carnova_user/modals/fetch_modal.dart';
import 'package:carnova_user/view/vehicle/booking/booking_confirm.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CarDataBottomBar extends StatelessWidget {
  CarDataBottomBar(
      {super.key,
      required this.price,
      required this.startDate,
      required this.endDate,
      required this.vehicle});
  String price;
  Vehicle vehicle;
  String startDate;
  String endDate;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        padding: const EdgeInsets.only(bottom: 0),
        child: Container(
          height: 80,
          color: appbarColorU.withOpacity(0.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("₹$price", style: style2),
                      Text("  Per Day",
                          style: GoogleFonts.poppins(
                              fontSize: 15, color: Colors.black54))
                    ]),
              ),
              const SizedBox(width: 30),
              ElevatedButton(
                  onPressed: () {
                    DateTime start =
                        DateFormat('EEEE, MMMM d, y').parse(startDate);
                    DateTime end = DateFormat('EEEE, MMMM d, y').parse(endDate);
                    String formattedStartDate =
                        DateFormat('yyyy-MM-dd').format(start);
                    String formattedEndDate =
                        DateFormat('yyyy-MM-dd').format(end);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PaymentScreen(
                            vehicle: vehicle,
                            startingDate: formattedStartDate,
                            endingDate: formattedEndDate)));
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.sizeOf(context).width / 2.2, 50),
                      backgroundColor: black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text("Book Now", style: style4))
            ],
          ),
        ));
  }
}

// ignore: must_be_immutable

