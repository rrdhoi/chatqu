part of 'get_group_chat_messages_cubit.dart';

abstract class GetGroupChatMessagesState {}

class GetGroupChatMessagesInitial extends GetGroupChatMessagesState {}

class GetGroupChatMessagesLoading extends GetGroupChatMessagesState {}

class GetGroupChatMessagesLoaded extends GetGroupChatMessagesState {
  final List<MessageEntity> chats;
  GetGroupChatMessagesLoaded(this.chats);
}

class GetGroupChatMessagesError extends GetGroupChatMessagesState {
  final String errorMessage;
  GetGroupChatMessagesError(this.errorMessage);
}
