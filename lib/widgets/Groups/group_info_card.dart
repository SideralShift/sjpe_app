import 'package:app/models/group.dart';
import 'package:app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/app_colors.dart';
import 'package:app/widgets/reusable/user_avatar.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupInfoCard extends StatelessWidget {
  Group group;
  bool isMainUserGroup;
  int minMemberAvatars = 3;

  GroupInfoCard({required this.group, this.isMainUserGroup = false});

  buildOverlapedAvatars() {
    List<Widget> avatarWidgets = [];

    for (var i = 0; i < minMemberAvatars; i++) {

      if (i <= group.members.length - 1) {
        avatarWidgets.add(UserAvatar.fromStorage(
          radius: 18,
            image: group.members[i].profilePictureImage,
          ));
      } else {
        avatarWidgets.add(UserAvatar(radius: 18));
      }
    }

    int remainingMembersNum = group.members.length - minMemberAvatars;
    remainingMembersNum = remainingMembersNum < 0 ? 0 : remainingMembersNum;
    
    avatarWidgets.add(CircleAvatar(child: Text('$remainingMembersNum+'),));


    return OverlappingAvatars(
      overlapDistance: 25,
      avatars: avatarWidgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            AppStyles.cardsBorderRadius), // Adjust the radius as needed
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  group.name,
                  style: GoogleFonts.roboto(
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                ),
                Text(
                  'PENDING',
                  style: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
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
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('Lider'),
                      UserAvatar.fromStorage(
                        radius: 18,
                        image: group.leader?.profilePictureImage,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text('Colider'),
                      UserAvatar.fromStorage(
                        radius: 18,
                        image: group.coLeader?.profilePictureImage,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Integrantes'),
                      Container(
                          height: 40,
                          width: 120,
                          child: buildOverlapedAvatars())
                    ],
                  )
                ],
              ),
            ),
          ],
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