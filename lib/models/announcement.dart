import 'package:app/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'announcement.g.dart';

@JsonSerializable()
class Announcement {
  UserModel? user;
  String body;
  String? title;
  DateTime? createdAt;

  Announcement({this.user, required this.body, this.title, this.createdAt});

  factory Announcement.fromJson(Map<String, dynamic> json) => _$AnnouncementFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);
}
