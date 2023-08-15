import 'package:json_annotation/json_annotation.dart';
part 'person.g.dart';

@JsonSerializable()
class Person {
  //TODO: Complete person structure
  String? name;
  String? lastName;
  String? email;
  String? phoneNumber;

  Person({required this.name, this.lastName, this.email, this.phoneNumber});

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
