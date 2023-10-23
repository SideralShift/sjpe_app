// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      userName: json['userName'] as String?,
      password: json['password'] as String?,
      person: Person.fromJson(json['person'] as Map<String, dynamic>),
      mainRole: json['mainRole'] == null
          ? null
          : Role.fromJson(json['mainRole'] as Map<String, dynamic>),
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      profilePictureUrl: json['profilePictureUrl'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'password': instance.password,
      'person': instance.person.toJson(),
      'mainRole': instance.mainRole?.toJson(),
      'roles': instance.roles,
      'profilePictureUrl': instance.profilePictureUrl,
    };
