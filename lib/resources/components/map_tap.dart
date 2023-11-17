import 'package:carnova_user/view/home_screen.dart';
import 'package:flutter/material.dart';

class MapTapWid extends StatelessWidget {
  const MapTapWid({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> brandLogos = [
      imageU.carLogo1,
      imageU.carLogo2,
      imageU.carLogo3,
      imageU.carLogo4
    ];
    double heigth = MediaQuery.sizeOf(context).height;
    return Container(
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        height: heigth / 9,
        width: double.infinity,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1)),
                  width: MediaQuery.sizeOf(context).width / 4.6,
                  child: Center(
                    child: Image.asset(brandLogos[index]),
                  ),
                ),
            separatorBuilder: (context, index) => const SizedBox(width: 5),
            itemCount: 4));
  }
}
