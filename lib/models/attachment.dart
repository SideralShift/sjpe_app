import 'dart:typed_data';

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
  XFile? file;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Uint8List? data;

  Attachment({this.id, this.filename, this.extension, this.url, this.file, this.data});

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);

  factory Attachment.fromXFile(XFile file, String path) => Attachment(file: file,
      filename: file.name, extension: file.name.split('.').last, url: path);
  
  Future<void> loadData() async {
    data = await file?.readAsBytes();
  }

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
}
