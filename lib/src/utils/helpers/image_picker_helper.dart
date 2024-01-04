import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kima/src/utils/extensions.dart';

class ImagePickerHelper {
  ImagePickerHelper._();

  static final _picker = ImagePicker();

  /// Image Picker function to get image from camera
  static Future<File?> getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final compressedFile = await compressImage(pickedFile);
      return File(compressedFile!.path);
    }
    return null;
  }

  /// Image Picker function to get image from gallery
  static Future<File?> getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final compressedFile = await compressImage(pickedFile);
      return File(compressedFile!.path);
    }
    return null;
  }

  /// Image Picker function to multiple media from gallery
  static Future<List<File>?> getMultipleMediaFromGallery() async {
    final pickedFiles = await _picker.pickMultipleMedia(imageQuality: 100);

    if (pickedFiles.isNotEmpty) {
      List<File> files = [];
      for (var file in pickedFiles) {
        if (['.gif', '.mp4', '.mov'].contains(file.path.fileType) || File(file.path).lengthSync() < 10000) {
          files.add(File(file.path));
        } else {
          final compressedFile = await compressImage(file);
          files.add(File(compressedFile!.path));
        }
      }
      return files;
    }
    return null;
  }
}

Future<XFile?> compressImage(XFile file) async {
  final filePath = file.path;
  final lastIndex = filePath.lastIndexOf(RegExp(r'.png|.jp'));
  final splitted = filePath.substring(0, (lastIndex));
  final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

  if (lastIndex == filePath.lastIndexOf(RegExp(r'.png'))) {
    final compressedImage = await FlutterImageCompress.compressAndGetFile(
      filePath,
      outPath,
      minWidth: 1000,
      minHeight: 1000,
      quality: 50,
      format: CompressFormat.png,
    );
    return compressedImage;
  } else {
    final compressedImage = await FlutterImageCompress.compressAndGetFile(
      filePath,
      outPath,
      minWidth: 1000,
      minHeight: 1000,
      quality: 50,
    );
    return compressedImage;
  }
}

class CacheManagerHelper {
  CacheManagerHelper._();

  static Future<String?> getImageFromCache(String key) async {
    final file = await DefaultCacheManager().getFileFromCache(key);
    return file?.file.path;
  }

  static Future<void> downloadImageToCache({
    required String path,
    required String key,
  }) async =>
      await DefaultCacheManager().downloadFile(path, key: key);
}
