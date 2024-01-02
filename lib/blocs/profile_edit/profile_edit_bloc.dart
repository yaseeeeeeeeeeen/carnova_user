import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:carnova_user/data/get_it/get_it.dart';
import 'package:carnova_user/data/network/api_services.dart';
import 'package:carnova_user/modals/user_modal.dart';
import 'package:carnova_user/repositories/user_repo.dart';

import 'package:carnova_user/utils/functions/image_picker.dart';
import 'package:carnova_user/utils/functions/string_to_file.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_edit_event.dart';
part 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  File? imagePath;
  ProfileEditBloc() : super(ProfileEditInitial()) {
    on<ImageAddedClicked>(imageAddedClicked);
    on<SubmitClickedWithImg>(submitClicked);
  }

  FutureOr<void> imageAddedClicked(
      ImageAddedClicked event, Emitter<ProfileEditState> emit) async {
    final pickedimage = await ImagePickService().pickCropImage(
        cropAspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        imageSource: ImageSource.gallery);
    if (pickedimage != null) {
      File imagePicked = File(pickedimage.path);
      emit(ProfileImageAddedState(imagePath: imagePicked));
    }
  }

  FutureOr<void> submitClicked(
      SubmitClickedWithImg event, Emitter<ProfileEditState> emit) async {
    emit(SubmitLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    if (event.imagepath == null) {
      final logedUser = getLoggedInUser();
      List<String> imageUrls = [logedUser.profile!];
      final img = await convertingStringtoImage(imageUrls);
      imagePath = img[0];
    } else {
      imagePath = event.imagepath;
    }
    final response = await ApiServices.instance.profileUpdate(imagePath!);
    if (response.statusCode == 200) {
      final data = await ApiServices.instance.dataUpdate(event.data);
      if (data.statusCode == 200) {
        final response1 = await UserRepo().fetchUserData();
        response1.fold((left) {
          emit(UserDataUpdateFailed(messege: left.message));
        }, (right) {
          final userdata = UserModal.fromJson(right);
          replaceUserData(userdata);
          emit(UserDataUpdateSuccsess());
        });
      } else {
        emit(ProfileUpdateFailedState());
      }
    } else {
      emit(ProfileUpdateFailedState());
    }
  }
}
