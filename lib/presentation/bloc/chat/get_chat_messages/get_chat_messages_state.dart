part of 'get_chat_messages_cubit.dart';

abstract class GetChatMessagesState {}

class GetChatMessagesInitial extends GetChatMessagesState {}

class GetChatMessagesLoading extends GetChatMessagesState {}

class GetChatMessagesLoaded extends GetChatMessagesState {
  final Stream<List<MessageEntity>> chats;
  GetChatMessagesLoaded(this.chats);
}

class GetChatMessagesError extends GetChatMessagesState {
  final String message;
  GetChatMessagesError(this.message);
}
