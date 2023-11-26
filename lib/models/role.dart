import 'package:app/models/department.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'role.g.dart';

@JsonSerializable(explicitToJson: true)
class Role {
  //TODO: Complete person structure
  int? id;
  String? description;
  Department department;

  Role({@required this.id, @required this.description, required this.department});

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}
