import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class GetChatMessagesUseCase {
  final ChatRepository _chatRepository;

  GetChatMessagesUseCase(this._chatRepository);

  Either<Failure, Stream<List<MessageEntity>>> execute(String chatId) =>
      _chatRepository.getMessagesForChat(chatId);
}
