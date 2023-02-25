part of 'get_own_request_cubit.dart';

abstract class GetOwnRequestState {}

class GetOwnRequestInitial extends GetOwnRequestState {}

class GetOwnRequestLoading extends GetOwnRequestState {}

class GetOwnRequestSuccess extends GetOwnRequestState {
  final List<UserEntity> users;

  GetOwnRequestSuccess(this.users);
}

class GetOwnRequestFailure extends GetOwnRequestState {
  final String message;

  GetOwnRequestFailure(this.message);
}
