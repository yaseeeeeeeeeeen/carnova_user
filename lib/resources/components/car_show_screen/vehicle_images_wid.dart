import 'package:cached_network_image/cached_network_image.dart';
import 'package:carnova_user/resources/api_urls/api_urls.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/utils/appbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ImagePreviewWid(imagePath: "${ApiUrls.baseUrl}/$i")));
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: "${ApiUrls.baseUrl}/$i",
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: shimmerbaseColor,
                      highlightColor: shimmerhighlightColor,
                      child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage("${ApiUrls.baseUrl}/$i"),
                                  fit: BoxFit.cover))),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

// ignore: must_be_immutable
class ImagePreviewWid extends StatelessWidget {
  ImagePreviewWid({super.key, required this.imagePath});
  String imagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColorU,
      appBar: customAppBarText("IMAGE PREVIEW", context, () {
        Navigator.of(context).pop();
      }),
      body: Center(
        child: Image(image: NetworkImage(imagePath)),
      ),
    );
  }
}
