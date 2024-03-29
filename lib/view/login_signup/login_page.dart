import 'package:carnova_user/blocs/login/login_bloc.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/loading_button.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/my_textfield.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:carnova_user/utils/bottom_nav_bar.dart';
import 'package:carnova_user/utils/functions/permissions.dart';
import 'package:carnova_user/utils/snack_bar.dart';
import 'package:carnova_user/utils/validations.dart';
import 'package:carnova_user/view/home_screen.dart';
import 'package:carnova_user/view/login_signup/forget_password.dart';
import 'package:carnova_user/view/login_signup/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
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
                      key: loginKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const SizedBox(height: 50),
                            Hero(
                              tag: "registernow",
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: black,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child:const Center(
                                      child:  Image(
                                      image: AssetImage(
                                          "assets/images/Frame 1.png"),
                                      fit: BoxFit.cover)),
                              ),
                            ),

                            const SizedBox(height: 10),

                            Row(
                              children: [
                                Text(
                                  'Welcome back to',
                                  style: tabcardtext1,
                                ),
                                Text(
                                  ' CARNOVA.',
                                  style: appName,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'You\'ve been missed!',
                              style: greyloginPage,
                            ),

                            const SizedBox(height: 25),

                            // email textfield
                            MyTextField(
                              isPassword: false,
                              validation: (p0) =>
                                  Validations().emailValidation(p0),
                              controller: emailController,
                              hintText: 'Email',
                              obscureText: false,
                            ),

                            const SizedBox(height: 10),

                            // password textfield
                            MyTextField(
                              isPassword: true,
                              validation: (p0) =>
                                  Validations().passwordValidations(p0),
                              controller: passwordController,
                              hintText: 'Password',
                              obscureText: true,
                            ),

                            const SizedBox(height: 10),

                            // forgot password?
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPasswordScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: normalSizePoppins,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 25),
                            // sign in button
                            Hero(
                              tag: "signin",
                              child: BlocConsumer<LoginBloc, LoginState>(
                                listener: (context, state) {
                                  if (state is LogedUserFetched) {
                                    context
                                        .read<LoginBloc>()
                                        .add(BookingHistoryFetching());
                                  } else if (state is LoginFailedState) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        customSnackbar(
                                            context, false, state.messege));
                                  } else if (state is LoginSuccsess) {
                                    navigateToHome(context);
                                  }
                                },
                                builder: (context, state) {
                                  bool isLoading = state is LoadingState;
                                  return MyLoadingButton(
                                    isLoading: isLoading,
                                    title: 'Sign In',
                                    onTap: () {
                                      if (loginKey.currentState!.validate()) {
                                        final mailandpass = {
                                          "email": emailController.text,
                                          "password": passwordController.text
                                        };
                                        context.read<LoginBloc>().add(
                                            LoginButtonClickedEvent(
                                                mailandpass: mailandpass));
                                      }
                                    },
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 50),
                            // or continue with google or somethinggggg
                            const SizedBox(height: 50),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Not a member?',
                                    style: black07,
                                  ),
                                  const SizedBox(width: 4),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SignupScreen(),
                                          ),
                                        );
                                      },
                                      child: Text('Register now',
                                          style: boldPoppins))
                                ])
                          ]),
                    ))))));
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
