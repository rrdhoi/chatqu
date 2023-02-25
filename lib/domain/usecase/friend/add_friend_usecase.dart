import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class AddFriendUseCase {
  final FriendRepository _friendRepository;

  AddFriendUseCase(this._friendRepository);

  Future<Either<Failure, String>> execute(
          UserEntity myUser, UserEntity otherUser) async =>
      _friendRepository.addFriend(myUser, otherUser);
}
