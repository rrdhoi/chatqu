import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class SendMessageUseCase {
  final ChatRepository _chatRepository;

  SendMessageUseCase(this._chatRepository);

  Future<Either<Failure, bool>> execute(MessageEntity message,
          MemberEntity userReceiver, MemberEntity myUser) async =>
      await _chatRepository.sendMessage(message, userReceiver, myUser);
}
