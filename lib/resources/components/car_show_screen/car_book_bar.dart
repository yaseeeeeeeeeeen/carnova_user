import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';

// ignore: must_be_immutable
class CarDataBottomBar extends StatelessWidget {
  CarDataBottomBar({super.key, required this.price});
  String price;
  // bool isBooked;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
          // isBooked
          //     ? ElevatedButton(
          //         onPressed: () {},
          //         style: ElevatedButton.styleFrom(
          //             fixedSize: const Size(130, 50),
          //             backgroundColor: Colors.black,
          //             shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(10))),
          //         child: Text("Cancel", style: style4))
          //     :
               ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(130, 50),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text("Book Now", style: style4))
        ],
      ),
    ));
  }
}
