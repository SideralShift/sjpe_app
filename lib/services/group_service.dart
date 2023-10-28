import 'dart:convert';
import 'dart:io';
import 'package:app/models/group.dart';
import 'package:app/utils/env_constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GroupService {
  static Future<List<Group>> getAllGroupsMembers() async {
    String url = '${dotenv.env[EnvConstants.sjpeApiServer]}/groups/members';
    http.Response response = await http.get(Uri.parse(url));
    if (response.body != '' && response.statusCode == HttpStatus.ok) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((group) => Group.fromJson(group))
          .toList();
    }
    return [];
  }
}
