import 'package:carnova_user/blocs/login/login_bloc.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/loading_button.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/my_textfield.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:carnova_user/utils/snack_bar.dart';
import 'package:carnova_user/utils/validations.dart';
import 'package:carnova_user/view/home_screen.dart';
import 'package:carnova_user/view/login_signup/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class PasswordResetScreen extends StatelessWidget {
  PasswordResetScreen({super.key, required this.id});
  String id;
  TextEditingController pass1Controller = TextEditingController();
  TextEditingController pass2Controller = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: scaffoldBg,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        // centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Reset Password",
          style: TextStyle(
            color: secondColorU,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(imageU.profileBg), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: Form(
            key: _formKey1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: media.height / 7),
                Hero(
                    tag: "registernow",
                    child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                            child: Image(
                                image: AssetImage("assets/images/Frame 1.png"),
                                fit: BoxFit.cover)))),
                const SizedBox(height: 25),
                Text(
                  "Add new password and restart your journey",
                  style: tabcardtext1,
                ),
                const SizedBox(height: 25),
                MyTextField(
                    isPassword: true,
                    validation: (value) {
                      return Validations().passwordValidations(value);
                    },
                    controller: pass1Controller,
                    hintText: "Enter New Password",
                    obscureText: true),
                const SizedBox(height: 10),
                MyTextField(
                    isPassword: true,
                    validation: (value) {
                      return Validations()
                          .confirmpassValidations(value, pass1Controller.text);
                    },
                    controller: pass2Controller,
                    hintText: "Confirm Password",
                    obscureText: true),
                const SizedBox(height: 25),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is PasswordResetedSuccsess) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (route) => false);
                      ScaffoldMessenger.of(context).showSnackBar(customSnackbar(
                          context, true, "Password Changed.! Back To Login"));
                    }
                  },
                  builder: (context, state) {
                    return MyLoadingButton(
                        title: "DONE",
                        isLoading: state is LoadingState,
                        onTap: () {
                          if (_formKey1.currentState!.validate()) {
                            context.read<LoginBloc>().add(ResetPasswordWithId(
                                id: id,
                                pass1: pass1Controller.text,
                                pass2: pass2Controller.text));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                customSnackbar(context, false,
                                    "Somethig Wrong Try Again"));
                          }
                        });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
