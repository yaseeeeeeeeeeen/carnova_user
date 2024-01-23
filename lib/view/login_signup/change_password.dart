import 'package:carnova_user/blocs/password_settings/password_settings_bloc.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/loading_button.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/my_textfield.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/resources/constant/text_styles.dart';
import 'package:carnova_user/utils/appbar.dart';
import 'package:carnova_user/utils/snack_bar.dart';
import 'package:carnova_user/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final GlobalKey<FormState> newPasswordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarText("Change Password", context, () {
        Navigator.of(context).pop();
      }),
      backgroundColor: mainColorU,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Form(
                  key: newPasswordKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const SizedBox(height: 15),
                      Text('Change Password', style: changePasswordFont),
                      const SizedBox(height: 10),
                      Text('Enter new password for your security',
                          style: changePasswordFont),
                      // Container(
                      //   height: MediaQuery.of(context).size.height / 3,
                      //   alignment: Alignment.topCenter,
                      //   color: Colors.amber,
                      //   child: const Center(
                      //     child: Text("Lottieee in here"),
                      //   ),
                      //   // child: Lottie.asset('asset/lotties/newPassword.json'),
                      // ),
                      const SizedBox(height: 10),
                      MyTextField(
                          isPassword: true,
                          validation: (value) =>
                              Validations().passwordValidations(value),
                          controller: oldPasswordController,
                          hintText: 'Old Password',
                          obscureText: false),
                      const SizedBox(height: 10),
                      MyTextField(
                          isPassword: true,
                          validation: (value) =>
                              Validations().passwordValidations(value),
                          controller: newPasswordController,
                          hintText: 'New Password',
                          obscureText: false),
                      const SizedBox(height: 10),
                      MyTextField(
                        isPassword: true,
                        validation: (value) => Validations()
                            .confirmpassValidations(
                                value, newPasswordController.text),
                        controller: confirmController,
                        hintText: 'Confirm Password',
                        obscureText: false,
                      ),
                      const SizedBox(height: 20),
                      BlocConsumer<PasswordSettingsBloc, PasswordSettingsState>(
                        listener: (context, state) {
                          if (state is PasswordChangeFailed) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                customSnackbar(
                                    context, false, "Password Change Failed"));
                          } else if (state is PasswordChangeErorr) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                customSnackbar(
                                    context, false, "Something Wrong"));
                          } else if (state is PasswordChangeSuccsess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                customSnackbar(context, true,
                                    "Password Changed Succsefully"));
                          }
                        },
                        builder: (context, state) {
                          return Container(
                            alignment: Alignment.topCenter,
                            child: MyLoadingButton(
                              isLoading: state is PasswordChangeLoading,
                              onTap: () => newPassword(context),
                              title: 'Reset Password',
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  newPassword(BuildContext context) {
    if (newPasswordKey.currentState!.validate()) {
      context.read<PasswordSettingsBloc>().add(ResetPassword(
          oldpassword: oldPasswordController.text,
          newpassword: newPasswordController.text,
          confirmpassword: confirmController.text));
    }
  }
}
