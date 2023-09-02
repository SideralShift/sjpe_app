import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static UploadTask saveToFolder(Uint8List bytes, String fileName, String pathToFolder) {
    Reference ref =
        FirebaseStorage.instance.ref('$pathToFolder/$fileName');
    return ref.putData(bytes);
  }
}
