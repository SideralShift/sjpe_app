import 'package:app/models/group.dart';
import 'package:app/models/group_schedule.dart';
import 'package:app/models/user.dart';
import 'package:app/services/group_schedule_service.dart';
import 'package:app/services/group_service.dart';
import 'package:app/services/user_service.dart';
import 'package:flutter/material.dart';

class GroupsContext extends ChangeNotifier {
  List<Group> groups = [];
  List<GroupSchedule> groupSchedules = [];
  int mainUserGroupId = 0;
  Future<void>? fetchingDataTask;

  _fetchGroupsAndRoles(UserModel loggedUser) async {
    try {
      groupSchedules =
          await GroupScheduleService.getGroupSchedulesByWorkPeriod(1);
      groups = await GroupService.getAllGroupsMembers();
      int foundMainUserGroupId = 0;

      await loadMemberPP(groups);

      groups.forEach(setGroupLeadersProfilePic);

      for (Group group in groups) {
        _removeLeaders(group);
        if (group.members.contains(loggedUser)) {
          groups.remove(group);
          groups.insert(0, group);
          foundMainUserGroupId = group.id!;
          break;
        }
      }

      mainUserGroupId = foundMainUserGroupId;
    } catch (e) {
      print('Error fetching groups and roles: $e');
      // Handle or show error as necessary
    }
  }

  _removeLeaders(Group group) {
    List<UserModel> removedUsers = [];

    for (UserModel member in group.members) {
      if (member.id == group.leader?.id || member.id == group.coLeader?.id) {
        removedUsers.add(member);
      }
    }

    for (UserModel removedUser in removedUsers) {
      group.members.remove(removedUser);
    }
  }

  startFetchingData(UserModel loggedUser) {
    fetchingDataTask = _fetchGroupsAndRoles(loggedUser);
    notifyListeners();
  }

  loadMemberPP(groups) {
    List<Future<void>> ppTasks = [];

    for (var group in groups) {
      ppTasks.addAll(getPPTasksGroup(group));
    }

    return Future.wait(ppTasks);
  }

  List<Future> getPPTasksGroup(Group group) {
    getPPTaskMember(member) =>
        UserService.loadUserProfilePicture(member).catchError((error) {});
    return group.members.map(getPPTaskMember).toList();
  }

  setGroupLeadersProfilePic(Group group) {
    if (group.leader != null) {
      UserModel member =
          group.members.firstWhere((member) => member.id == group.leader?.id);
      group.leader?.profilePictureImage = member.profilePictureImage;
    }

    if (group.coLeader != null) {
      UserModel member =
          group.members.firstWhere((member) => member.id == group.coLeader?.id);
      group.coLeader?.profilePictureImage = member.profilePictureImage;
    }
  }
}
