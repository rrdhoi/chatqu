import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class SignUpUserUseCase {
  final UserRepository _userRepository;

  SignUpUserUseCase(this._userRepository);

  Future<Either<Failure, UserEntity>> execute(
          UserEntity user, String password) =>
      _userRepository.signUpUser(user, password);
}
