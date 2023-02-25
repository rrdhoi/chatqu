import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class CreateGroupChatUseCase {
  final ChatRepository _chatRepository;

  CreateGroupChatUseCase(this._chatRepository);

  Future<Either<Failure, String>> execute(List<MemberEntity> groupMembers,
          File imageFile, String groupChatName) =>
      _chatRepository.createGroupChat(groupMembers, imageFile, groupChatName);
}
