import 'package:chatqu/app/app.dart';
import 'package:chatqu/data/data.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FilesRemoteDataSourceImpl extends FilesRemoteDataSource {
  final FirebaseStorage firebaseStorage;
  final FirebaseFirestore firebaseFirestore;

  FilesRemoteDataSourceImpl({
    required this.firebaseStorage,
    required this.firebaseFirestore,
  });

  @override
  Future<String> uploadImageProfile(File file, String userId) async {
    try {
      String imagePath = file.path.split('/').last;
      final Reference ref =
          firebaseStorage.ref().child('images_profile/$userId/$imagePath');
      UploadTask task = ref.putFile(file);
      await task.whenComplete(() async {
        await ref.getDownloadURL().then((value) async {
          await firebaseFirestore
              .collection('users')
              .doc(userId)
              .update({'img_profile': value});
        });
      });

      return 'Upload image profile berhasil!';
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: e.message,
      );
    }
  }
}
