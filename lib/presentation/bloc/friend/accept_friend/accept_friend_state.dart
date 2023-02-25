part of 'accept_friend_cubit.dart';

abstract class AcceptFriendState {}

class AcceptFriendInitial extends AcceptFriendState {}

class AcceptFriendLoading extends AcceptFriendState {}

class AcceptFriendSuccess extends AcceptFriendState {
  final String message;

  AcceptFriendSuccess(this.message);
}

class AcceptFriendFailure extends AcceptFriendState {
  final String message;

  AcceptFriendFailure(this.message);
}
