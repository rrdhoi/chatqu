import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class GetUsersListUseCase {
  final UserRepository _userRepository;

  GetUsersListUseCase(this._userRepository);

  Future<Either<Failure, List<UserEntity>>> execute(
          List<String> usersId) async =>
      await _userRepository.getUsersList(usersId);
}
