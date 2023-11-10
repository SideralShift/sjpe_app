import 'package:app/models/address.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'activity_cat.g.dart';

@JsonSerializable(explicitToJson: true)
class ActivityCat {
  int? id;
  String title;
  String categoryColor;


  ActivityCat({this.id, required this.title, required this.categoryColor});

  factory ActivityCat.fromJson(Map<String, dynamic> json) => _$ActivityCatFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityCatToJson(this);
}
