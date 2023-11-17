import 'package:flutter/material.dart';
import 'package:carnova_user/resources/components/profile_tile_button.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:carnova_user/view/home_screen.dart';

Widget bottomsheetWid(double height, context) {
  return Container(
    padding: const EdgeInsets.all(5),
    height: height / 1.7,
    child: Column(children: [
      Container(
          padding: const EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(imageU.profileBg), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 1),
            color: Colors.white,
          ),
          height: height / 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 47,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                    backgroundImage: AssetImage(imageU.userPhoto),
                    radius: 45,
                    backgroundColor: Colors.black),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width / 1.6,
                padding: const EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Muhammed Yaseen",
                          style: style5, overflow: TextOverflow.ellipsis),
                      Text("muahhammedyaseen@gmail.com",
                          overflow: TextOverflow.ellipsis, style: style6),
                    ]),
              )
            ],
          )),
      ListTileToggle(text: "Dark Mode"),
      ListTilePwid(
          title: "Change Password",
          icon: const Icon(Icons.lock_clock_outlined, color: Colors.black)),
      ListTilePwid(
          title: "Clear data",
          icon: const Icon(Icons.delete_forever_outlined, color: Colors.black)),
      ListTilePwid(
          title: "Help",
          icon: const Icon(Icons.help_center_outlined, color: Colors.black)),
      ListTilePwid(
          title: "About",
          icon: const Icon(Icons.info_outline_rounded, color: Colors.black)),
    ]),
  );
}
