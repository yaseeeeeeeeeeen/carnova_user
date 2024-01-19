import 'package:carnova_user/data/get_it/get_it.dart';
import 'package:carnova_user/resources/api_urls/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/utils/profile_sheet.dart';
import 'package:carnova_user/view/home_screen.dart';

PreferredSizeWidget customAppBarU(context) {
  double height = MediaQuery.sizeOf(context).height;
  final logedUser = getLoggedInUser();
  return AppBar(
      actions: [
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return bottomsheetWid(height, context);
              },
            );
          },
          child: logedUser.profile!.isNotEmpty
              ? CircleAvatar(
                  backgroundImage:
                      NetworkImage("${ApiUrls.imagegettingUrl}${logedUser.profile}"),
                  backgroundColor: Colors.black,
                )
              : CircleAvatar(
                  backgroundImage: AssetImage(imageU.profileDemo),
                  backgroundColor: Colors.black,
                ),
        ),
        const SizedBox(width: 10),
      ],
      backgroundColor: appbarColorU,
      elevation: 0,
      title: SizedBox(
          width: 150,
          child: Image(image: AssetImage(imageU.appLogo), fit: BoxFit.cover)));
}

PreferredSizeWidget customAppBarText(
    String title, context, Function()? onPressed) {
  return AppBar(
      leading: IconButton(
          onPressed: onPressed ??
              () {
                Navigator.of(context).pop();
              },
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white)),
      backgroundColor: appbarColorU,
      centerTitle: true,
      elevation: 0,
      title: Text(title, style: GoogleFonts.poppins()));
}
