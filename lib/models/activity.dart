import 'package:app/models/activity_cat.dart';
import 'package:app/models/place_cat.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
part 'activity.g.dart';

@JsonSerializable(explicitToJson: true)
class Activity {
  int? id;
  String title;
  DateTime date;
  ActivityCat? activityCat;
  PlaceCat? placeCat;

  Activity({this.id, required this.title, required this.date});

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);

  static List<List<Activity>> groupActivitiesByDay(List<Activity> activities) {
    
    Map<String, List<Activity>> groupedMap = {};

    for (Activity activity in activities) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(activity.date);

      if (!groupedMap.containsKey(formattedDate)) {
        groupedMap[formattedDate] = [];
      }

      groupedMap[formattedDate]!.add(activity);
    }

    return groupedMap.values.toList();
  }
}
