import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> signUpUser(
      UserEntity user, String password);
  Future<Either<Failure, UserEntity>> signInEmail(
      String email, String password);
  Future<Either<Failure, UserEntity>> searchUserByUsername(String username);
  Future<Either<Failure, UserEntity>> getUserData(String userId);
  Either<Failure, Stream<String?>> currentUserId();
  Future<Either<Failure, String>> signOutUser();
}
