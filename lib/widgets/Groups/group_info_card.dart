import 'package:app/models/group.dart';
import 'package:app/models/group_schedule.dart';
import 'package:app/models/user.dart';
import 'package:app/widgets/reusable/user_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/app_colors.dart';
import 'package:app/widgets/reusable/user_avatar.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupInfoCard extends StatelessWidget {
  Group group;
  bool isMainUserGroup;
  int minMemberAvatars = 3;
  final GroupSchedule groupSchedule;

  // Define styles constants
  static const double cardPadding = 22.0;
  static const double avatarPaddingTop = 20.0;
  static const double avatarSectionPaddingTop = 6.0;
  static const double overlappedAvatarsWidth = 120.0;
  static const double overlappedAvatarsHeight = 40.0;

  GroupInfoCard(
      {required this.group,
      this.isMainUserGroup = false,
      required this.groupSchedule});

  buildOverlapedAvatars() {
    List<Widget> avatarWidgets = [];

    for (var i = 0; i < minMemberAvatars; i++) {
      if (i <= group.members.length - 1) {
        avatarWidgets.add(UserProfileAvatar(
          radius: 18,
          user: group.members[i],
        ));
      } else {
        avatarWidgets.add(UserAvatar(radius: 18));
      }
    }

    int remainingMembersNum = group.members.length - minMemberAvatars;
    remainingMembersNum = remainingMembersNum < 0 ? 0 : remainingMembersNum;

    avatarWidgets.add(CircleAvatar(
      child: Text('$remainingMembersNum+'),
    ));

    return OverlappingAvatars(
      overlapDistance: 25,
      avatars: avatarWidgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/complete/group', arguments: group);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              AppStyles.cardsBorderRadius), // Adjust the radius as needed
        ),
        child: Padding(
          padding: EdgeInsets.all(cardPadding),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    group.name,
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                  ),
                  Text(
                    groupSchedule.role.description!,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300)),
                  )
                ],
              ),
              Row(
                children: [
                  isMainUserGroup
                      ? Text(
                          'Tu grupo',
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.orange)),
                        )
                      : Container()
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: avatarPaddingTop),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('Lider'),
                        Padding(
                          padding:
                              EdgeInsets.only(top: avatarSectionPaddingTop),
                          child: group.leader != null
                              ? UserProfileAvatar(
                                  radius: 18, user: group.leader!)
                              : UserAvatar(),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text('Colider'),
                        Padding(
                          padding:
                              EdgeInsets.only(top: avatarSectionPaddingTop),
                          child: group.coLeader != null
                              ? UserProfileAvatar(
                                  radius: 18,
                                  user: group.coLeader!,
                                )
                              : UserAvatar(),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text('Integrantes'),
                        Padding(
                            padding:
                                EdgeInsets.only(top: avatarSectionPaddingTop),
                            child: Container(
                                height: overlappedAvatarsHeight,
                                width: overlappedAvatarsWidth,
                                child: buildOverlapedAvatars()))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OverlappingAvatars extends StatelessWidget {
  final List<Widget> avatars;
  final double overlapDistance;

  OverlappingAvatars({
    required this.avatars,
    this.overlapDistance = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: avatars.asMap().entries.map((entry) {
        int idx = entry.key;
        Widget widget = entry.value;
        return Positioned(
          left: overlapDistance * idx,
          child: widget,
        );
      }).toList(),
    );
  }
}
