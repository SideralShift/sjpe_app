import 'package:app/models/announcement.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/widgets/reusable/formatted_name_role.dart';
import 'package:app/widgets/reusable/user_avatar.dart';
import 'package:flutter/material.dart';

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;

  const AnnouncementCard({required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(25.0), // Adjust the radius as needed
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  UserAvatarFromStorage(user: announcement.user!, path: (announcement.user?.profilePictureUrl)!,)
                ],
              ),
              _buildDetail()
            ],
          ),
        ));
  }

  Widget _buildDetail() {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          FormattedNameRole(user: announcement.user!),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    announcement.body,
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.justify,
                  ))
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateUtil.formatDate(announcement.createdAt!, 'es'),
                  style: const TextStyle(fontSize: 9),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
