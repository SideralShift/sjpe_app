import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable(explicitToJson: true)
class City{
  int id;
  String cityName;

  City({required this.id, required this.cityName});

  factory City.fromJson(Map<String, dynamic> json) =>
      _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}