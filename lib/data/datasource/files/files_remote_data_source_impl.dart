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
        await ref.getDownloadURL().then((image) async {
          await firebaseFirestore
              .collection('users')
              .doc(userId)
              .update({'imgProfile': image});
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

  @override
  Future<String> uploadGroupProfileImage(
      File imageFile, String groupChatId, String groupName) async {
    try {
      final filePath = imageFile.absolute.path;
      File? compressedImage =
          await ManageImages.imageCompress(File(filePath), groupChatId);
      final String? fileName = compressedImage?.path.split('/').last;

      final Reference storageReference = firebaseStorage
          .ref()
          .child('group/$groupChatId/groupProfile/$fileName');

      final UploadTask uploadTask = storageReference.putFile(imageFile);

      await uploadTask.whenComplete(() async {
        final String imageUrl = await storageReference.getDownloadURL();

        await firebaseFirestore.collection('chats').doc(groupChatId).update({
          'groupData':
              GroupDataModel(groupName: groupName, groupPicture: imageUrl)
                  .toMap()
        });
      });
      return 'Successfully uploaded group profile image!';
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: e.message,
      );
    }
  }
}
