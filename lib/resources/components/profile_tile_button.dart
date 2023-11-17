// ignore: duplicate_ignore
// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';

class ListTileToggle extends StatefulWidget {
  ListTileToggle({super.key, required this.text});
  String text;
  @override
  State<ListTileToggle> createState() => _ListTileToggleState();
}

class _ListTileToggleState extends State<ListTileToggle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.black12),
      child: ListTile(
        trailing: Switch(
            activeColor: Colors.black,
            value: true,
            onChanged: (value) {
              //ontap change the value
              value = false;
            }),
        title: Text(widget.text, style: style5),
        leading: const Icon(Icons.color_lens_outlined, color: Colors.black),
      ),
    );
  }
}

class ListTilePwid extends StatelessWidget {
  ListTilePwid({super.key, required this.title, required this.icon});
  String title;
  Icon icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 3, bottom: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.black12),
      child: ListTile(
        trailing: const Icon(CupertinoIcons.right_chevron, color: Colors.black),
        title: Text(title, style: style5),
        leading: icon,
      ),
    );
  }
}
