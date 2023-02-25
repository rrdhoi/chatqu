import 'package:chatqu/app/utils/failure.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/entities/user_entity.dart';
import 'package:chatqu/domain/repositories/friend_repository.dart';

class FriendRepositoryImpl extends FriendRepository {
  final FriendRemoteDataSource friendRemoteDataSource;

  FriendRepositoryImpl({required this.friendRemoteDataSource});

  @override
  Future<Either<Failure, String>> acceptFriend(
      UserEntity myUser, UserEntity otherUser, bool isAccepted) async {
    try {
      final result = await friendRemoteDataSource.acceptFriend(
          UserModel.fromEntity(myUser),
          UserModel.fromEntity(otherUser),
          isAccepted);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, String>> addFriend(
      UserEntity myUser, UserEntity otherUser) async {
    try {
      final result = await friendRemoteDataSource.addFriend(
          UserModel.fromEntity(myUser), UserModel.fromEntity(otherUser));
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Either<Failure, Stream<List<UserEntity>>> getAllFriends(String myUser) {
    try {
      final result = friendRemoteDataSource.getAllFriends(myUser);
      return Right(
          result.map((event) => event.map((user) => user.toEntity()).toList()));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Either<Failure, Stream<List<UserEntity>>> getFriendRequests(String myUser) {
    try {
      final result = friendRemoteDataSource.getFriendRequests(myUser);
      return Right(
          result.map((event) => event.map((user) => user.toEntity()).toList()));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getOwnRequests(
      String myUser) async {
    try {
      final result = await friendRemoteDataSource.getOwnRequests(myUser);
      return Right(result.map((user) => user.toEntity()).toList());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }
}
