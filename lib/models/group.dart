import 'package:app/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'group.g.dart';

@JsonSerializable(explicitToJson: true)
class Group {
  final int? id;

  final String name;

  @JsonKey(defaultValue: [])
  List<UserModel> members = [];
  UserModel? leader;
  UserModel? coLeader;

  Group({
    this.id,
    required this.name,
    required this.members,
    this.leader,
    this.coLeader
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
