import 'package:chatqu/data/data.dart';

abstract class ChatRemoteDataSource {
  Stream<List<ChatModel>> getAllChat(String myUserId);

  Stream<List<MessageModel>> getMessagesForChat(String chatId);

  Future<ChatModel> retrieveChat(String otherUserId, String myUserId);

  Future<bool> sendMessage(
      MessageModel message, MemberModel receiver, MemberModel sender);

  Future<String> createGroupChat(
      List<MemberModel> groupMembers, String groupChatName);

  Stream<List<MessageModel>> getGroupChatMessages(String chatId);

  Future<String> sendGroupMessage(String groupChatId, MessageModel message);
}
