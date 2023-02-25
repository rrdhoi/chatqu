part of 'sign_out_user_cubit.dart';

abstract class SignOutUserState {}

class SignOutUserInitial extends SignOutUserState {}

class SignOutUserLoading extends SignOutUserState {}

class SignOutUserLoaded extends SignOutUserState {
  final String message;

  SignOutUserLoaded(this.message);
}

class SignOutUserError extends SignOutUserState {
  final String message;

  SignOutUserError(this.message);
}
