import 'dart:convert';

import 'package:app/models/group.dart';
import 'package:app/models/role.dart';
import 'package:app/models/user.dart';
import 'package:app/services/group_service.dart';
import 'package:app/services/user_service.dart';
import 'package:app/utils/app_colors.dart';
import 'package:app/widgets/Announcements/announcements_context.dart';
import 'package:app/widgets/Groups/group_info_card.dart';
import 'package:app/widgets/app_context.dart';
import 'package:app/widgets/reusable/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupsScreen extends StatefulWidget {
  final AppContext appContext;

  GroupsScreen({required this.appContext});

  @override
  State<StatefulWidget> createState() {
    return GroupScreenState();
  }
}

class GroupScreenState extends State<GroupsScreen>
    with AutomaticKeepAliveClientMixin<GroupsScreen> {
  List<Group> groups = [];
  int mainUserGroupId = 0;

  @override
  void initState() {
    super.initState();
    _fetchGroupsAndRoles();
  }

  _fetchGroupsAndRoles() async {
    try {
      List<Group> retrievedGroups = await GroupService.getAllGroupsMembers();
      List<Future<void>> profilePicFutures = [];
      int foundMainUserGroupId = 0;

      retrievedGroups.forEach(
          (group) => profilePicFutures.addAll(group.members.map((member) {
                return UserService.loadUserProfilePicture(member);
              })));

      await Future.wait(profilePicFutures);

      retrievedGroups.forEach(setGroupLeadersProfilePic);

      for (Group group in retrievedGroups) {
        if (group.members.contains(widget.appContext.loggedUser)) {
          foundMainUserGroupId = group.id!;
          break;
        }
      }

      setState(() {
        groups = retrievedGroups;
        mainUserGroupId = foundMainUserGroupId;
      }); // Rebuild the widget with the new data.
    } catch (e) {
      print('Error fetching groups and roles: $e');
      // Handle or show error as necessary
    }
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

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.98,
      child: ListView(
        children: groups.map((e) => GroupInfoCard(group: e, isMainUserGroup: e.id == mainUserGroupId,)).toList(),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
