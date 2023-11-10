// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_cat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityCat _$ActivityCatFromJson(Map<String, dynamic> json) => ActivityCat(
      id: json['id'] as int?,
      title: json['title'] as String,
      categoryColor: json['categoryColor'] as String,
    );

Map<String, dynamic> _$ActivityCatToJson(ActivityCat instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'categoryColor': instance.categoryColor,
    };
