import 'package:chatqu/domain/domain.dart';

class GroupChatArguments {
  final String groupChatId;
  final String currentUserId;
  final String groupName;
  final List<MemberEntity> groupMembersList;

  GroupChatArguments({
    required this.groupChatId,
    required this.currentUserId,
    required this.groupName,
    required this.groupMembersList,
  });
}

class PersonalChatArguments {
  final MemberEntity myUser;
  final MemberEntity otherUser;

  PersonalChatArguments({
    required this.myUser,
    required this.otherUser,
  });
}
