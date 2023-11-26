import 'package:app/widgets/Calendar/activities_section.dart';
import 'package:app/widgets/reusable/calendar_picker.dart';
import 'package:flutter/material.dart';
import 'package:app/services/activity_service.dart';
import 'package:app/models/activity.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  Future<List<Activity>>? activitiesFuture;
  final double tileHeight = 90;
  final ValueNotifier<int> monthController =
      ValueNotifier<int>(DateTime.now().month);

  @override
  void initState() {
    super.initState();
    activitiesFuture =
        ActivityService.getActivitiesByMonth(monthController.value);
    monthController.addListener(updateActivities);
  }

  updateActivities() {
    setState(() {
      activitiesFuture =
          ActivityService.getActivitiesByMonth(monthController.value);
    });
  }

  calculateCurrentActivityPosition(List<List<Activity>> groupedActivities) {
    double position = 0;
    double offset = 30;

    if (groupedActivities.isNotEmpty &&
        DateTime.now().month == groupedActivities[0].first.date.month) {
      for (int i = 0; i <= groupedActivities.length - 1; i++) {
        if (i == groupedActivities.length - 1 ||
            groupedActivities[i + 1].first.date.day > DateTime.now().day) {
          return position;
        }

        position += groupedActivities[i].length * tileHeight + offset;

        if (groupedActivities[i + 1].first.date.day == DateTime.now().day) {
          return position;
        }
      }
    }

    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10, right: 5, left: 5),
      child: Column(
        children: [
          CalendarPicker(controller: monthController),
          Expanded(
              child: FutureBuilder<List<Activity>>(
            future: activitiesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No se encontraron actividades'));
              } else {
                List<List<Activity>> groupedActivities =
                    Activity.groupActivitiesByDay(snapshot.data!);

                return ListView(
                  controller: ScrollController(
                      initialScrollOffset:
                          calculateCurrentActivityPosition(groupedActivities)),
                  children: groupedActivities
                      .map((activities) => ActivitiesSection(
                            tileHeight: tileHeight,
                            activities: activities,
                            date: activities[0].date,
                          ))
                      .toList(),
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
