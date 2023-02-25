import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class GetGroupChatMessagesUseCase {
  final ChatRepository _chatRepository;

  GetGroupChatMessagesUseCase(this._chatRepository);

  Either<Failure, Stream<List<MessageEntity>>> execute(String chatId) =>
      _chatRepository.getGroupChatMessages(chatId);
}
