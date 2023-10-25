import 'package:app/models/city.dart';
import 'package:app/models/state.dart';
import 'package:json_annotation/json_annotation.dart';
part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  String details;
  int postalCode;
  City city;
  State state;

  Address(
      {required this.details,
      required this.postalCode,
      required this.city,
      required this.state});

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
