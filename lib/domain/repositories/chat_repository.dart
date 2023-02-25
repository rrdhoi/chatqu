import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

abstract class ChatRepository {
  Either<Failure, Stream<List<ChatEntity>>> getAllChat(String myUserId);

  Future<Either<Failure, ChatEntity>> retrieveChat(
      String otherUserId, String myUserId);

  Either<Failure, Stream<List<MessageEntity>>> getGroupChatMessages(
      String chatId);

  Either<Failure, Stream<List<MessageEntity>>> getMessagesForChat(
      String chatId);

  Future<Either<Failure, String>> createGroupChat(
      List<MemberEntity> groupMembers, File imageFile, String groupChatName);

  Future<Either<Failure, bool>> sendMessage(
      MessageEntity message, MemberEntity userReceiver, MemberEntity myUser);

  Future<Either<Failure, String>> sendGroupMessage(
      String groupChatId, MessageEntity message);
}
