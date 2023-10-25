import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable(explicitToJson: true)
class State{
  String id;
  String stateName;

  State({required this.id, required this.stateName});

  factory State.fromJson(Map<String, dynamic> json) =>
      _$StateFromJson(json);

  Map<String, dynamic> toJson() => _$StateToJson(this);
}