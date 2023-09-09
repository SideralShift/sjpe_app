import 'package:app/widgets/Birthdays/birthday_cards.dart';
import 'package:flutter/material.dart';
import 'package:app/models/user.dart';
import 'package:app/services/user_service.dart';

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
    usersFuture = UserService.getUsersBirthdays();
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
            List<UserModel> users = snapshot.data!; //final list User
            users = UserService.orderBirthdays(users);
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final userBirthDate = user.person?.birthdate;
                final isBirthdayToday = userBirthDate?.day == currentDate.day &&
                    userBirthDate?.month == currentDate.month;

                if (isBirthdayToday) {
                  return BirthdayBoyCard(user: user);
                } else {
                  return BirthdayCard(user: user);
                }
              },
            );
          }
        },
      ),
    );
  }
}
