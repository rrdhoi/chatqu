import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class GetUserDataUseCase {
  final UserRepository _userRepository;

  GetUserDataUseCase(this._userRepository);

  Future<Either<Failure, UserEntity>> execute(String userId) async =>
      await _userRepository.getUserData(userId);
}
