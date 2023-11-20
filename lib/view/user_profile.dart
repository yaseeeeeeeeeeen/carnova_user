import 'package:carnova_user/resources/components/profie_screen/profile_card.dart';
import 'package:carnova_user/resources/components/profie_screen/profile_screen_listtile.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:carnova_user/utils/appbar.dart';

import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.sizeOf(context).height;
    return Scaffold(
        backgroundColor: scaffoldBg,
        appBar: customAppBarU(context),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const ProfileCardWid(),
                const SizedBox(height: 10),
                const ProfileListtileToggle(text: "Dark Mode"),
                ProfileScreenListtile(text: "App info", isLogout: false),
                ProfileScreenListtile(
                    text: "Terms & Conditions", isLogout: false),
                ProfileScreenListtile(
                    text: "Privacy & Policy", isLogout: false),
                ProfileScreenListtile(text: "Help", isLogout: false),
                const Divider(),
                ProfileScreenListtile(text: "Clear App Data", isLogout: false),
                ProfileScreenListtile(text: "Sign Out", isLogout: true),
                Container()
              ],
            ),
          ),
        ));
  }
}
