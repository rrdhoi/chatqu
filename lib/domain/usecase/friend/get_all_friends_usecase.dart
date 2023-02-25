import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class GetAllFriendsUseCase {
  final FriendRepository _friendRepository;

  GetAllFriendsUseCase(this._friendRepository);

  Either<Failure, Stream<List<UserEntity>>> execute(String myUser) =>
      _friendRepository.getAllFriends(myUser);
}
