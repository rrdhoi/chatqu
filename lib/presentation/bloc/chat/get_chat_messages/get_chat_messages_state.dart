part of 'get_chat_messages_cubit.dart';

abstract class GetChatMessagesState {}

class GetChatMessagesInitial extends GetChatMessagesState {}

class GetChatMessagesLoading extends GetChatMessagesState {}

/*class GetChatMessagesLoaded extends GetChatMessagesState {
  final Stream<List<Future<MessageEntity?>>> chats;
  GetChatMessagesLoaded(this.chats);
}*/
class GetChatMessagesLoaded extends GetChatMessagesState {
  final List<MessageEntity> chats;
  GetChatMessagesLoaded(this.chats);
}

class GetChatIdSuccess extends GetChatMessagesState {
  final String chatId;
  GetChatIdSuccess(this.chatId);
}

class GetChatMessagesErrorOrEmpty extends GetChatMessagesState {
  final String message;
  GetChatMessagesErrorOrEmpty(this.message);
}
