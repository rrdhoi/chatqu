part of 'get_all_chat_cubit.dart';

abstract class GetAllChatState {}

class GetAllChatInitial extends GetAllChatState {}

class GetAllChatLoading extends GetAllChatState {}

class GetAllChatLoaded extends GetAllChatState {
  final List<ChatEntity> chats;
  GetAllChatLoaded(this.chats);
}

class GetAllChatError extends GetAllChatState {
  final String message;
  GetAllChatError(this.message);
}
