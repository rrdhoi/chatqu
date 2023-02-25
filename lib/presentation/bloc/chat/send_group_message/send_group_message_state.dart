part of 'send_group_message_cubit.dart';

abstract class SendGroupMessageState {}

class SendGroupMessageInitial extends SendGroupMessageState {}

class SendGroupMessageLoading extends SendGroupMessageState {}

class SendGroupMessageSuccess extends SendGroupMessageState {
  final String successMessage;
  SendGroupMessageSuccess(this.successMessage);
}

class SendGroupMessageError extends SendGroupMessageState {
  final String errorMessage;
  SendGroupMessageError(this.errorMessage);
}
