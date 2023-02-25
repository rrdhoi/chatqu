part of 'get_all_friends_cubit.dart';

abstract class GetAllFriendsState {}

class GetAllFriendsInitial extends GetAllFriendsState {}

class GetAllFriendsLoading extends GetAllFriendsState {}

class GetAllFriendsSuccess extends GetAllFriendsState {
  final List<UserEntity> users;

  GetAllFriendsSuccess(this.users);
}

class GetAllFriendsFailure extends GetAllFriendsState {
  final String message;

  GetAllFriendsFailure(this.message);
}
