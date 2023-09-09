import 'dart:convert';
import 'package:app/models/user.dart';
import 'package:app/utils/env_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:app/models/person.dart';
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

  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(
          '${dotenv.env[EnvConstants.sjpeApiServer]}/users/birthdays?month=${DateTime.now().month}'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final List<UserModel> users = jsonData.map((data) {
          return UserModel(
            person: Person(
              id: data['person']['id'],
              name: data['person']['name'],
              birthdate: DateTime.parse(data['person']['birthdate']),
            ),
            roles: [], // Agrega los roles si es necesario
          );
        }).toList();

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

        // Ordenar la lista para mostrar primero los que cumplen hoy
        todayUsers.sort((a, b) =>
            a.person?.birthdate
                ?.compareTo(b.person?.birthdate ?? DateTime.now()) ??
            0);

        // Combinar las dos listas ordenadas
        final sortedUsers = [...todayUsers, ...otherUsers];

        return sortedUsers;
      } else {
        throw Exception(
            'Error en la solicitud a la API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al obtener usuarios desde la API: $e');
    }
  }
}
