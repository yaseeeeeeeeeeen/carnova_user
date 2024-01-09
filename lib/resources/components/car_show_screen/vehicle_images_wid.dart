import 'package:carnova_user/resources/api_urls/api_urls.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
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
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Stack(
                        children: [
                          Container(
                              color: appbarColorU,
                              padding: const EdgeInsets.all(10),
                              height: MediaQuery.sizeOf(context).height / 3,
                              width: MediaQuery.sizeOf(context).width,
                              child: Image.network(
                                "${ApiUrls.baseUrl}/$i",
                                fit: BoxFit.cover,
                              )),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.keyboard_arrow_left,
                                  size: 25, color: mainColorU)),
                        ],
                      );
                    });
              },
              child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage("${ApiUrls.baseUrl}/$i"),
                          fit: BoxFit.cover))),
            );
          },
        );
      }).toList(),
    );
  }
}
