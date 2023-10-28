// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      id: json['id'] as int?,
      name: json['name'] as String,
      members: (json['members'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      leader: json['leader'] == null
          ? null
          : UserModel.fromJson(json['leader'] as Map<String, dynamic>),
      coLeader: json['coLeader'] == null
          ? null
          : UserModel.fromJson(json['coLeader'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'members': instance.members.map((e) => e.toJson()).toList(),
      'leader': instance.leader?.toJson(),
      'coLeader': instance.coLeader?.toJson(),
    };
