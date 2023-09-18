import 'package:app/models/person.dart';
import 'package:app/models/role.dart';
import 'package:app/utils/classes/storage_image.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
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

  //Util fields, these are not originally part of the model
  @JsonKey(includeFromJson: false, includeToJson: false)
  StorageImage? profilePictureImage;

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
