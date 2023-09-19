import 'dart:convert';
import 'dart:io';

import 'package:app/models/announcement.dart';
import 'package:app/models/announcement_attachment.dart';
import 'package:app/services/storage_service.dart';
import 'package:app/utils/classes/storage_image.dart';
import 'package:app/utils/env_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AnnouncementService {
  static Future<List<Announcement>> getAllAnnouncements() async {
    String url = '${dotenv.env[EnvConstants.sjpeApiServer]}/announcements';
    http.Response response = await http.get(Uri.parse(url));
    if (response.body != '') {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((announcement) => Announcement.fromJson(announcement))
          .toList();
    }
    return [];
  }

  static Future<Announcement> createAnnouncement(
      Announcement announcement) async {
    String url = '${dotenv.env[EnvConstants.sjpeApiServer]}/announcement';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    http.Response response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(announcement.toJson()));
    if (response.statusCode != HttpStatus.created) {
      throw Error();
    }
    return Announcement.fromJson(json.decode(response.body));
  }

  static Future<void> deleteAnnouncement(int id) async {
    String url = '${dotenv.env[EnvConstants.sjpeApiServer]}/announcement/$id';
    http.Response response = await http.delete(Uri.parse(url));
    if (response.statusCode != HttpStatus.noContent) {
      throw Error();
    }
  }

  static loadAnnAtchsFromStorage(Announcement announcement) async {
    List<Future<void>> loadImageJobs = [];

    for (AnnouncementAttachment announcementAttachment
        in announcement.attachments) {
      Future<void> job = _getAnnouncementAttachmentData(announcementAttachment)
          .catchError((error) {
        print(error);
      });
      loadImageJobs.add(job);
    }

    await Future.wait(loadImageJobs);
  }

  static Future<void> _getAnnouncementAttachmentData(
      AnnouncementAttachment announcementAttachment) async {
    StorageImage? imageFromStorage = await StorageService.getImage(
        path: announcementAttachment.attachment.url!);
    announcementAttachment.attachment.storageObject = imageFromStorage;
  }
}
