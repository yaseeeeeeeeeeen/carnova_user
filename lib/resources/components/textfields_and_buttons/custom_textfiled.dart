import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomTextfield extends StatelessWidget {
  String hint;
  bool isSufix;
  TextEditingController controller;
  TextInputType? keybordtype;
  CustomTextfield(
      {super.key,
      this.keybordtype,
      required this.hint,
      required this.isSufix,
      required this.controller});

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    if (isSufix == false) {
      obscureText = false;
    }
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SizedBox(
            height: MediaQuery.sizeOf(context).height / 15,
            width: MediaQuery.sizeOf(context).width / 1,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller,
              textInputAction: TextInputAction.next,
              keyboardType: keybordtype,
              style: GoogleFonts.poppins(color: Colors.black),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                fillColor: Colors.transparent,
                filled: true,
                label: Text(hint),
                labelStyle: GoogleFonts.poppins(color: Colors.black),
                errorBorder: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                hintText: hint,
                hintStyle: GoogleFonts.poppins(color: Colors.black),
              ),
            )));
  }
}
