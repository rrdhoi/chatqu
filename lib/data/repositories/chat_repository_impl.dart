import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatRemoteDataSource chatRemoteDataSource;

  ChatRepositoryImpl({required this.chatRemoteDataSource});

  @override
  Either<Failure, Stream<List<ChatEntity>>> getAllChat() {
    try {
      final result = chatRemoteDataSource.getAllChat();
      return Right(
          result.map((event) => event.map((e) => e.toEntity()).toList()));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Either<Failure, Stream<List<MessageEntity>>> getChatMessages(String chatId) {
    try {
      final result = chatRemoteDataSource.getChatMessages(chatId);
      return Right(
          result.map((event) => event.map((e) => e.toEntity()).toList()));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, String>> sendMessage(
      MessageEntity message, String otherUserId) async {
    try {
      final result = await chatRemoteDataSource.sendMessage(
          MessageModel.fromEntity(message), otherUserId);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, ChatEntity>> checkChatExist(String otherUserId) async {
    try {
      final result = await chatRemoteDataSource.checkChatExist(otherUserId);
      return Right(result.toEntity());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }
}
