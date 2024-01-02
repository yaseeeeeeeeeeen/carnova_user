import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubTitleWidget extends StatelessWidget {
  final String title;
  final double? fontsize;
  const SubTitleWidget({super.key, required this.title, this.fontsize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        title,
        style: GoogleFonts.inriaSans(
            textStyle: TextStyle(
                fontSize: fontsize ?? 20, fontWeight: FontWeight.bold)),
      ),
    );
  }
}



class FairDetailsRowWidget extends StatelessWidget {
  final String name;
  final String money;

  const FairDetailsRowWidget(
      {super.key, required this.name, required this.money});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(name), Text(money)]));
  }
}