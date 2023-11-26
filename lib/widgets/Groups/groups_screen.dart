import 'package:app/models/group.dart';
import 'package:app/models/group_schedule.dart';
import 'package:app/models/user.dart';
import 'package:app/services/group_schedule_service.dart';
import 'package:app/services/group_service.dart';
import 'package:app/services/user_service.dart';
import 'package:app/widgets/Groups/group_info_card.dart';
import 'package:app/widgets/Groups/groups_context.dart';
import 'package:app/widgets/app_context.dart';
import 'package:flutter/material.dart';

class GroupsScreen extends StatefulWidget {
  final AppContext appContext;
  final GroupsContext groupsContext;

  GroupsScreen({required this.appContext, required this.groupsContext});

  @override
  State<StatefulWidget> createState() {
    return GroupScreenState();
  }
}

class GroupScreenState extends State<GroupsScreen>
    with AutomaticKeepAliveClientMixin<GroupsScreen> {
  @override
  void initState() {
    super.initState();
    widget.groupsContext.startFetchingData(widget.appContext.loggedUser);
  }

  GroupSchedule? findRoleByGroupAndMonth(Group group, int month) {
    // Assuming you have a list of group schedules
    for (GroupSchedule schedule in widget.groupsContext.groupSchedules) {
      if (schedule.group.id == group.id && schedule.month == month) {
        return schedule;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    super.build(
        context); // With AutomaticKeepAliveClientMixin, you need to call super.build

    return FutureBuilder(
      future: widget.groupsContext
          .fetchingDataTask, // This is the future that FutureBuilder waits on
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.connectionState == ConnectionState.done) {
          return FractionallySizedBox(
            widthFactor: 0.98,
            child: ListView(
              children: widget.groupsContext.groups
                  .map((e) => GroupInfoCard(
                    groupSchedule: findRoleByGroupAndMonth(e, DateTime.now().month)!,
                        group: e,
                        isMainUserGroup:
                            e.id == widget.groupsContext.mainUserGroupId,
                      ))
                  .toList(),
            ),
          );
        } else {
          return Center(child: Text('No groups found'));
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
