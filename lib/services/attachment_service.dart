import 'dart:convert';
import 'dart:io';
import 'package:app/models/announcement_attachment.dart';
import 'package:app/services/storage_service.dart';
import 'package:app/utils/classes/storage_image.dart';
import 'package:app/utils/env_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AttachmentService {
  static Future<AnnouncementAttachment> createAnnouncementAttachment(
      AnnouncementAttachment attachment) async {
    String url =
        '${dotenv.env[EnvConstants.sjpeApiServer]}/announcement/${attachment.announcementId}/attachment';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    http.Response response = await http.post(Uri.parse(url),
        body: json.encode(attachment.attachment.toJson()), headers: headers);

    if (response.statusCode != HttpStatus.created) {
      throw Error();
    }

    return AnnouncementAttachment.fromJson(json.decode(response.body));
  }

  static Future<StorageImage?> getAnnAttFromStorage(
      AnnouncementAttachment announcementAttachment) async {
    StorageImage? imageFromStorage = await StorageService.getImage(
        path: announcementAttachment.attachment.url!);
    return imageFromStorage;
  }
}
