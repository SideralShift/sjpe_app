import 'package:app/widgets/Announcements/announcement_card.dart';
import 'package:app/widgets/Announcements/announcement_shimmer.dart';
import 'package:app/widgets/Announcements/announcements_context.dart';
import 'package:flutter/material.dart';
import 'package:app/models/announcement.dart';

class AnnouncementScreenController extends StatefulWidget {
  final AnnouncementsContext announcementsState;

  const AnnouncementScreenController({super.key, required this.announcementsState});
  @override
  State<StatefulWidget> createState() => AnnouncementScreenState();
}

class AnnouncementScreenState extends State<AnnouncementScreenController>
    with AutomaticKeepAliveClientMixin<AnnouncementScreenController> {
  @override
  bool get wantKeepAlive => true;
  late Future<void> announcementsFutue;

  @override
  void initState() {
    super.initState();
    announcementsFutue = widget.announcementsState.getAnnouncementsInfo();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FutureBuilder(
      future: announcementsFutue,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AnnouncementsScreen(
            retrievingAnnouncements: true,
            isPublishing: false,
            announcements: [],
          );
        } 
        else if (snapshot.connectionState == ConnectionState.done && snapshot.hasError) {
          return const Center(child: Text('Oops algo salio mal, intentalo de nuevo'),);
        }
        else if (snapshot.connectionState == ConnectionState.done && widget.announcementsState.announcements.isNotEmpty) {
          return AnnouncementsScreen(
            retrievingAnnouncements:
                false,
            isPublishing: widget.announcementsState.isPublishing,
            announcements: widget.announcementsState.announcements,
          );
        } else {
          return const Center(child: Text('No hay datos para mostrar'),);
        }
      },
    );
  }
}

class AnnouncementsScreen extends StatelessWidget {
  final List<Announcement> announcements;
  final bool retrievingAnnouncements;
  final bool isPublishing;

  const AnnouncementsScreen(
      {super.key, required this.announcements,
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
      shownWidgets.insert(0, const AnnouncementShimmer());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: FractionallySizedBox(
        widthFactor: 0.98,
        child: ListView(
          children: shownWidgets,
        ),
      ),
    );
  }
}
