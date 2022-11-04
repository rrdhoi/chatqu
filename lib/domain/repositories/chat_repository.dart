import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

abstract class ChatRepository {
  Either<Failure, Stream<List<ChatEntity>>> getAllChat();
  Future<Either<Failure, ChatEntity>> checkChatExist(String otherUserId);
  Either<Failure, Stream<List<MessageEntity>>> getChatMessages(String chatId);
  Future<Either<Failure, String>> sendMessage(
      MessageEntity message, String otherUserId);
}
