import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class CurrentUserIdUseCase {
  final UserRepository _userRepository;

  CurrentUserIdUseCase(this._userRepository);

  Either<Failure, Stream<String?>> execute() => _userRepository.currentUserId();
}
