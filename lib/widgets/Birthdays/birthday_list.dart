import 'package:app/models/user.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/utils/months_utils.dart';
import 'package:app/widgets/reusable/user_profile_avatar.dart';
import 'package:flutter/material.dart';
class BirthdaysListWidget extends StatelessWidget {
  final Map<int, List<UserModel>> groupedBirthdays;

  BirthdaysListWidget({Key? key, required this.groupedBirthdays}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groupedBirthdays.length,
      itemBuilder: (BuildContext context, int index) {
        int month = groupedBirthdays.keys.elementAt(index);
        List<UserModel> users = groupedBirthdays[month]!;
        String monthName = NumberToMonths.getMonthName(month) ?? 'Unknown Month';

        return ExpansionTile(
          title: Text(monthName),
          children: users.map((UserModel user) {
            return ListTile(
              title: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: UserProfileAvatar(user: user),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.person.getFullName()),
                        Text(
                          DateUtil.formatBirthdate(user.person.birthdate!, 'es'),
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Add other user details here
            );
          }).toList(),
        );
      },
    );
  }
}