import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

SnackBar customSnackbar(context, bool error, String messege) {
  return SnackBar(
    content: Text(
      messege,
      style: GoogleFonts.poppins(),
    ),
    backgroundColor: error ? appbarColorU : CupertinoColors.destructiveRed,
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );
}
