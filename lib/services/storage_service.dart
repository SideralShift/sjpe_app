import 'dart:io';
import 'dart:typed_data';

import 'package:app/models/attachment.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static UploadTask saveToFolder(Uint8List bytes, String path) {
    Reference ref = FirebaseStorage.instance.ref(path);
    return ref.putData(bytes);
  }
}
