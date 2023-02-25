import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class GetAllChatUseCase {
  final ChatRepository _chatRepository;

  GetAllChatUseCase(this._chatRepository);

  Either<Failure, Stream<List<ChatEntity>>> execute(String myUserId) =>
      _chatRepository.getAllChat(myUserId);
}
