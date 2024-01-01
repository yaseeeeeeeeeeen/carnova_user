// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_edit_bloc.dart';

abstract class ProfileEditEvent {}

class ImageAddedClicked extends ProfileEditEvent {}

class SubmitClickedWithImg extends ProfileEditEvent {
  File? imagepath;
  Map<String, dynamic> data;
  SubmitClickedWithImg({ this.imagepath, required this.data});
}
