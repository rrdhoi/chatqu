part of 'search_user_by_username_cubit.dart';

abstract class SearchUserByUsernameState {}

class SearchUserByUsernameInitial extends SearchUserByUsernameState {}

class SearchUserByUsernameLoading extends SearchUserByUsernameState {}

class SearchUserByUsernameLoaded extends SearchUserByUsernameState {
  final UserEntity user;

  SearchUserByUsernameLoaded(this.user);
}

class SearchUserByUsernameError extends SearchUserByUsernameState {
  final String message;

  SearchUserByUsernameError(this.message);
}
