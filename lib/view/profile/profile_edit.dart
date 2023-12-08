import 'dart:io';

import 'package:carnova_user/blocs/profile_edit/profile_edit_bloc.dart';
import 'package:carnova_user/modals/user_modal.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/custom_textfiled.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/loading_button.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/utils/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ProfileEditScreen extends StatelessWidget {
  ProfileEditScreen({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? imagePath;
  @override
  Widget build(BuildContext context) {
    nameController.text = logedUser!.name;
    emailController.text = logedUser!.email;
    phoneController.text = logedUser!.phone.toString();
    return Scaffold(
      appBar: customAppBarText("PROFILE EDIT", context),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(children: [
            Hero(
              tag: "profilePhoto",
              child: BlocBuilder<ProfileEditBloc, ProfileEditState>(
                builder: (context, state) {
                  if (state is ProfileImageAddedState) {
                    imagePath = state.imagePath;
                  }

                  return GestureDetector(
                    onTap: () {
                      context.read<ProfileEditBloc>().add(ImageAddedClicked());
                    },
                    child: CircleAvatar(
                        radius: 85,
                        backgroundColor: appbarColorU,
                        child: imagePath != null
                            ? CircleAvatar(
                                backgroundImage: FileImage(File(imagePath!)),
                                radius: 80,
                              )
                            : const CircleAvatar(
                                //show previews profile photo
                                backgroundColor: Colors.black12,
                                radius: 80,
                              )),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            CustomTextfield(
                viewonly: true,
                hint: "Name",
                isSufix: false,
                controller: nameController),
            const SizedBox(height: 10),
            CustomTextfield(
                viewonly: true,
                hint: "Email",
                isSufix: false,
                controller: emailController),
            const SizedBox(height: 10),
            CustomTextfield(
                viewonly: true,
                keybordtype: TextInputType.number,
                hint: "Phone Number",
                isSufix: true,
                controller: phoneController),
            const SizedBox(height: 10),
            MyLoadingButton(
              isLoading: false,
              title: "Update",
              onTap: () {},
            )
          ]),
        ),
      ),
    );
  }
}
