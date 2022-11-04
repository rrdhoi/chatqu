import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class CheckChatExistUseCase {
  final ChatRepository _chatRepository;

  CheckChatExistUseCase(this._chatRepository);

  Future<Either<Failure, ChatEntity>> execute(String otherUserId) async =>
      await _chatRepository.checkChatExist(otherUserId);
}
