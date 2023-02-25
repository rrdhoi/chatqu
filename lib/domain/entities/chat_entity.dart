import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';
import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String? chatId;
  final RecentMessageEntity? recentMessage;
  final List<MemberEntity> memberData;
  final List<String> memberIds;
  final GroupDataEntity? groupData;

  const ChatEntity({
    required this.chatId,
    required this.recentMessage,
    required this.memberIds,
    required this.memberData,
    this.groupData,
  });

  @override
  List<Object?> get props => [
        chatId,
        recentMessage,
        memberIds,
        memberData,
        groupData,
      ];
}

class GroupDataEntity extends Equatable {
  final String? groupName;
  final String? groupPicture;

  const GroupDataEntity({this.groupName, this.groupPicture});

  factory GroupDataEntity.fromMap(Map<String, dynamic> map) {
    return GroupDataEntity(
      groupName: map['groupName'],
      groupPicture: map['groupPicture'],
    );
  }

  @override
  List<Object?> get props => [groupName, groupPicture];
}

class MemberEntity extends Equatable {
  final String? name;
  final String? userId;
  final String? imageProfile;

  const MemberEntity({this.name, this.userId, this.imageProfile});

  factory MemberEntity.fromMap(Map<String, dynamic> map) {
    return MemberEntity(
      name: map['name'],
      userId: map['userId'],
      imageProfile: map['imageProfile'],
    );
  }

  factory MemberEntity.fromUserEntity(UserEntity user) => MemberEntity(
      name: user.name, userId: user.userId, imageProfile: user.imageProfile);

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

class RecentMessageEntity extends Equatable {
  final String? messageId;
  final String? message;
  final String? sendBy;
  final Timestamp? sendAt;
  final List<String>? readBy;

  const RecentMessageEntity({
    this.messageId,
    this.message,
    this.sendBy,
    this.sendAt,
    this.readBy = const [],
  });

  @override
  List<Object?> get props => [
        messageId,
        message,
        sendBy,
        sendAt,
        readBy,
      ];
}

class MessageEntity extends Equatable {
  final String messageId;
  final String message;
  final String sendBy;
  final Timestamp sendAt;

  const MessageEntity({
    required this.messageId,
    required this.message,
    required this.sendBy,
    required this.sendAt,
  });

  @override
  List<Object?> get props => [messageId, message, sendBy, sendAt];
}
