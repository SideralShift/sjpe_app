import 'package:app/models/user.dart';
import 'package:app/utils/general_utils.dart';
import 'package:app/widgets/reusable/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel user;
  final String heroTag;

  const ProfileHeader({super.key, required this.user, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: heroTag,
          child: UserAvatar.fromUser(
            radius: 55,
            user: user,
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Flexible(
              child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              '${user.person.getNames()} ${user.person.lastName}',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w500)),
            ),
          ))
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            '${GeneralUtils.capitalizeFirstLetter(user.mainRole?.description)}',
            style: GoogleFonts.roboto(
                textStyle:
                    const TextStyle(fontSize: 18, color: Colors.black87)),
          ),
        ),
      ],
    );
  }
}
