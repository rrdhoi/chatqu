import 'package:chatqu/data/data.dart';

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  ChatRemoteDataSourceImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  @override
  Stream<List<ChatModel>> getAllChat(String myUserId) {
    try {
      final query = firebaseFirestore
          .collection('chats')
          .where('memberIds', arrayContains: myUserId);

      return query
          .orderBy(
            'recentMessage.sendAt',
            descending: true,
          )
          .snapshots()
          .map((event) => event.docs
              .map((chatData) => ChatModel.fromMap(chatData.data()))
              .toList());
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: e.message,
      );
    }
  }

  @override
  Stream<List<MessageModel>> getMessagesForChat(String chatId) {
    try {
      if (chatId.isEmpty) {
        throw FirebaseException(
          plugin: "",
          code: "",
          message: "Chat is empty",
        );
      }

      final chatMessageStream = firebaseFirestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('sendAt')
          .snapshots();

      return chatMessageStream.map((snapshot) => snapshot.docs
          .map((messageData) => MessageModel.fromMap(messageData.data()))
          .toList());
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: e.message,
      );
    }
  }

  @override
  Future<ChatModel> retrieveChat(String otherUserId, String myUserId) async {
    try {
      final chatSnapshot = await firebaseFirestore
          .collection('chats')
          .where('memberIds', isEqualTo: [myUserId, otherUserId]).get();

      if (chatSnapshot.docs.isNotEmpty) {
        return ChatModel.fromMap(chatSnapshot.docs.first.data());
      } else {
        return ChatModel.empty();
      }
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: e.message,
      );
    }
  }

  @override
  Future<bool> sendMessage(
      MessageModel message, MemberModel receiver, MemberModel sender) async {
    try {
      final chatExistence =
          await retrieveChat(receiver.userId!, sender.userId!);

      final chatId = (chatExistence.chatId != null)
          ? chatExistence.chatId
          : firebaseFirestore.collection('chats').doc().id;

      final messageId = firebaseFirestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc()
          .id;

      final chatDetails = ChatModel(
        chatId: chatId,
        memberIds: [sender.userId!, receiver.userId!],
        memberData: [sender, receiver],
        recentMessage: RecentMessageModel(
          messageId: messageId,
          message: message.message,
          sendAt: message.sendAt,
          sendBy: message.sendBy,
        ),
      );

      // set / update chat
      await firebaseFirestore
          .collection('chats')
          .doc(chatId)
          .set(chatDetails.toMap());

      // set message
      await firebaseFirestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(messageId)
          .set(message.copyWith(messageId: messageId).toMap());

      // Untuk memanggil kembali stream di chat page biar di load kembali ketika baru pertama kali mengirim chat
      if (chatExistence.chatId == null) {
        getMessagesForChat(chatId!);
      }

      return true;
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: e.message,
      );
    }
  }

  /*
  * return groupChatId
  * */
  @override
  Future<String> createGroupChat(
    List<MemberModel> groupMembers,
    String groupChatName,
  ) async {
    try {
      final groupChatId = firebaseFirestore.collection('chats').doc().id;
      final chatDetails = ChatModel(
        chatId: groupChatId,
        memberIds: List.from(groupMembers.map((member) => member.userId)),
        memberData: groupMembers,
        recentMessage: RecentMessageModel(
          message:
              "${groupMembers.first.name} telah membuat grup $groupChatName",
          sendAt: Timestamp.now(),
        ),
        groupData: GroupDataModel(
          groupName: groupChatName,
        ),
      );

      await firebaseFirestore
          .collection('chats')
          .doc(groupChatId)
          .set(chatDetails.toMap());

      return groupChatId;
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: e.message,
      );
    }
  }

  @override
  Stream<List<MessageModel>> getGroupChatMessages(String chatId) {
    try {
      final groupChatMessages = firebaseFirestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('sendAt')
          .snapshots();

      return groupChatMessages.map((event) => event.docs
          .map((message) => MessageModel.fromMap(message.data()))
          .toList());
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: e.message,
      );
    }
  }

  @override
  Future<String> sendGroupMessage(
      String groupChatId, MessageModel message) async {
    try {
      final messageId = firebaseFirestore
          .collection('chats')
          .doc(groupChatId)
          .collection('messages')
          .doc()
          .id;

      final recentMessage = RecentMessageModel(
        messageId: messageId,
        message: message.message,
        sendAt: message.sendAt,
        sendBy: message.sendBy,
      );

      await firebaseFirestore
          .collection('chats')
          .doc(groupChatId)
          .update({"recentMessage": recentMessage.toMap()});

      // set message
      await firebaseFirestore
          .collection('chats')
          .doc(groupChatId)
          .collection('messages')
          .doc(messageId)
          .set(message.copyWith(messageId: messageId).toMap());

      return "Send message success";
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: e.message,
      );
    }
  }
}
