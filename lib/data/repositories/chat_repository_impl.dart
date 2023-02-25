import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatRemoteDataSource chatRemoteDataSource;
  final FilesRemoteDataSource filesRemoteDataSource;

  ChatRepositoryImpl(
      {required this.chatRemoteDataSource,
      required this.filesRemoteDataSource});

  @override
  Either<Failure, Stream<List<ChatEntity>>> getAllChat(String myUserId) {
    try {
      final result = chatRemoteDataSource.getAllChat(myUserId);
      return Right(result
          .map((event) => event.map((chats) => chats.toEntity()).toList()));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Either<Failure, Stream<List<MessageEntity>>> getMessagesForChat(
      String chatId) {
    try {
      final result = chatRemoteDataSource.getMessagesForChat(chatId);
      return Right(result
          .map((event) => event.map((chats) => chats.toEntity()).toList()));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, bool>> sendMessage(MessageEntity message,
      MemberEntity userReceiver, MemberEntity myUser) async {
    try {
      final result = await chatRemoteDataSource.sendMessage(
        MessageModel.fromEntity(message),
        MemberModel.fromEntity(userReceiver),
        MemberModel.fromEntity(myUser),
      );

      return Right(result);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChatEntity>> retrieveChat(
      String otherUserId, String myUserId) async {
    try {
      final result =
          await chatRemoteDataSource.retrieveChat(otherUserId, myUserId);
      return Right(result.toEntity());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, String>> createGroupChat(
    List<MemberEntity> groupMembers,
    File imageFile,
    String groupChatName,
  ) async {
    try {
      final List<MemberModel> groupMembersModel =
          groupMembers.map((member) => MemberModel.fromEntity(member)).toList();

      final String createdChatGroupId = await chatRemoteDataSource
          .createGroupChat(groupMembersModel, groupChatName);

      await filesRemoteDataSource.uploadGroupProfileImage(
          imageFile, createdChatGroupId, groupChatName);

      return const Right("Berhasil membuat grup!");
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Either<Failure, Stream<List<MessageEntity>>> getGroupChatMessages(
      String chatId) {
    try {
      final result = chatRemoteDataSource.getGroupChatMessages(chatId);
      return Right(result
          .map((event) => event.map((chats) => chats.toEntity()).toList()));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, String>> sendGroupMessage(
      String groupChatId, MessageEntity message) async {
    try {
      final result = await chatRemoteDataSource.sendGroupMessage(
        groupChatId,
        MessageModel.fromEntity(message),
      );

      return Right(result);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
