part of 'send_message_cubit.dart';

abstract class SendMessageState {}

class SendMessageInitial extends SendMessageState {}

class SendMessageLoading extends SendMessageState {}

class SendMessageLoaded extends SendMessageState {
  final String message;
  SendMessageLoaded(this.message);
}

class SendMessageError extends SendMessageState {
  final String message;
  SendMessageError(this.message);
}
