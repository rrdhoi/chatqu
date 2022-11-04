import 'package:chatqu/domain/domain.dart';
import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  final String? chatId;
  final RecentMessageModel? recentMessage;
  final List<String?> members;

  const ChatModel({
    required this.chatId,
    required this.recentMessage,
    required this.members,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatId: map['chatId'],
      recentMessage: map['recentMessage'] != null
          ? RecentMessageModel.fromMap(map['recentMessage'])
          : null,
      members: List<String>.from(map['members']),
    );
  }

  factory ChatModel.fromEntity(ChatEntity chat) => ChatModel(
        chatId: chat.chatId,
        recentMessage: RecentMessageModel.fromEntity(chat.recentMessage),
        members: chat.members,
      );

  ChatEntity toEntity() => ChatEntity(
        chatId: chatId ?? '',
        recentMessage: recentMessage?.toEntity(),
        members: members,
      );

  ChatModel copyWith({
    String? chatId,
    RecentMessageModel? recentMessage,
    List<String?>? members,
  }) {
    return ChatModel(
      chatId: chatId ?? this.chatId,
      recentMessage: recentMessage ?? this.recentMessage,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'recentMessage': recentMessage?.toMap(),
      'members': members,
    };
  }

  @override
  List<Object?> get props => [
        chatId,
        recentMessage,
        members,
      ];
}

class RecentMessageModel extends Equatable {
  final String? message;
  final String? sendBy;
  final String? sendAt;
  final List<String>? readBy;

  const RecentMessageModel({
    this.message,
    this.sendBy,
    this.sendAt,
    this.readBy = const [],
  });

  factory RecentMessageModel.fromMap(Map<String, dynamic> map) {
    return RecentMessageModel(
      message: map['message'],
      sendBy: map['sendBy'],
      sendAt: map['sendAt'],
      readBy: map['readBy'] != null ? List<String>.from(map['readBy']) : null,
    );
  }

  factory RecentMessageModel.fromEntity(RecentMessageEntity? recentMessage) =>
      RecentMessageModel(
        message: recentMessage?.message,
        sendBy: recentMessage?.sendBy,
        sendAt: recentMessage?.sendAt,
        readBy: recentMessage?.readBy,
      );

  RecentMessageEntity toEntity() => RecentMessageEntity(
        message: message ?? '',
        sendBy: sendBy ?? '',
        sendAt: sendAt ?? '',
        readBy: readBy,
      );

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'sendBy': sendBy,
      'sendAt': sendAt,
      'readBy': readBy,
    };
  }

  @override
  List<Object?> get props => [
        message,
        sendBy,
        sendAt,
        readBy,
      ];
}

class MessageModel extends Equatable {
  final String message;
  final String sendBy;
  final String sendAt;

  const MessageModel({
    required this.message,
    required this.sendBy,
    required this.sendAt,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'],
      sendBy: map['sendBy'],
      sendAt: map['sendAt'],
    );
  }

  MessageModel copyWith({
    String? message,
    String? sendBy,
    String? sendAt,
  }) {
    return MessageModel(
      message: message ?? this.message,
      sendBy: sendBy ?? this.sendBy,
      sendAt: sendAt ?? this.sendAt,
    );
  }

  factory MessageModel.fromEntity(MessageEntity message) => MessageModel(
        message: message.message,
        sendBy: message.sendBy,
        sendAt: message.sendAt,
      );

  MessageEntity toEntity() => MessageEntity(
        message: message,
        sendBy: sendBy,
        sendAt: sendAt,
      );

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'sendBy': sendBy,
      'sendAt': sendAt,
    };
  }

  @override
  List<Object?> get props => [message, sendBy, sendAt];
}
