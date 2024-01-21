import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carnova_user/blocs/profile_edit/profile_edit_bloc.dart';
import 'package:carnova_user/data/get_it/get_it.dart';
import 'package:carnova_user/resources/api_urls/api_urls.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/custom_textfiled.dart';
import 'package:carnova_user/resources/components/textfields_and_buttons/loading_button.dart';
import 'package:carnova_user/resources/constant/colors_userside.dart';
import 'package:carnova_user/utils/appbar.dart';
import 'package:carnova_user/utils/bottom_nav_bar.dart';
import 'package:carnova_user/utils/snack_bar.dart';
import 'package:carnova_user/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ProfileEditScreen extends StatelessWidget {
  ProfileEditScreen({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final logedUser = getLoggedInUser();

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
                            : logedUser.profile!.isNotEmpty
                                ? CircleAvatar(
                                    backgroundColor: black.withOpacity(0.2),
                                    radius: 80,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "${ApiUrls.imagegettingUrl}${logedUser.profile}",
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        baseColor: shimmerbaseColor,
                                        highlightColor: shimmerhighlightColor,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(url),
                                          backgroundColor:
                                              black.withOpacity(0.2),
                                          radius: 80,
                                        ),
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        AssetImage(imageU.profileDemo),
                                    backgroundColor: black.withOpacity(0.2),
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
                      customSnackbar(context, false, state.messege));
                } else if (state is UserDataUpdateSuccsess) {
                  ScaffoldMessenger.of(context).showSnackBar(customSnackbar(
                      context, true, "Profile Updated Succsess"));
                }
              },
              builder: (context, state) {
                bool isLoading = state is SubmitLoadingState;
                return MyLoadingButton(
                  isLoading: isLoading,
                  title: "Update",
                  onTap: () {
                    if (profileImage == null) {
                      updateButtonClicked(
                          nameController.text, phoneController.text, context);
                    } else {
                      updateButtonClicked(
                          nameController.text, phoneController.text, context);
                    }
                  },
                );
              },
            )
          ]),
        ),
      ),
    );
  }

  updateButtonClicked(String name, String phone, BuildContext context) {
    if (logedUser.profile!.isNotEmpty) {
      if (name.isNotEmpty && phone.length == 10) {
        Map<String, dynamic> data = {"phone": phone, "name": name};
        context
            .read<ProfileEditBloc>()
            .add(SubmitClickedWithImg(imagepath: profileImage, data: data));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(customSnackbar(context, false, "Something Wrong"));
      }
    } else {
      if (imagePath != null) {
        if (name.isNotEmpty && phone.length == 10) {
          Map<String, dynamic> data = {"phone": phone, "name": name};
          context.read<ProfileEditBloc>().add(
              SubmitClickedWithImg(imagepath: File(imagePath!), data: data));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(customSnackbar(context, false, "Something Wrong"));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackbar(context, false, "Add a Profile Photo"));
      }
    }
  }
}
