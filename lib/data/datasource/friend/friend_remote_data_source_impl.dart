import 'package:chatqu/data/data.dart';

class FriendRemoteDataSourceImpl extends FriendRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  FriendRemoteDataSourceImpl({required this.firebaseFirestore});

  @override
  Future<String> addFriend(UserModel myUser, UserModel otherUser) async {
    try {
      await firebaseFirestore
          .collection("ownRequests")
          .doc(myUser.userId)
          .set({otherUser.userId!: otherUser.toMap()}, SetOptions(merge: true));

      await firebaseFirestore
          .collection("friendRequests")
          .doc(otherUser.userId)
          .set({myUser.userId!: myUser.toMap()}, SetOptions(merge: true));

      return 'Tambah teman berhasil!';
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: e.message,
      );
    }
  }

  @override
  Stream<List<UserModel>> getFriendRequests(String myUser) {
    try {
      final ref = firebaseFirestore
          .collection("friendRequests")
          .doc(myUser)
          .snapshots();

      return ref.map(
        (doc) => (doc.data() != null)
            ? List<UserModel>.from(
                doc.data()!.entries.map((e) => UserModel.fromMap(e.value)),
              )
            : List.empty(),
      );
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: e.message,
      );
    }
  }

  @override
  Future<List<UserModel>> getOwnRequests(String myUser) async {
    try {
      final ref =
          await firebaseFirestore.collection("ownRequests").doc(myUser).get();
      return (ref.data() != null)
          ? List<UserModel>.from(
              ref.data()!.entries.map((e) => UserModel.fromMap(e.value)),
            )
          : List.empty();
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: e.message,
      );
    }
  }

  @override
  Stream<List<UserModel>> getAllFriends(String myUser) {
    try {
      final ref =
          firebaseFirestore.collection("allFriends").doc(myUser).snapshots();

      return ref.map(
        (doc) => (doc.data() != null)
            ? List<UserModel>.from(
                doc.data()!.entries.map((e) => UserModel.fromMap(e.value)),
              )
            : List.empty(),
      );
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: e.message,
      );
    }
  }

  @override
  Future<String> acceptFriend(
      UserModel myUser, UserModel otherUser, bool isAccepted) async {
    try {
      await firebaseFirestore
          .collection("friendRequests")
          .doc(myUser.userId)
          .update({otherUser.userId!: FieldValue.delete()});

      await firebaseFirestore
          .collection("ownRequests")
          .doc(otherUser.userId)
          .update({myUser.userId!: FieldValue.delete()});

      // store myUser data and otherUser data in allFriends
      if (isAccepted) {
        await firebaseFirestore.collection("allFriends").doc(myUser.userId).set(
            {otherUser.userId!: otherUser.toMap()}, SetOptions(merge: true));

        await firebaseFirestore
            .collection("allFriends")
            .doc(otherUser.userId)
            .set({myUser.userId!: myUser.toMap()}, SetOptions(merge: true));
      }

      return 'Terima pertemanan berhasil!';
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: e.message,
      );
    }
  }
}
