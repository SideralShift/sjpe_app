import 'dart:typed_data';

class StorageAsset {
  Uint8List data;
  String path;

  StorageAsset({required this.data, required this.path});
}