part of 'upload_image_profile_cubit.dart';

abstract class UploadImageProfileState {}

class UploadImageProfileInitial extends UploadImageProfileState {}

class UploadImageProfileLoading extends UploadImageProfileState {}

class UploadImageProfileSuccess extends UploadImageProfileState {
  final String message;

  UploadImageProfileSuccess(this.message);
}

class UploadImageProfileFailure extends UploadImageProfileState {
  final String message;

  UploadImageProfileFailure(this.message);
}
