import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class GetOwnRequestsUseCase {
  final FriendRepository _friendRepository;

  GetOwnRequestsUseCase(this._friendRepository);

  Future<Either<Failure, List<UserEntity>>> execute(String myUser) =>
      _friendRepository.getOwnRequests(myUser);
}
