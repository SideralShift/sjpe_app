import 'package:app/models/user.dart';
import 'package:app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/reusable/user_avatar.dart';
import 'package:app/utils/months_utils.dart';

class BirthdayBoyCard extends StatelessWidget {
  UserModel user;

  BirthdayBoyCard({super.key, required this.user});

  Widget build(BuildContext context) {
    final userBirthDate = user.person?.birthdate;
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.cardsBorderRadius),
      ),
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserAvatar.fromStorage(
              image: user.profilePictureImage!,
              radius: 30,
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
                '${userBirthDate?.day} de ${NumberToMonths.getMonthName(userBirthDate?.month ?? 1)}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BirthdayCard extends StatelessWidget {
  UserModel user;

  BirthdayCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final userBirthDate = user.person?.birthdate;
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.cardsBorderRadius),
      ),
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                UserAvatar.fromStorage(
                  image: user.profilePictureImage!,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.person?.name ?? '',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          '${userBirthDate?.day} de ${NumberToMonths.getMonthName(userBirthDate?.month ?? 1)}',
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
}
