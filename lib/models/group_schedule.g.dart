// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupSchedule _$GroupScheduleFromJson(Map<String, dynamic> json) =>
    GroupSchedule(
      group: Group.fromJson(json['group'] as Map<String, dynamic>),
      role: Role.fromJson(json['role'] as Map<String, dynamic>),
      workPeriod:
          WorkPeriod.fromJson(json['workPeriod'] as Map<String, dynamic>),
      month: json['month'] as int?,
      year: json['year'] as int?,
    );

Map<String, dynamic> _$GroupScheduleToJson(GroupSchedule instance) =>
    <String, dynamic>{
      'group': instance.group.toJson(),
      'role': instance.role.toJson(),
      'workPeriod': instance.workPeriod.toJson(),
      'month': instance.month,
      'year': instance.year,
    };
