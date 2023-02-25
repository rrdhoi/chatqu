import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/repositories/files_repository.dart';

class FilesRepositoryImpl extends FilesRepository {
  final FilesRemoteDataSource filesRemoteDataSource;
  FilesRepositoryImpl({required this.filesRemoteDataSource});

  @override
  Future<Either<Failure, String>> uploadImageProfile(
      File image, String userId) async {
    try {
      final result =
          await filesRemoteDataSource.uploadImageProfile(image, userId);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }
}
