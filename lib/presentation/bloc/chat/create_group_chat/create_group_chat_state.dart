part of 'create_group_chat_cubit.dart';

abstract class CreateGroupChatState {}

class CreateGroupChatInitial extends CreateGroupChatState {}

class CreateGroupChatLoading extends CreateGroupChatState {}

class CreateGroupChatSuccess extends CreateGroupChatState {
  final String successMessage;
  CreateGroupChatSuccess(this.successMessage);
}

class CreateGroupChatError extends CreateGroupChatState {
  final String errorMessage;
  CreateGroupChatError(this.errorMessage);
}
