import 'package:json_annotation/json_annotation.dart';

part 'work_period.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkPeriod {
  int? id;
  DateTime startDate;
  DateTime endDate;
  bool isCurrent;

  WorkPeriod({
    this.id,
    required this.startDate,
    required this.endDate,
    this.isCurrent = false,
  });

  factory WorkPeriod.fromJson(Map<String, dynamic> json) => _$WorkPeriodFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserModelToJson`.
  Map<String, dynamic> toJson() => _$WorkPeriodToJson(this);

}