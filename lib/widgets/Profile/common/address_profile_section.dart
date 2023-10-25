import 'package:app/models/user.dart';
import 'package:app/utils/app_colors.dart';
import 'package:app/widgets/reusable/readonly_textrow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressProfileSection extends StatelessWidget {
  UserModel user;

  AddressProfileSection({required this.user});

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
              ReadOnlyTextRow(
                  label: 'Direccion', text: user.person.address?.details),
              ReadOnlyTextRow(
                  label: 'Codigo Postal',
                  text: user.person.address?.postalCode.toString()),
              ReadOnlyTextRow(
                  label: 'Ciudad', text: user.person.address?.city.cityName),
              ReadOnlyTextRow(
                  label: 'Estado', text: user.person.address?.state.stateName),
            ],
          ),
        ));
  }
}
