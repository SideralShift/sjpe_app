// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_period.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkPeriod _$WorkPeriodFromJson(Map<String, dynamic> json) => WorkPeriod(
      id: json['id'] as int?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      isCurrent: json['isCurrent'] as bool? ?? false,
    );

Map<String, dynamic> _$WorkPeriodToJson(WorkPeriod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'isCurrent': instance.isCurrent,
    };
