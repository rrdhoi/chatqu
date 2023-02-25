part of 'add_friend_cubit.dart';

abstract class AddFriendState {}

class AddFriendInitial extends AddFriendState {}

class AddFriendLoading extends AddFriendState {}

class AddFriendSuccess extends AddFriendState {
  final String message;

  AddFriendSuccess(this.message);
}

class AddFriendFailure extends AddFriendState {
  final String message;

  AddFriendFailure(this.message);
}
