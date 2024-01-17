import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:flutter/material.dart';

class MyLoadingButton extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final bool isLoading;
  const MyLoadingButton(
      {super.key, this.onTap, required this.title, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap ?? () {},
        child: Container(
            height: 52,
            padding: const EdgeInsets.only(left: 20, right: 20),
            // margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: appbarColorU,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
                child: isLoading
                    ? Transform.scale(
                        scale: 0.5,
                        child: CircularProgressIndicator(color: mainColorU))
                    : Text(title, style: buttontextstyle))));
  }
}

class HalfSizeButton extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final bool isLoading;
  const HalfSizeButton(
      {super.key, this.onTap, required this.title, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    return GestureDetector(
        onTap: onTap ?? () {},
        child: Container(
            height: media.height / 17,
            width: media.width / 2.25,
            padding: const EdgeInsets.only(left: 20, right: 20),
            // margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: appbarColorU,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
                child: isLoading
                    ? Transform.scale(
                        scale: 0.5,
                        child: CircularProgressIndicator(color: mainColorU))
                    : Text(title, style: buttontextstyle))));
  }
}