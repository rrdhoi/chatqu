import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class SignInUserUseCase {
  final UserRepository _userRepository;

  SignInUserUseCase(this._userRepository);

  Future<Either<Failure, UserEntity>> execute(String email, String password) =>
      _userRepository.signInEmail(email, password);
}
