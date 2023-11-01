import 'package:app/models/user.dart';
import 'package:app/utils/app_colors.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/widgets/reusable/readonly_textrow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonalDataProfileSection extends StatelessWidget {
  UserModel user;

  PersonalDataProfileSection({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              AppStyles.cardsBorderRadius), // Adjust the radius as needed
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ReadOnlyTextRow(label: 'Edad', text: user.person.age.toString()),
              ReadOnlyTextRow(label: 'Bautizado', text: 'SI'),
              ReadOnlyTextRow(label: 'Fecha nacimiento', text: DateUtil.formatBirthdate2(user.person.birthdate, 'es')),
              ReadOnlyTextRow(label: 'Grupo de trabajo', text: 'Grupo 1'),
              ReadOnlyTextRow(label: 'Telefono', text: user.person.phoneNumber),
              ReadOnlyTextRow(label: 'Correo', text: user.person.email)
            ],
          ),
        ));
  }
}
