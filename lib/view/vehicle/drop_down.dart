import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/list_datas.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropDownWid extends StatefulWidget {
  const DropDownWid(
      {super.key,
      required this.listIndex,
      required this.controller,
      required this.titletext,
      required this.hinttext});
  final int listIndex;
  final String titletext;
  final String hinttext;
  final TextEditingController controller;

  @override
  State<DropDownWid> createState() => _DropDownWidState();
}

class _DropDownWidState extends State<DropDownWid> {
  @override
  void initState() {
    //main List of List

    super.initState();
  }

  final TextStyle _labelStyle =
      GoogleFonts.poppins(fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          widget.titletext,
          style: tabcardtext1,
        ),
        const SizedBox(height: 8),
        CustomDropdown(
          selectedStyle: GoogleFonts.poppins(color: Colors.black),
          hintText: widget.hinttext,
          hintStyle: normalSizePoppins,
          items: mainList[widget.listIndex],
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: borderSide,
            width: 1,
          ),
          controller: widget.controller,
          excludeSelected: false,
          listItemBuilder: (context, result) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(result, style: _labelStyle),
                const Icon(Icons.circle_outlined)
              ],
            );
          },
        ),
      ],
    );
  }
}
