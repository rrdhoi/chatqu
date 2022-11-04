import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String? chatId;
  final RecentMessageEntity? recentMessage;
  final List<String?> members;

  const ChatEntity({
    required this.chatId,
    required this.recentMessage,
    required this.members,
  });

  factory ChatEntity.fromMap(Map<String, dynamic> map) {
    return ChatEntity(
      chatId: map['chatId'],
      recentMessage: map['recentMessage'],
      members: List<String>.from(map['members']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'recentMessage': recentMessage,
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

class RecentMessageEntity extends Equatable {
  final String? message;
  final String? sendBy;
  final String? sendAt;
  final List<String>? readBy;

  const RecentMessageEntity({
    this.message,
    this.sendBy,
    this.sendAt,
    this.readBy = const [],
  });

  factory RecentMessageEntity.fromMap(Map<String, dynamic> map) {
    return RecentMessageEntity(
      message: map['message'],
      sendBy: map['sendBy'],
      sendAt: map['sendAt'],
      readBy: List.from(map['readBy']),
    );
  }

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

class MessageEntity extends Equatable {
  final String message;
  final String sendBy;
  final String sendAt;

  const MessageEntity({
    required this.message,
    required this.sendBy,
    required this.sendAt,
  });

  factory MessageEntity.fromMap(Map<String, dynamic> map) {
    return MessageEntity(
      message: map['message'],
      sendBy: map['sendBy'],
      sendAt: map['sendAt'],
    );
  }

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
