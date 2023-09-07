// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnouncementAttachment _$AnnouncementAttachmentFromJson(
        Map<String, dynamic> json) =>
    AnnouncementAttachment(
      announcementId: json['announcementId'] as int?,
      attachment:
          Attachment.fromJson(json['attachment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnnouncementAttachmentToJson(
        AnnouncementAttachment instance) =>
    <String, dynamic>{
      'announcementId': instance.announcementId,
      'attachment': instance.attachment.toJson(),
    };
