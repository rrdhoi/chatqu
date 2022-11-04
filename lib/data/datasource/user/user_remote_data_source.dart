import 'package:chatqu/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> signUpUser(UserModel user, String password);
  Future<UserModel> signInUser(String email, String password);
  Future<UserModel> searchUserByUsername(String username);
  String currentUserId();
  Future<UserModel> getUserData(String userId);
  Future<List<UserModel>> getUsersList(List<String> usersId);
  Future<String> signOutUser();
}
