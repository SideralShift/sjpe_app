import 'package:app/models/announcement_attachment.dart';
import 'package:app/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'announcement.g.dart';

@JsonSerializable(explicitToJson: true)
class Announcement {
  int? id;
  UserModel? user;
  String body;
  String? title;
  DateTime? createdAt;
  List<AnnouncementAttachment> attachments;

  Announcement(
      {this.id,
      this.user,
      required this.body,
      this.title,
      this.createdAt,
      required this.attachments});

  factory Announcement.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);
}
