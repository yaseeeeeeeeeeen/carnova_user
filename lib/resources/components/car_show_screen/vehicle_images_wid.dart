import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarMoreImages extends StatelessWidget {
  const CarMoreImages({super.key, required this.images});
  final List images;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          height: MediaQuery.sizeOf(context).height / 5, autoPlay: true),
      items: images.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(i), fit: BoxFit.cover)));
          },
        );
      }).toList(),
    );
  }
}
