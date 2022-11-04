import 'package:chatqu/app/app.dart';

abstract class FilesRemoteDataSource {
  Future<String> uploadImageProfile(File file, String userId);
}
