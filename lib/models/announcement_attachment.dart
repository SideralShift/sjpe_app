import 'package:app/models/attachment.dart';
import 'package:json_annotation/json_annotation.dart';
part 'announcement_attachment.g.dart';

@JsonSerializable(explicitToJson: true)
class AnnouncementAttachment {
  int? announcementId;
  Attachment attachment;

  AnnouncementAttachment({this.announcementId, required this.attachment});

  factory AnnouncementAttachment.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementAttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementAttachmentToJson(this);
}
