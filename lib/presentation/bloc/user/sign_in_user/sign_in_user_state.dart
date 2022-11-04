part of 'sign_in_user_cubit.dart';

abstract class SignInUserState {}

class SignInUserInitial extends SignInUserState {}

class SignInUserLoading extends SignInUserState {}

class SignInUserLoaded extends SignInUserState {
  final UserEntity user;

  SignInUserLoaded(this.user);
}

class SignInUserError extends SignInUserState {
  final String message;

  SignInUserError(this.message);
}
