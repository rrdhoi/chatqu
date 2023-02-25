import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

abstract class FriendRepository {
  Either<Failure, Stream<List<UserEntity>>> getAllFriends(String myUser);
  Either<Failure, Stream<List<UserEntity>>> getFriendRequests(String myUser);
  Future<Either<Failure, List<UserEntity>>> getOwnRequests(String myUser);

  Future<Either<Failure, String>> acceptFriend(
      UserEntity myUser, UserEntity otherUser, bool isAccepted);

  Future<Either<Failure, String>> addFriend(
      UserEntity myUser, UserEntity otherUser);
}
