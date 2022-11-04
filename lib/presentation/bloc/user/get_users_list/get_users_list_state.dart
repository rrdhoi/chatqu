part of 'get_users_list_cubit.dart';

abstract class GetUsersListState {}

class GetUsersListInitial extends GetUsersListState {}

class GetUsersListLoading extends GetUsersListState {}

class GetUsersListLoaded extends GetUsersListState {
  final List<UserEntity> usersList;

  GetUsersListLoaded(this.usersList);
}

class GetUsersListError extends GetUsersListState {
  final String message;

  GetUsersListError(this.message);
}
