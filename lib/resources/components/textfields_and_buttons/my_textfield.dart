import 'package:carnova_user/blocs/password_settings/password_settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  bool obscureText;
  final bool isPassword;
  TextInputType? number;
  FormFieldValidator validation;
  Function(String)? onChanged;

  MyTextField({
    Key? key, // Fixing the super.key parameter
    required this.isPassword,
    this.number,
    this.onChanged,
    required this.validation,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key); // Ensure passing key to super

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
          onChanged: onChanged ?? (value) {},
          keyboardType: number ?? TextInputType.text,
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
                            Icons.visibility_off), // Use your desired icon
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
