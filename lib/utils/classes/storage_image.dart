import 'package:app/utils/classes/storage_asset.dart';

class StorageImage extends StorageAsset {
  double? width;
  double? height;

  StorageImage({required data, required path, this.width, this.height})
      : super(data: data, path: path);
}
