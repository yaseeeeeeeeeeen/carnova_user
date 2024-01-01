import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  TextInputType? number;
  FormFieldValidator validation;
  MyTextField({
    super.key,
    this.number,
    required this.validation,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: number ?? TextInputType.text,
      validator: validation,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide(width: 5, color: Colors.black)),
          label:
              Text(hintText, style: GoogleFonts.poppins(color: Colors.black)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500])),
    );
  }
}

// ignore: must_be_immutable
class TitleTexts extends StatelessWidget {
  TitleTexts({super.key, required this.text, this.size, this.color});
  final double? size;
  final String text;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.poppins(
            fontSize: size ?? 21,
            fontWeight: FontWeight.w600,
            color: color ?? Colors.black));
  }
}
