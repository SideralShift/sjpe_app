import 'package:app/models/group.dart';
import 'package:app/models/role.dart';
import 'package:app/models/work_period.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_schedule.g.dart';

@JsonSerializable(explicitToJson: true)
class GroupSchedule {
  Group group;
  Role role;
  WorkPeriod workPeriod;
  int? month;
  int? year;

  GroupSchedule({
    required this.group,
    required this.role,
    required this.workPeriod,
    this.month,
    this.year
  });

  factory GroupSchedule.fromJson(Map<String, dynamic> json) => _$GroupScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$GroupScheduleToJson(this);
}
