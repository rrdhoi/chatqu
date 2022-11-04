import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/repositories/files_repository.dart';

class UploadImageProfileUseCase {
  final FilesRepository _filesRepository;

  UploadImageProfileUseCase(this._filesRepository);

  Future<Either<Failure, String>> execute(File image, String userId) async =>
      await _filesRepository.uploadImageProfile(image, userId);
}
