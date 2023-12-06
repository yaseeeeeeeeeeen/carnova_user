// ignore_for_file: use_build_context_synchronously

import 'package:carnova_user/resources/components/textfields_and_buttons/loading_button.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/my_textfield.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/utils/validations.dart';
import 'package:carnova_user/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final firstnameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneNumberController = TextEditingController();

  final passwordController = TextEditingController();

  final conformpasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Map<String, Object> userData = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(imageU.profileBg), fit: BoxFit.cover)),
        child: Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SingleChildScrollView(
                    child: Form(
                        key: formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
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
                                      child: Text(
                                    "C",
                                    style: GoogleFonts.poppins(
                                        fontSize: 40, color: Colors.white),
                                  )),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Create an account",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Sign up to join",
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 20),
                              MyTextField(
                                validation: (p0) =>
                                    Validations().nameValidation(p0),
                                controller: firstnameController,
                                hintText: 'Name',
                                obscureText: false,
                              ),
                              const SizedBox(height: 12),
                              MyTextField(
                                validation: (p0) =>
                                    Validations().emailValidation(p0),
                                controller: emailController,
                                number: TextInputType.emailAddress,
                                hintText: 'Email',
                                obscureText: false,
                              ),
                              const SizedBox(height: 12),
                              MyTextField(
                                validation: (p0) =>
                                    Validations().phoneNumberValidate(p0),
                                controller: phoneNumberController,
                                hintText: 'Mobile Number',
                                obscureText: false,
                                number: TextInputType.number,
                              ),
                              const SizedBox(height: 12),
                              MyTextField(
                                validation: (p0) =>
                                    Validations().passwordValidations(p0),
                                controller: passwordController,
                                hintText: 'Password',
                                obscureText: true,
                              ),
                              const SizedBox(height: 12),
                              MyTextField(
                                validation: (p0) => Validations()
                                    .confirmpassValidations(
                                        p0, passwordController.text),
                                controller: conformpasswordController,
                                hintText: 'Conform Password',
                                obscureText: true,
                              ),
                              const SizedBox(height: 20),
                              Hero(

                                tag: "signin",
                                child: MyLoadingButton(
                                    isLoading: false,
                                    title: 'Sign Up',
                                    onTap: () async {
                                      if (formKey.currentState!.validate()) {
                                        final data = await signup();
                                        // context.read<SignupBloc>().add(
                                        //     SignupClickedEvent(
                                        //         signupData: data));
                                      }
                                    }),
                              ),
                              const SizedBox(height: 40),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Have an account?',
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                    const SizedBox(width: 4),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Sign In',
                                        style: TextStyle(
                                          color: black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ])
                            ]))))),
      ),
    );
  }

  signup() async {
    final phone = int.parse(phoneNumberController.text.trim());
    userData = {
      "name": firstnameController.text,
      "email": emailController.text,
      "phone": phone,
      "password": passwordController.text,
      "confirmPass": conformpasswordController.text
    };

    return userData;
  }
}
