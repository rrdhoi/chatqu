import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class RetrieveChatUseCase {
  final ChatRepository _chatRepository;

  RetrieveChatUseCase(this._chatRepository);

  Future<Either<Failure, ChatEntity>> execute(
          String otherUserId, String myUserId) async =>
      await _chatRepository.retrieveChat(otherUserId, myUserId);
}
