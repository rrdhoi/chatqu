import 'package:chatqu/data/data.dart';
import 'package:flutter/material.dart';

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  ChatRemoteDataSourceImpl(
      {required this.firebaseFirestore, required this.firebaseAuth});

  @override
  Stream<List<ChatModel>> getAllChat() {
    try {
      final currentUserId = firebaseAuth.currentUser!.uid;
      final getAllChats = firebaseFirestore
          .collection('chats')
          .where('members', arrayContains: currentUserId)
          .orderBy(
            'recentMessage.sendAt',
            descending: true,
          )
          .snapshots();

      final getMyChats = getAllChats.map((event) {
        return event.docs.map((chatData) {
          final chat = ChatModel.fromMap(chatData.data());
          // filter chat that not include current user
          final onlyOtherUser =
              chat.members.where((member) => member != currentUserId);
          return chat.copyWith(
            members: onlyOtherUser.toList(),
          );
        }).toList();
      });

      return getMyChats;
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: e.message,
      );
    }
  }

  @override
  Stream<List<MessageModel>> getChatMessages(String chatId) {
    try {
      if (chatId.isEmpty) {
        throw FirebaseException(
          plugin: 'chatId',
          code: 'Empty data',
          message: 'Chat is empty',
        );
      }

      final chat = firebaseFirestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('sendAt')
          .snapshots();

      return chat.map((event) =>
          event.docs.map((e) => MessageModel.fromMap(e.data())).toList());
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: e.message,
      );
    }
  }

  @override
  Future<ChatModel> checkChatExist(String otherUserId) async {
    try {
      final currentUser = firebaseAuth.currentUser?.uid;
      final userIds = [currentUser, otherUserId]..sort();

      final chat = await firebaseFirestore
          .collection('chats')
          .where('members', isEqualTo: userIds)
          .get();
      if (chat.docs.isNotEmpty) {
        return ChatModel.fromMap(chat.docs.first.data());
      } else {
        return const ChatModel(
          chatId: '',
          recentMessage: RecentMessageModel(
            message: '',
            sendBy: '',
            sendAt: '',
            readBy: [],
          ),
          members: [],
        );
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
  Future<ChatModel> createChat(String otherUserId) async {
    final currentUser = firebaseAuth.currentUser?.uid;
    final userIds = [currentUser, otherUserId]..sort();

    try {
      final chatData = await checkChatExist(otherUserId);
      if (chatData.chatId != '') {
        return chatData;
      } else {
        // TODO :: chat helper
        final chatModel = ChatModel(
          chatId: '',
          members: userIds,
          recentMessage: const RecentMessageModel(
            message: '',
            readBy: [],
            sendAt: '',
            sendBy: '',
          ),
        );

        final createChat = firebaseFirestore.collection('chats').doc().id;
        debugPrint('createChat $createChat');
        await firebaseFirestore
            .collection('chats')
            .doc(createChat)
            .set(chatModel.copyWith(chatId: createChat).toMap());

        final data = await checkChatExist(otherUserId);
        // Untuk memanggil kembali stream di chat page biar di load kembali ketika baru pertama kali mengirim chat
        getChatMessages(otherUserId);
        return data;
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
  Future<String> sendMessage(MessageModel message, String otherUserId) async {
    try {
      final getChatData = await createChat(otherUserId);
      final newMessage =
          message.copyWith(sendBy: firebaseAuth.currentUser!.uid).toMap();
      final sendMessage = await firebaseFirestore
          .collection('chats')
          .doc(getChatData.chatId)
          .update({
        'recentMessage': newMessage,
      }).then(
        (_) async => await firebaseFirestore
            .collection('chats')
            .doc(getChatData.chatId)
            .collection('messages')
            .add(newMessage),
      );

      return 'Pesan berhasil dikirim [${sendMessage.id}]';
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: e.message,
      );
    }
  }
}
