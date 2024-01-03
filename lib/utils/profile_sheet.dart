import 'package:carnova_user/data/get_it/get_it.dart';
import 'package:carnova_user/resources/api_urls/api_urls.dart';
import 'package:carnova_user/view/login_signup/change_password.dart';
import 'package:flutter/material.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:carnova_user/view/home_screen.dart';

import '../resources/components/profile_tile_button.dart';

Widget bottomsheetWid(double height, context) {
  final logedUser = getLoggedInUser();
  return Container(
    padding: const EdgeInsets.all(5),
    child: ListView(shrinkWrap: true, children: [
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
                child: logedUser.profile!.isNotEmpty
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(
                            "${ApiUrls.baseUrl}/${logedUser.profile}"),
                        radius: 45,
                        backgroundColor: Colors.black)
                    : CircleAvatar(
                        backgroundImage: AssetImage(imageU.profileDemo),
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
                      Text(logedUser.name.toUpperCase(),
                          style: style5, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 10),
                      Text(logedUser.email,
                          overflow: TextOverflow.ellipsis, style: style6),
                    ]),
              )
            ],
          )),
      // ListTileToggle(text: "Dark Mode"),

      GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChangePasswordScreen()));
          },
          child: ListTilePwid(title: "Change Password")),
      ListTilePwid(title: "Clear data"),
      ListTilePwid(title: "Help"),
      ListTilePwid(title: "About"),
      const SizedBox(height: 5)
    ]),
  );
}
