import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class SendMessageUseCase {
  final ChatRepository _chatRepository;

  SendMessageUseCase(this._chatRepository);

  Future<Either<Failure, String>> execute(
          MessageEntity message, String otherUserId) async =>
      await _chatRepository.sendMessage(message, otherUserId);
}
