import 'package:flutter/material.dart';
import 'package:app/models/user.dart';
import 'package:app/widgets/reusable/user_avatar.dart';
import 'package:app/services/user_service.dart';
import 'package:app/utils/months_utils.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({Key? key}) : super(key: key);

  @override
  BirthdayScreenState createState() => BirthdayScreenState();
}

class BirthdayScreenState extends State<BirthdayScreen> {
  late Future<List<UserModel>> usersFuture;
  DateTime currentDate = DateTime.now(); // Obtener la fecha y hora actual

  @override
  void initState() {
    super.initState();
    usersFuture = UserService().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<UserModel>>(
        future: usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No se encontraron usuarios.');
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final userBirthDate = user.person?.birthdate;
                final isBirthdayToday = userBirthDate?.day == currentDate.day &&
                    userBirthDate?.month == currentDate.month;

                if (isBirthdayToday) {
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          UserAvatarFromStorage(
                            user: user,
                            path: user.profilePictureUrl ?? '',
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            '¡Feliz Cumpleaños, ${user.person?.name}!',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              '${userBirthDate?.day} de ${NumberToMonths.getMonthName(userBirthDate?.month ?? 1)}.',
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              UserAvatarFromStorage(
                                user: user,
                                path: user.profilePictureUrl ?? '',
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      user.person?.name ?? '',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        '${userBirthDate?.day} de ${NumberToMonths.getMonthName(userBirthDate?.month ?? 1)}.',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
