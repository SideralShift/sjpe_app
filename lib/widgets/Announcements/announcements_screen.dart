import 'package:app/models/person.dart';
import 'package:app/models/user.dart';
import 'package:app/services/announcement_service.dart';
import 'package:app/widgets/Announcements/announcement_card.dart';
import 'package:app/widgets/Announcements/announcements_context.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/models/announcement.dart';

class AnnouncementScreenController extends StatefulWidget {
  final AnnouncementsContext announcementsState;

  AnnouncementScreenController({required this.announcementsState});
  @override
  State<StatefulWidget> createState() => AnnouncementScreenState();
}

class AnnouncementScreenState extends State<AnnouncementScreenController> with AutomaticKeepAliveClientMixin<AnnouncementScreenController>{
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    widget.announcementsState.updateAnnouncementsInfo();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnnouncementsScreen(
      announcements: widget.announcementsState.announcements,
    );
  }
}

class AnnouncementsScreen extends StatelessWidget {
  final List<Announcement> announcements;

  AnnouncementsScreen({required this.announcements});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.98,
          child: Column(
            children: announcements.map((announcement) => AnnouncementCard(announcement: announcement)).toList(),
          ),
        ),
      ),
    );
  }
}
