// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:carnova_user/blocs/password_settings/password_settings_bloc.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  bool obscureText;
  final bool isPassword;
  TextInputType? number;
  FormFieldValidator validation;
  Function(String)? onChanged;
  Function(String)? onFieldSubmitted;

  MyTextField({
    Key? key,
    this.onFieldSubmitted,
    this.onChanged,
    this.number,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.isPassword,
    required this.validation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PasswordSettingsBloc, PasswordSettingsState>(
      listener: (context, state) {
        if (state is PasswordVisiblityOn) {
          obscureText = true;
        } else if (state is PasswordVisiblityoff) {
          obscureText = false;
        }
      },
      builder: (context, state) {
        return TextFormField(
          onFieldSubmitted: onFieldSubmitted ?? (value) {},
          onChanged: onChanged ?? (value) {},
          keyboardType: number ?? TextInputType.streetAddress,
          validator: validation,
          controller: controller,
          obscureText: isPassword ? obscureText : false,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(width: 5, color: Colors.black),
            ),
            label: Text(
              hintText,
              style: GoogleFonts.poppins(color: Colors.black),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500]),
            suffixIcon: isPassword == true
                ? IconButton(
                    icon: obscureText
                        ? const Icon(Icons.visibility)
                        : const Icon(
                            Icons.visibility_off),
                    onPressed: () {
                      context
                          .read<PasswordSettingsBloc>()
                          .add(PasswordVisiblity(visiblity: obscureText));
                    },
                  )
                : null,
          ),
        );
      },
    );
  }
}
