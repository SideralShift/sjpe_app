import 'dart:convert';

import 'package:app/models/announcement.dart';
import 'package:app/utils/env_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AnnouncementService {
  static Future<List<Announcement>> getAllAnnouncements() async {
    String url = '${dotenv.env[EnvConstants.sjpeApiServer]}/announcements';
    http.Response response = await http.get(Uri.parse(url));
    if (response.body != '') {
      return (jsonDecode(response.body) as List)
          .map((announcement) => Announcement.fromJson(announcement))
          .toList();
    }
    return [];
  }
}
