import 'package:carnova_user/resources/components/textfields_and_buttons/loading_button.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/style.dart';

import 'package:otp_text_field/otp_text_field.dart';

// ignore: must_be_immutable
class SignupOtpScreen extends StatelessWidget {
  SignupOtpScreen({super.key, required this.email});
  final String email;
  final otpController = TextEditingController();
  int? otp;
  bool complete = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            shadowColor: Colors.transparent,
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.blue),
          ),
          backgroundColor: Colors.white,
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
                          SizedBox(
                              height: MediaQuery.sizeOf(context).height / 6),
                          Hero(
                            tag: "registernow",
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: black,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Icon(
                                  color: mainColorU,
                                  Icons.person,
                                  size: 35,
                                ),
                              ),
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
                                textFieldAlignment:
                                    MainAxisAlignment.spaceAround,
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
                          MyLoadingButton(
                            title: "Submit",
                            isLoading: false,
                            onTap: () {
                              if (complete) {
                                // context.read<HostOtpVerficationBloc>().add(
                                //     OtpVerifyButtonClicked(intOtp: otp!));
                              }
                            },
                          )
                        ]))
                  ]))
                ])),
          )),
    );
  }
}
