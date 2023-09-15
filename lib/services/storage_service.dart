import 'dart:typed_data';
import 'package:app/utils/classes/storage_asset.dart';
import 'package:app/utils/classes/storage_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class StorageService {
  static UploadTask saveToFolder(StorageAsset asset) {
    Reference ref = FirebaseStorage.instance.ref(asset.path);
    return ref.putData(asset.data);
  }

  static Future<StorageImage?> getImage(
      {required String path}) async {
    StorageImage? image;
    String url =
        await FirebaseStorage.instance.ref().child(path).getDownloadURL();

    FileInfo fileInfo = await DefaultCacheManager().downloadFile(url);

    if (fileInfo.file.existsSync()) {
      Uint8List imageData = fileInfo.file.readAsBytesSync();
      final metadata = await decodeImageFromList(imageData);

      image = StorageImage(
        data: imageData,
        path: path,
        width: metadata.width.toDouble(),
        height: metadata.height.toDouble(),
      );
    }

    return image;
  }
}
