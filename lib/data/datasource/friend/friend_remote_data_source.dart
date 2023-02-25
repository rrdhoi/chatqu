import 'package:chatqu/data/data.dart';

abstract class FriendRemoteDataSource {
  Stream<List<UserModel>> getAllFriends(String myUser);

  Stream<List<UserModel>> getFriendRequests(String myUser);

  Future<List<UserModel>> getOwnRequests(String myUser);

  Future<String> addFriend(UserModel myUser, UserModel otherUser);

  Future<String> acceptFriend(
      UserModel myUser, UserModel otherUser, bool isAccepted);
}
