// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      id: json['id'] as int?,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
    )
      ..activityCat = json['activityCat'] == null
          ? null
          : ActivityCat.fromJson(json['activityCat'] as Map<String, dynamic>)
      ..placeCat = json['placeCat'] == null
          ? null
          : PlaceCat.fromJson(json['placeCat'] as Map<String, dynamic>);

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date.toIso8601String(),
      'activityCat': instance.activityCat?.toJson(),
      'placeCat': instance.placeCat?.toJson(),
    };
