import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class SendGroupMessageUseCase {
  final ChatRepository _chatRepository;

  SendGroupMessageUseCase(this._chatRepository);

  Future<Either<Failure, String>> execute(
          String groupChatId, MessageEntity message) async =>
      await _chatRepository.sendGroupMessage(groupChatId, message);
}
