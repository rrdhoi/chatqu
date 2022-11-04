part of 'get_user_data_cubit.dart';

abstract class GetUserDataState {}

class GetUserDataInitial extends GetUserDataState {}

class GetUserDataLoading extends GetUserDataState {}

class GetUserDataLoaded extends GetUserDataState {
  final UserEntity user;

  GetUserDataLoaded(this.user);
}

class GetUserDataError extends GetUserDataState {
  final String message;

  GetUserDataError(this.message);
}
