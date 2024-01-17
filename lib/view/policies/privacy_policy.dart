import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/policie_datas.dart';
import 'package:carnova_user/utils/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyAndPolicyScreen extends StatelessWidget {
  const PrivacyAndPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: customAppBarText("Terms and Condition", context, () {
        Navigator.of(context).pop();
      }),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                border: Border.all(color: borderSide),
                borderRadius: BorderRadius.circular(10),
                color: mainColorU),
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Text(
                      "CARNOVA",
                      style: GoogleFonts.poppins(),
                    ),
                    const Divider(thickness: 2),
                    Text(PrivacyAndPolicyData.termsAndConditionsContentAll,
                        style: GoogleFonts.poppins(),
                        textAlign: TextAlign.left),
                  ],
                )),
          )),
    );
  }
}
