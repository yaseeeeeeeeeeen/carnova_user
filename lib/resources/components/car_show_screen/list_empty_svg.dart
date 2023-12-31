import 'package:carnova_user/resources/components/textfields_and_buttons/loading_button.dart';
import 'package:carnova_user/utils/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListIsEmpty extends StatelessWidget {
  const ListIsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Center(
        child: Column(
      children: [
        SizedBox(
          height: heigth / 2,
          width: width / 1.5,
          child: SvgPicture.asset("assets/svg/Car rental-amico (1).svg"),
        ),
        MyLoadingButton(
          title: "Unlock Your Ride",
          isLoading: false,
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => CustomNavBar(index: 1)),
                (route) => false);
          },
        )
      ],
    ));
  }
}
