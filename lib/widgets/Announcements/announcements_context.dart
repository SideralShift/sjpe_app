import 'package:app/models/announcement.dart';
import 'package:app/services/announcement_service.dart';
import 'package:flutter/material.dart';

class AnnouncementsContext extends ChangeNotifier {
  List<Announcement> announcements = [];

  getAnnouncementsInfo() async {
    announcements = await AnnouncementService.getAllAnnouncements();
    notifyListeners();
  }

  addAnnouncement() async{
    announcements.add(announcements.first);
    notifyListeners();
  }
}
