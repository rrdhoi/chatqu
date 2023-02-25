part of 'get_friend_request_cubit.dart';

abstract class GetFriendRequestState {}

class GetFriendRequestInitial extends GetFriendRequestState {}

class GetFriendRequestLoading extends GetFriendRequestState {}

class GetFriendRequestSuccess extends GetFriendRequestState {
  final List<UserEntity> users;

  GetFriendRequestSuccess(this.users);
}

class GetFriendRequestFailure extends GetFriendRequestState {
  final String message;

  GetFriendRequestFailure(this.message);
}
