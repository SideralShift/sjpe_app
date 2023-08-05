import 'package:app/models/announcement.dart';
import 'package:app/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;
  final double _headerFontSize = 14;

  const AnnouncementCard({required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 22,
                    foregroundImage: NetworkImage(announcement.user!.photoUrl!),
                  )
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
          Row(
            children: [
              Text(
                '${announcement.user?.person?.name} ${announcement.user?.person?.lastName}',
                style: GoogleFonts.roboto(
                    fontSize: _headerFontSize, fontWeight: FontWeight.w600),
              ),
              Text(
                ' - ${announcement.user?.mainRole}',
                style: GoogleFonts.roboto(
                    fontSize: _headerFontSize, color: Colors.black54),
              )
            ],
          ),
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
                  style: const TextStyle(fontSize: 8),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
