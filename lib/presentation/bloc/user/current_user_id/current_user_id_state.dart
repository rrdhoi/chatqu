part of 'current_user_id_cubit.dart';

abstract class CurrentUserIdState {}

class CurrentUserIdInitial extends CurrentUserIdState {}

class CurrentUserIdLoading extends CurrentUserIdState {}

class CurrentUserIdLoaded extends CurrentUserIdState {
  final String? userId;

  CurrentUserIdLoaded(this.userId);
}

class CurrentUserIdError extends CurrentUserIdState {
  final String message;

  CurrentUserIdError(this.message);
}
