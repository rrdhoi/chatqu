import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';
import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  final String? chatId;
  final RecentMessageModel? recentMessage;
  final List<MemberModel> memberData;
  final List<String> memberIds;
  final GroupDataModel? groupData;

  const ChatModel({
    required this.chatId,
    required this.recentMessage,
    required this.memberData,
    required this.memberIds,
    this.groupData,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatId: map['chatId'],
      recentMessage: RecentMessageModel.fromMap(map['recentMessage']),
      memberIds: List<String>.from(map['memberIds']),
      memberData: List<MemberModel>.from(
          map['memberData'].entries.map((e) => MemberModel.fromMap(e.value))),
      groupData: map['groupData'] != null
          ? GroupDataModel.fromMap(map['groupData'])
          : null,
    );
  }

  factory ChatModel.fromEntity(ChatEntity chat) => ChatModel(
      chatId: chat.chatId,
      recentMessage: RecentMessageModel.fromEntity(chat.recentMessage),
      memberIds: chat.memberIds,
      memberData: chat.memberData
          .map((memberEntity) => MemberModel.fromEntity(memberEntity))
          .toList(),
      groupData: GroupDataModel.fromEntity(chat.groupData));

  factory ChatModel.empty() => ChatModel(
        chatId: null,
        recentMessage: null,
        memberIds: List.empty(),
        memberData: List.empty(),
        groupData: null,
      );

  ChatEntity toEntity() => ChatEntity(
        chatId: chatId,
        recentMessage: recentMessage?.toEntity(),
        memberIds: memberIds,
        memberData:
            memberData.map((memberModel) => memberModel.toEntity()).toList(),
        groupData: groupData?.toEntity(),
      );

  ChatModel copyWith({
    String? chatId,
    RecentMessageModel? recentMessage,
    List<MemberModel>? memberData,
    List<String>? memberIds,
    GroupDataModel? groupData,
  }) {
    return ChatModel(
      chatId: chatId ?? this.chatId,
      recentMessage: recentMessage ?? this.recentMessage,
      memberIds: memberIds ?? this.memberIds,
      memberData: memberData ?? this.memberData,
      groupData: groupData ?? this.groupData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'recentMessage': recentMessage?.toMap(),
      'memberIds': memberIds,
      'memberData': {
        for (var member in memberData) member.userId: member.toMap()
      },
      'groupData': groupData?.toMap(),
    };
  }

  @override
  List<Object?> get props => [
        chatId,
        recentMessage,
        memberIds,
        memberData,
        groupData,
      ];
}

class GroupDataModel extends Equatable {
  final String? groupName;
  final String? groupPicture;

  const GroupDataModel({this.groupName, this.groupPicture});

  factory GroupDataModel.fromMap(Map<String, dynamic> map) {
    return GroupDataModel(
      groupName: map['groupName'],
      groupPicture: map['groupPicture'],
    );
  }

  factory GroupDataModel.fromEntity(GroupDataEntity? data) => GroupDataModel(
        groupName: data?.groupName,
        groupPicture: data?.groupPicture,
      );

  GroupDataEntity toEntity() => GroupDataEntity(
        groupName: groupName,
        groupPicture: groupPicture,
      );

  Map<String, dynamic> toMap() => {
        'groupName': groupName,
        'groupPicture': groupPicture,
      };

  @override
  List<Object?> get props => [groupName, groupPicture];
}

class MemberModel extends Equatable {
  final String? name;
  final String? userId;
  final String? imageProfile;

  const MemberModel({this.name, this.userId, this.imageProfile});

  factory MemberModel.fromMap(Map<String, dynamic> map) {
    return MemberModel(
      name: map['name'],
      userId: map['userId'],
      imageProfile: map['imageProfile'],
    );
  }

  factory MemberModel.fromEntity(MemberEntity user) => MemberModel(
        name: user.name,
        userId: user.userId,
        imageProfile: user.imageProfile,
      );

  MemberEntity toEntity() => MemberEntity(
        name: name,
        userId: userId,
        imageProfile: imageProfile,
      );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userId': userId,
      'imageProfile': imageProfile,
    };
  }

  @override
  List<Object?> get props => [name, userId, imageProfile];
}

class RecentMessageModel extends Equatable {
  final String? messageId;
  final String? message;
  final String? sendBy;
  final Timestamp? sendAt;
  final List<String>? readBy;

  const RecentMessageModel({
    this.messageId,
    this.message,
    this.sendBy,
    this.sendAt,
    this.readBy = const [],
  });

  factory RecentMessageModel.fromMap(Map<String, dynamic> map) {
    return RecentMessageModel(
      messageId: map['messageId'],
      message: map['message'],
      sendBy: map['sendBy'],
      sendAt: map['sendAt'] as Timestamp,
      readBy: map['readBy'] != null ? List<String>.from(map['readBy']) : null,
    );
  }

  factory RecentMessageModel.fromEntity(RecentMessageEntity? recentMessage) =>
      RecentMessageModel(
        messageId: recentMessage?.messageId,
        message: recentMessage?.message,
        sendBy: recentMessage?.sendBy,
        sendAt: recentMessage?.sendAt,
        readBy: recentMessage?.readBy,
      );

  RecentMessageModel copyWith({
    String? messageId,
    String? message,
    String? sendBy,
    Timestamp? sendAt,
    List<String>? readBy,
  }) {
    return RecentMessageModel(
      messageId: messageId ?? this.messageId,
      message: message ?? this.message,
      sendBy: sendBy ?? this.sendBy,
      sendAt: sendAt ?? this.sendAt,
      readBy: readBy ?? this.readBy,
    );
  }

  RecentMessageEntity toEntity() => RecentMessageEntity(
        messageId: messageId ?? '',
        message: message ?? '',
        sendBy: sendBy ?? '',
        sendAt: sendAt,
        readBy: readBy,
      );

  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'message': message,
      'sendBy': sendBy,
      'sendAt': sendAt,
      'readBy': readBy,
    };
  }

  @override
  List<Object?> get props => [
        messageId,
        message,
        sendBy,
        sendAt,
        readBy,
      ];
}

class MessageModel extends Equatable {
  final String messageId;
  final String message;
  final String sendBy;
  final Timestamp sendAt;

  const MessageModel({
    required this.messageId,
    required this.message,
    required this.sendBy,
    required this.sendAt,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      messageId: map['messageId'],
      message: map['message'],
      sendBy: map['sendBy'],
      sendAt: map['sendAt'],
    );
  }

  factory MessageModel.fromDatabase(Map<String, dynamic> map) {
    return MessageModel(
      messageId: map['messageId'],
      message: map['message'],
      sendBy: map['sendBy'],
      sendAt: Timestamp.fromMillisecondsSinceEpoch(map['sendAt']),
    );
  }

  MessageModel copyWith({
    String? messageId,
    String? message,
    String? sendBy,
    Timestamp? sendAt,
  }) {
    return MessageModel(
      messageId: messageId ?? this.messageId,
      message: message ?? this.message,
      sendBy: sendBy ?? this.sendBy,
      sendAt: sendAt ?? this.sendAt,
    );
  }

  factory MessageModel.fromEntity(MessageEntity message) => MessageModel(
        messageId: message.messageId,
        message: message.message,
        sendBy: message.sendBy,
        sendAt: message.sendAt,
      );

  MessageEntity toEntity() => MessageEntity(
        messageId: messageId,
        message: message,
        sendBy: sendBy,
        sendAt: sendAt,
      );

  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'message': message,
      'sendBy': sendBy,
      'sendAt': sendAt,
    };
  }

  @override
  List<Object?> get props => [messageId, message, sendBy, sendAt];
}
