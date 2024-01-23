import 'package:carnova_user/blocs/login/login_bloc.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/loading_button.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/my_textfield.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:carnova_user/utils/validations.dart';
import 'package:carnova_user/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        // centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: black,
          ),
        ),
        title: Text(
          "Forgot Password",
          style: TextStyle(
            color: black,
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height / 6),
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
                              image: AssetImage("assets/images/Frame 1.png"),
                              fit: BoxFit.cover)),
                    )),
                const SizedBox(height: 25),
                Text(
                  "Enter your email & will send you instruction on how to reset it",
                  style: tabbartitle,
                ),
                const SizedBox(height: 15),
                MyTextField(
                  isPassword: false,
                  validation: (p0) => Validations().emailValidation(p0)!,
                  controller: emailController,
                  hintText: "Email address",
                  obscureText: false,
                ),
                const SizedBox(height: 25),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return MyLoadingButton(
                        onTap: () {
                          context.read<LoginBloc>().add(ForgetPasswordClicked(
                              email: emailController.text));
                        },
                        title: "Send",
                        isLoading: state is LoadingState);
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
