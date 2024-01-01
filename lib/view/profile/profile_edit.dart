import 'dart:io';

import 'package:carnova_user/blocs/profile_edit/profile_edit_bloc.dart';
import 'package:carnova_user/data/get_it/get_it.dart';
import 'package:carnova_user/modals/user_modal.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/custom_textfiled.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/loading_button.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/utils/appbar.dart';
import 'package:carnova_user/utils/bottom_nav_bar.dart';
import 'package:carnova_user/utils/snack_bar.dart';
import 'package:carnova_user/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ProfileEditScreen extends StatelessWidget {
  ProfileEditScreen({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String? imagePath;
  File? profileImage;
  @override
  Widget build(BuildContext context) {
    nameController.text = logedUser.name;
    phoneController.text = logedUser.phone.toString();
    return Scaffold(
      appBar: customAppBarText("PROFILE EDIT", context, () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => CustomNavBar(index: 3)),
            (route) => false);
      }),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(children: [
            Hero(
              tag: "profilePhoto",
              child: BlocBuilder<ProfileEditBloc, ProfileEditState>(
                builder: (context, state) {
                  if (state is ProfileImageAddedState) {
                    profileImage = state.imagePath;
                    imagePath = state.imagePath.path;
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
                            : CircleAvatar(
                                backgroundImage: AssetImage(imageU.profileDemo),
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
                keybordtype: TextInputType.number,
                hint: "Phone Number",
                isSufix: true,
                controller: phoneController),
            const SizedBox(height: 10),
            BlocConsumer<ProfileEditBloc, ProfileEditState>(
              listener: (context, state) {
                if (state is ProfileUpdateFailedState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      customSnackbar(context, false, state.message));
                } else if (state is ProfileUpdateSuccsessState) {
                  ScaffoldMessenger.of(context).showSnackBar(customSnackbar(
                      context, true, "Profile Updated Succsess"));
                }
              },
              builder: (context, state) {
                bool isLoading = state is ProfileUpdateLoadingState;
                return MyLoadingButton(
                  isLoading: isLoading,
                  title: "Update",
                  onTap: () {
                    if (profileImage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(customSnackbar(
                          context, false, "ADD YOUR PROFILE PHOTO"));
                    }
                    updateButton(phoneController, nameController, profileImage!,
                        context);
                  },
                );
              },
            )
          ]),
        ),
      ),
    );
  }

  updateButton(TextEditingController phone, TextEditingController name,
      File profile, BuildContext context) {
    File profilephoto = profile;
    if (phone.text.length == 10 || name.text.isNotEmpty) {
      Map<String, dynamic> data = {"phone": phone.text, "name": name.text};
      context
          .read<ProfileEditBloc>()
          .add(SubmitClicked(imagepath: profilephoto, data: data));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackbar(context, false, "SOMETHING WRONG"));
    }
  }
}
