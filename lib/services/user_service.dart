import 'dart:convert';
import 'dart:io';
import 'package:app/models/role.dart';
import 'package:app/models/user.dart';
import 'package:app/services/storage_service.dart';
import 'package:app/utils/env_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<List<UserModel>> getAllUsers() async {
    String url = '${dotenv.env[EnvConstants.sjpeApiServer]}/users';
    http.Response response = await http.get(Uri.parse(url));
    if (response.body != '') {
      final List<dynamic> jsonData =
          jsonDecode(utf8.decode(response.bodyBytes));
      List<UserModel> users =
          jsonData.map((element) => UserModel.fromJson(element)).toList();
      return users;
    }
    return [];
  }

  static Future<UserModel?> getUserByIdSJPE(String id) async {
    String url = '${dotenv.env[EnvConstants.sjpeApiServer]}/user/$id';
    http.Response response = await http.get(Uri.parse(url));
    if (response.body != '') {
      return UserModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>);
    }
    return null;
  }

  static Future<List<UserModel>> getUsersBirthdays() async {
    try {
      final response = await http.get(Uri.parse(
          '${dotenv.env[EnvConstants.sjpeApiServer]}/users/birthdays'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData =
            json.decode(utf8.decode(response.bodyBytes));
        final List<UserModel> users = jsonData.map((data) {
          return UserModel.fromJson(data);
        }).toList();

        return users;
      } else {
        throw Exception(
            'Error en la solicitud a la API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al obtener usuarios desde la API: $e');
    }
  }

  static Map<int, List<UserModel>> groupUsersBirthdays(List<UserModel> users) {
    Map<int, List<UserModel>> grouped = {};

    for (var user in users) {
      // Get the birth month of the user
      int birthMonth = (user.person.birthdate?.month)!;

      // Check if the month already exists in the map
      if (!grouped.containsKey(birthMonth)) {
        // If not, create a new list for this month
        grouped[birthMonth] = [];
      }

      // Add the user to the appropriate list
      grouped[birthMonth]!.add(user);
    }

    return grouped;
  }

  static Future<void> loadUserProfilePicture(UserModel user) async {
    user.profilePictureImage =
        await StorageService.getImage(path: user.profilePictureUrl!);
  }

  static Future<List<Role>> getUserRoles(UserModel user) async {
    String url =
        '${dotenv.env[EnvConstants.sjpeApiServer]}/user/${user.id}/roles';
    http.Response response = await http.get(Uri.parse(url));

    if (response.body != '' && response.statusCode == HttpStatus.ok) {
      List<dynamic> unSerializedRoles =
          (jsonDecode(response.body) as List<dynamic>)
              .map((userRole) => userRole['role'])
              .toList();
      return unSerializedRoles.map((e) => Role.fromJson(e)).toList();
    }

    return [];
  }
}
