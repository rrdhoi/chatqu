import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class GetFriendRequestsUseCase {
  final FriendRepository _friendRepository;

  GetFriendRequestsUseCase(this._friendRepository);

  Either<Failure, Stream<List<UserEntity>>> execute(String myUser) =>
      _friendRepository.getFriendRequests(myUser);
}
