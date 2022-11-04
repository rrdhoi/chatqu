import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class SearchUserByUsernameUseCase {
  final UserRepository _userRepository;

  SearchUserByUsernameUseCase(this._userRepository);

  Future<Either<Failure, UserEntity>> execute(String username) =>
      _userRepository.searchUserByUsername(username);
}
