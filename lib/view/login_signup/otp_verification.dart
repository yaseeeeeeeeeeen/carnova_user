import 'package:carnova_user/blocs/otp/otp_bloc.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/loading_button.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/utils/bottom_nav_bar.dart';
import 'package:carnova_user/utils/functions/permissions.dart';
import 'package:carnova_user/utils/snack_bar.dart';
import 'package:carnova_user/view/home_screen.dart';
import 'package:carnova_user/view/login_signup/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/style.dart';

import 'package:otp_text_field/otp_text_field.dart';

// ignore: must_be_immutable
class SignupOtpScreen extends StatelessWidget {
  SignupOtpScreen({super.key, required this.email, this.otpOne, this.otpOneId});
  String? otpOne;
  String? otpOneId;
  final String email;
  final otpController = TextEditingController();
  int? otp;
  bool complete = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: black),
        ),
        backgroundColor: mainColorU,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imageU.profileBg), fit: BoxFit.cover)),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Stack(children: [
                Positioned(
                    child: Stack(children: [
                  Positioned(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                        SizedBox(height: MediaQuery.sizeOf(context).height / 6),
                        Hero(
                          tag: "registernow",
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Center(
                                child: Image(
                                    image:
                                        AssetImage("assets/images/Frame 1.png"),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "one time password  shared to this \nemail address.",
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "($email)",
                          style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 40),
                        Material(
                          color: Colors.transparent,
                          child: OTPTextField(
                              // controller: otpController,
                              length: 4,
                              keyboardType: TextInputType.phone,
                              width: MediaQuery.of(context).size.width,
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldWidth: 45,
                              fieldStyle: FieldStyle.box,
                              outlineBorderRadius: 8,
                              style: const TextStyle(fontSize: 17),
                              onChanged: (pin) {
                                otpController.text = pin;
                              },
                              onCompleted: (pin) {
                                complete = true;
                                otp = int.parse(pin);
                              }),
                        ),
                        const SizedBox(height: 30),
                        BlocConsumer<OtpBloc, OtpState>(
                            listener: (context, state) {
                          if (state is OtpVerificationSuccsessState) {
                            navigateToHome(context);
                          } else if (state is OtpVerificationFailedState) {
                            customSnackbar(
                                context, false, "Something Wrong Try Again");
                          }
                        }, builder: (context, state) {
                          return MyLoadingButton(
                            title: "Submit",
                            isLoading: state is LoadingState,
                            onTap: () {
                              if (complete) {
                                if (otpOne != null) {
                                  final otppp = int.parse(otpOne!);
                                  if (otp == otppp) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PasswordResetScreen(
                                                    id: otpOneId!)));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        customSnackbar(context, false,
                                            "OTP WRONG TRY AGAIN"));
                                  }
                                } else {
                                  context.read<OtpBloc>().add(
                                      OtpSubmitButtonClicked(intotp: otp!));
                                }
                              }
                            },
                          );
                        })
                      ]))
                ]))
              ])),
        ));
  }

  navigateToHome(context) async {
    Permissions permissions = Permissions();
    await permissions.locationPermissionChecking(context);
    await permissions.phoneCallPermissionChecking(context);
    await permissions.galleryPermissionChecking(context);
    await permissions.filesPermissionChecking(context);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => CustomNavBar()),
        (route) => false);
  }
}
