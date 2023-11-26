import 'dart:convert';
import 'package:app/models/group_schedule.dart';
import 'package:app/utils/env_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GroupScheduleService {
  static Future<List<GroupSchedule>> getGroupSchedulesByWorkPeriod(int workPeriodId) async {
    String baseUrl = '${dotenv.env[EnvConstants.sjpeApiServer]}'; // Replace with your actual API base URL
    String endpoint = '/group-schedules?workPeriod=$workPeriodId';

    // Combines the base URL with the endpoint and query parameters
    Uri uri = Uri.parse('$baseUrl$endpoint');
    
    // Perform the HTTP GET request
    http.Response response = await http.get(uri);
    
    // Check if the response is successful
    if (response.statusCode == 200) {
      // Decode the response body
      List<dynamic> decodedJson = jsonDecode(utf8.decode(response.bodyBytes));
      
      // Map the JSON to a list of GroupSchedule objects
      return decodedJson.map((json) => GroupSchedule.fromJson(json)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception or return an empty list.
      throw Exception('Failed to load group schedules');
    }
  }
}
