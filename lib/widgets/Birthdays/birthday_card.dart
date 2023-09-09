import 'package:flutter/material.dart';
import 'package:app/models/user.dart';
import '../../models/person.dart';
import 'package:app/widgets/reusable/user_avatar.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({Key? key}) : super(key: key);

  @override
  BirthdayScreenState createState() => BirthdayScreenState();
}

class BirthdayScreenState extends State<BirthdayScreen> {
  @override
  Widget build(BuildContext context) {
    final List<UserModel> users = [
      UserModel(person: Person(id: 1, name: 'Roel'), roles: []),
      UserModel(person: Person(id: 2, name: 'Renato'), roles: []),
    ];
    return Scaffold(
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                UserAvatarFromStorage(
                  user: user,
                  path: user.profilePictureUrl ??
                      '', // Reemplaza con la ruta correcta
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '¡Feliz Cumpleaños!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${user.person?.name} cumple años hoy.',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
