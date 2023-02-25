part of 'sign_up_user_cubit.dart';

abstract class SignUpUserState {}

class SignUpUserInitial extends SignUpUserState {}

class SignUpUserLoading extends SignUpUserState {}

class SignUpUserLoaded extends SignUpUserState {
  final UserEntity user;

  SignUpUserLoaded(this.user);
}

class SignUpUserError extends SignUpUserState {
  final String message;

  SignUpUserError(this.message);
}
