import 'package:app/models/announcement.dart';
import 'package:app/models/announcement_attachment.dart';
import 'package:app/models/attachment.dart';
import 'package:app/services/announcement_service.dart';
import 'package:app/services/storage_service.dart';
import 'package:app/utils/classes/storage_image.dart';
import 'package:flutter/material.dart';

class AnnouncementsContext extends ChangeNotifier {
  List<Announcement> announcements = [];
  bool isPublishing = false;
  bool retrievingAnnouncements = false;

  getAnnouncementsInfo() async {
    retrievingAnnouncements = true;
    announcements = await AnnouncementService.getAllAnnouncements();

    List<Future<void>> loadJobs = [];

    for (Announcement announcement in announcements) {
      loadJobs.add(AnnouncementService.loadAnnAtchsFromStorage(announcement));
    }

    await Future.wait(loadJobs);

    retrievingAnnouncements = false;
    notifyListeners();
  }

  addAnnouncement(Announcement announcement) async {
    announcements.insert(0, announcement);
  }

  startPublishing(
      Announcement newAnnouncement, Future<void> publishmentJob) async {
    isPublishing = true;
    notifyListeners();

    await publishmentJob;

    await addAnnouncement(newAnnouncement);
    isPublishing = false;
    notifyListeners();
  }
}
