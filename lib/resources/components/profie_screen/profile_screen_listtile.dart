import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileScreenListtile extends StatelessWidget {
  ProfileScreenListtile(
      {super.key, required this.text, required this.isLogout});
  final String text;
  bool isLogout = false;
  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.sizeOf(context).height;
    return SizedBox(
        height: heigth / 18,
        width: double.infinity,
        child: ListTile(
          title: Text(text, style: isLogout ? logoutbutton : listtilesText),
        ));
  }
}

class ProfileListtileToggle extends StatelessWidget {
  const ProfileListtileToggle({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.sizeOf(context).height;
    return SizedBox(
        height: heigth / 18,
        width: double.infinity,
        child: ListTile(
          title: Text(text, style: listtilesText),
          trailing: Switch(
              activeColor: Colors.black,
              value: true,
              onChanged: (value) {
                //ontap change the value
                value = false;
              }),
        ));
  }
}
