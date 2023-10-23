import 'package:json_annotation/json_annotation.dart';
part 'person.g.dart';

@JsonSerializable(explicitToJson: true)
class Person {
  //TODO: Complete person structure
  int? id;
  String? name;
  String? middleName;
  String? lastName;
  String? email;
  String? phoneNumber;
  DateTime? birthdate;
  int? age;

  Person(
      {this.id,
      required this.name,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.birthdate,
      this.age});

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);

  getShortName()=> '$name ${getFirstLastName()}';

  getFullName()=> '$name $lastName';

  getFirstLastName() => lastName?.split(' ').first;

  getNames()=> '$name $middleName';
}
