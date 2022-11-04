import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ManageImages {
  static Future<File?> imageCompress(File file, String userId) async {
    final String newPath = path.join((await getTemporaryDirectory()).path,
        '${userId}_${DateTime.now()}${path.extension(file.absolute.path)}');

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      newPath,
      minHeight: 400,
      minWidth: 300,
      quality: 80,
    );

    return result;
  }

  static Future<XFile?> imageFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    return image;
  }

  static Future<XFile?> imageFromCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    return image;
  }
}
