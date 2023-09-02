import 'package:app/models/person.dart';
import 'package:app/models/role.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class UserModel {
  //TODO: complete user structure
  final String? id;
  final String? userName;
  final String? password;
  final Person? person;
  final Role? mainRole;

  @JsonKey(defaultValue: [])
  final List<String> roles;
  String? profilePictureUrl;

  UserModel(
      {this.id,
      this.userName,
      this.password,
      required this.person,
      this.mainRole,
      required this.roles,
      this.profilePictureUrl});

      factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserModelToJson`.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}