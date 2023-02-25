import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({required this.userRemoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> signUpUser(
      UserEntity user, String password) async {
    try {
      final result = await userRemoteDataSource.signUpUser(
          UserModel.fromEntity(user), password);
      return Right(result.toEntity());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInEmail(
      String email, String password) async {
    try {
      final result = await userRemoteDataSource.signInUser(email, password);
      return Right(result.toEntity());
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> searchUserByUsername(
      String username) async {
    try {
      final result = await userRemoteDataSource.searchUserByUsername(username);
      return Right(result.toEntity());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Either<Failure, Stream<String?>> currentUserId() {
    try {
      final result = userRemoteDataSource.currentUserId();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserData(String userId) async {
    try {
      final result = await userRemoteDataSource.getUserData(userId);
      return Right(result.toEntity());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, String>> signOutUser() async {
    try {
      final result = await userRemoteDataSource.signOutUser();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }
}
