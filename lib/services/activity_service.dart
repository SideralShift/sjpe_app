import 'dart:convert';
import 'dart:io';
import 'package:app/models/activity.dart';
import 'package:app/models/announcement_attachment.dart';
import 'package:app/services/storage_service.dart';
import 'package:app/utils/classes/storage_image.dart';
import 'package:app/utils/env_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ActivityService {
  static Future<List<Activity>> getActivities() async {
    String url = '${dotenv.env[EnvConstants.sjpeApiServer]}/activities';

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode != HttpStatus.ok) {
      throw Error();
    }

    return (jsonDecode(utf8.decode(response.bodyBytes)) as List)
        .map((activity) => Activity.fromJson(activity))
        .toList();
  }

  static Future<List<Activity>> getActivitiesByMonth(int month) async {
    String url =
        '${dotenv.env[EnvConstants.sjpeApiServer]}/activities?month=$month';

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode != HttpStatus.ok) {
      if (response.statusCode == HttpStatus.notFound) {
        return [];
      } else {
        throw Error();
      }
    }

    return (jsonDecode(utf8.decode(response.bodyBytes)) as List)
        .map((activity) => Activity.fromJson(activity))
        .toList();
  }
}
