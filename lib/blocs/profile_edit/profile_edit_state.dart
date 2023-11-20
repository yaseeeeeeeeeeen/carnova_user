// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_edit_bloc.dart';

abstract class ProfileEditState {}

final class ProfileEditInitial extends ProfileEditState {}

class ProfileUpdateLoadingState extends ProfileEditState {}

class ProfileUpdateSuccsessState extends ProfileEditState {}

class ProfileImageAddedState extends ProfileEditState {
    String imagePath;
  ProfileImageAddedState({
    required this.imagePath,
  });

}

class ProfileUpdateFailedState extends ProfileEditState {}
