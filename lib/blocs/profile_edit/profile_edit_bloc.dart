import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:carnova_user/data/network/api_services.dart';
import 'package:carnova_user/data/shared_preferance/sharedprefrance.dart';
import 'package:carnova_user/modals/user_modal.dart';
import 'package:carnova_user/repositories/userdata_repo.dart';

import 'package:carnova_user/utils/functions/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_edit_event.dart';
part 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  ProfileEditBloc() : super(ProfileEditInitial()) {
    on<ImageAddedClicked>(imageAddedClicked);
    on<SubmitClicked>(submitClicked);
  }

  FutureOr<void> imageAddedClicked(
      ImageAddedClicked event, Emitter<ProfileEditState> emit) async {
    final pickedimage = await ImagePickService().pickCropImage(
        cropAspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        imageSource: ImageSource.gallery);
    if (pickedimage != null) {
      File imagePicked = File(pickedimage.path);
      // hostModelData?.profile = pickedimage as File;
      emit(ProfileImageAddedState(imagePath: imagePicked));
    }
  }

  FutureOr<void> submitClicked(
      SubmitClicked event, Emitter<ProfileEditState> emit) async {
    emit(ProfileUpdateLoadingState());
    final response = await ApiServices.instance.dataUpdate(event.data);
    print(response.statusCode);
    final response1 = await ApiServices.instance.profileUpdate(event.imagepath);
    final responsBody = await response1.stream.bytesToString();
    print(responsBody);
    final token = SharedPref.instance.getToke();
    if (token != null) {
      final response = await UserDataRepo().userData(token);
      final data = jsonDecode(response.body);
      if (data != null) {
        final data1 = UserModal.fromJson(data);
        logedUser = data1;
      }
      emit(ProfileUpdateSuccsessState());
    } else {
      emit(ProfileUpdateFailedState(message: "Somthing Wrong"));
    }
  }
}
