import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';

abstract class FilesRepository {
  Future<Either<Failure, String>> uploadImageProfile(File image, String userId);
}
