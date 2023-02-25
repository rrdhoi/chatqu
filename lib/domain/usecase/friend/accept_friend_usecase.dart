import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class AcceptFriendUseCase {
  final FriendRepository _friendRepository;

  AcceptFriendUseCase(this._friendRepository);

  Future<Either<Failure, String>> execute(
          UserEntity myUser, UserEntity otherUser, bool isAccepted) async =>
      _friendRepository.acceptFriend(myUser, otherUser, isAccepted);
}
