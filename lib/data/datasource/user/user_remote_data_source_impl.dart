import 'package:chatqu/data/data.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  UserRemoteDataSourceImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  @override
  Future<UserModel> signUpUser(UserModel userModel, String password) async {
    try {
      final checkUsername = await searchUserByUsername(userModel.username!);
      if (checkUsername.username != null) {
        throw FirebaseException(
          plugin: 'chatqu',
          message: 'Username already exists',
        );
      }

      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
          email: userModel.email!, password: password);
      final User user = result.user!;

      var userData = UserModel(
        userId: user.uid,
        username: userModel.username,
        name: userModel.name,
        email: userModel.email,
        imageProfile: null,
      );

      // set data user to firestore
      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .set(userData.toMap());

      return userData;
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: e.message,
      );
    }
  }

  @override
  Future<UserModel> signInUser(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = await firebaseFirestore
          .collection('users')
          .doc(result.user!.uid)
          .get();

      return UserModel.fromMap(user.data()!);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  @override
  Future<UserModel> searchUserByUsername(String username) async {
    try {
      final user = await firebaseFirestore
          .collection('users')
          .where("username", isEqualTo: username)
          .get();

      if (user.docs.isNotEmpty) {
        return UserModel.fromMap(user.docs.first.data());
      } else {
        return UserModel.emptyData();
      }
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: e.message,
      );
    }
  }

  @override
  Stream<String?> currentUserId() {
    try {
      final user = firebaseAuth.authStateChanges();
      return user.map((user) => (user != null) ? user.uid : null);
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: e.message,
      );
    }
  }

  @override
  Future<UserModel> getUserData(String userId) async {
    try {
      final myUserData =
          await firebaseFirestore.collection('users').doc(userId).get();
      return UserModel.fromMap(myUserData.data()!);
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: e.message,
      );
    }
  }

  @override
  Future<String> signOutUser() async {
    try {
      await firebaseAuth.signOut();
      // remove private key from local

      return 'Sign out berhasil!';
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: e.message,
      );
    }
  }
}
