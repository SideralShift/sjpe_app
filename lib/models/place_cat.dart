import 'package:app/models/address.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'place_cat.g.dart';

@JsonSerializable(explicitToJson: true)
class PlaceCat {
  int? id;
  String name;
  Address address;

  PlaceCat({this.id, required this.name, required this.address});

  factory PlaceCat.fromJson(Map<String, dynamic> json) => _$PlaceCatFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceCatToJson(this);
}
