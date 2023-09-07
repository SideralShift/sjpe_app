import 'package:app/widgets/Announcements/announcement_card.dart';
import 'package:app/widgets/Announcements/announcement_shimmer.dart';
import 'package:app/widgets/Announcements/announcements_context.dart';
import 'package:flutter/material.dart';
import 'package:app/models/announcement.dart';

class AnnouncementScreenController extends StatefulWidget {
  final AnnouncementsContext announcementsState;

  AnnouncementScreenController({required this.announcementsState});
  @override
  State<StatefulWidget> createState() => AnnouncementScreenState();
}

class AnnouncementScreenState extends State<AnnouncementScreenController>
    with AutomaticKeepAliveClientMixin<AnnouncementScreenController> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    widget.announcementsState.getAnnouncementsInfo();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnnouncementsScreen(
      retrievingAnnouncements:
          widget.announcementsState.retrievingAnnouncements,
      isPublishing: widget.announcementsState.isPublishing,
      announcements: widget.announcementsState.announcements,
    );
  }
}

class AnnouncementsScreen extends StatelessWidget {
  final List<Announcement> announcements;
  final bool retrievingAnnouncements;
  final bool isPublishing;

  AnnouncementsScreen(
      {required this.announcements,
      required this.retrievingAnnouncements,
      required this.isPublishing});

  @override
  Widget build(BuildContext context) {
    List<Widget> shownWidgets = retrievingAnnouncements
        ? announcementsPlaceholders
        : <Widget>[
            ...announcements
                .map((announcement) =>
                    AnnouncementCard(announcement: announcement))
                .toList()
          ];

    if (isPublishing) {
      shownWidgets.insert(0, AnnouncementShimmer());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.98,
            child: Column(children: shownWidgets
                //children: ,
                ),
          ),
        ),
      ),
    );
  }
}
