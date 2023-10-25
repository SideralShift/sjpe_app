
import 'package:app/utils/classes/storage_asset.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';
part 'attachment.g.dart';

@JsonSerializable(explicitToJson: true)
class Attachment {
  int? id;
  String? filename;
  String? extension;
  String? url;

  //Util fields, these are not originally part of the model
  @JsonKey(includeFromJson: false, includeToJson: false)
  StorageAsset? storageObject;

  Attachment(
      {this.id, this.filename, this.extension, this.url});

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);

  factory Attachment.fromXFile(XFile file,
          {required String path}) =>
      Attachment(
          filename: file.name,
          extension: file.name.split('.').last,
          url: path);

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
}
