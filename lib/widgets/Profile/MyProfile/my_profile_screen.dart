import 'package:app/models/user.dart';
import 'package:app/utils/app_colors.dart';
import 'package:app/utils/general_utils.dart';
import 'package:app/widgets/Profile/common/address_profile_section.dart';
import 'package:app/widgets/Profile/common/personaldata_profile_section.dart';
import 'package:app/widgets/Profile/common/profile_base.dart';
import 'package:app/widgets/Profile/common/profile_header.dart';
import 'package:app/widgets/reusable/readonly_textrow.dart';
import 'package:app/widgets/reusable/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfileScreen extends StatelessWidget {
  final Map<String, dynamic> arguments;

  const MyProfileScreen({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    final UserModel user = arguments['user'];
    return ProfileBase(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: ProfileHeader(
            heroTag: arguments['heroTag'],
            user: user,
          ),
        ),
        FractionallySizedBox(
          widthFactor: 0.9,
          child: Column(children: [
            PersonalDataProfileSection(user: user),
            AddressProfileSection(user: user),
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppStyles
                      .cardsBorderRadius), // Adjust the radius as needed
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Cerrar sesión',
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.red),
                            )),
                        width: double.infinity,
                      )
                    ],
                  ),
                ))
          ]),
        ),
      ],
    );
  }
}
