import 'package:chatqu/data/models/chat_model.dart';

abstract class ChatRemoteDataSource {
  Stream<List<ChatModel>> getAllChat();

  Stream<List<MessageModel>> getChatMessages(String chatId);

  Future<ChatModel> checkChatExist(String otherUserId);

  Future<ChatModel> createChat(String otherUserId);

  Future<String> sendMessage(MessageModel message, String otherUserId);
}
