import 'package:app/models/announcement.dart';
import 'package:app/services/announcement_service.dart';
import 'package:flutter/material.dart';

class AnnouncementsContext extends ChangeNotifier {
  List<Announcement> announcements = [];
  bool isPublishing = false;
  bool retrievingAnnouncements = false;

  getAnnouncementsInfo() async {
    retrievingAnnouncements = true;
    announcements = await AnnouncementService.getAllAnnouncements();
    retrievingAnnouncements = false;
    notifyListeners();
  }

  addAnnouncement(Announcement announcement) async{
    announcements.insert(0,announcement);
  }

  startPublishing(Announcement newAnnouncement, Future<void> publishmentFuture) async {
    isPublishing = true;
    notifyListeners();


    publishmentFuture.then((value){
      isPublishing = false;
      addAnnouncement(newAnnouncement);
      notifyListeners();
    });
  }
}
