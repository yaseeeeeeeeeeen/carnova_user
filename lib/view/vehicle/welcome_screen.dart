import 'package:carnova_user/resources/components/home_screen/all_vehicles_tile.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:carnova_user/utils/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: customAppBarU(context),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: size.height / 2.8,
                width: size.width / 1,
                child: SvgPicture.asset("assets/svg/Order ride-amico.svg"),
              ),
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                      "Drive into a world of possibilities with Carnova. Your journey starts here.",
                      textAlign: TextAlign.center,
                      style: activeVehicle2)),
              const AllVehiclesTileWid(),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
