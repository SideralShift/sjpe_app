import 'package:app/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:app/models/activity.dart';
import 'package:app/widgets/reusable/day_widget.dart';
import 'package:app/widgets/reusable/timeline_painter.dart';
import 'package:app/widgets/Calendar/activity_tile.dart';

class ActivitiesSection extends StatelessWidget {
  final List<Activity> activities;
  final DateTime date;
  final double tileHeight;

  ActivitiesSection(
      {required this.activities, required this.date, required this.tileHeight});

  @override
  Widget build(BuildContext context) {
    String dayNumber = "${date.day}";
    String dayAbbreviation = DateUtil.formatDayAbbreviation(date, 'es');
    double height = tileHeight * activities.length + 30;

    return Container(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: tileHeight,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: SizedBox(
                  width: 45,
                  child: DayWidget(
                    dayNumber: dayNumber,
                    dayAbbreviation: dayAbbreviation,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomPaint(
                  painter: TimelinePainter(dotHeight: tileHeight),
                  child: Container(
                    width: 20,
                    // Remove the height to allow filling up the space
                  ),
                ),
                Expanded(
                  child: Column(
                    children: activities
                        .map((e) => ActivityTile(
                              activity: e,
                              tileHeight: tileHeight,
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
