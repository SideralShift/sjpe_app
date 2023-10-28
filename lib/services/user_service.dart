import 'dart:convert';
import 'dart:io';
import 'package:app/models/role.dart';
import 'package:app/models/user.dart';
import 'package:app/services/storage_service.dart';
import 'package:app/utils/env_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<UserModel?> getUserByIdSJPE(String id) async {
    String url = '${dotenv.env[EnvConstants.sjpeApiServer]}/user/$id';
    http.Response response = await http.get(Uri.parse(url));
    if (response.body != '') {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<List<UserModel>> getUsersBirthdays() async {
    try {
      final response = await http.get(Uri.parse(
          '${dotenv.env[EnvConstants.sjpeApiServer]}/users/birthdays?month=${DateTime.now().month}'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
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

  static List<UserModel> orderBirthdays(List<UserModel> users) {
    // Filtrar usuarios que cumplen anos
    final todayUsers = users.where((user) {
      final userBirthDate = user.person?.birthdate;
      return userBirthDate?.day == DateTime.now().day &&
          userBirthDate?.month == DateTime.now().month;
    }).toList();

    // Filtrar usuarios que no cumplen anos
    final otherUsers = users.where((user) {
      final userBirthDate = user.person?.birthdate;
      return userBirthDate?.day != DateTime.now().day ||
          userBirthDate?.month != DateTime.now().month;
    }).toList();

    // Combinar las dos listas ordenadas
    final sortedUsers = [...todayUsers, ...otherUsers];

    return sortedUsers;
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
