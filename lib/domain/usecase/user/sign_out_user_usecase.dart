import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class SignOutUserUseCase {
  final UserRepository userRepository;

  SignOutUserUseCase(this.userRepository);

  Future<Either<Failure, String>> execute() async =>
      await userRepository.signOutUser();
}
