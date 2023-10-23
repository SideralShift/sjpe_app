import 'package:app/models/user.dart';
import 'package:app/utils/general_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormattedNameRole extends StatelessWidget {
  final UserModel user;
  final double fontSize;

  FormattedNameRole({required this.user, this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          user.person.getShortName(),
          style: GoogleFonts.roboto(
              fontSize: fontSize, fontWeight: FontWeight.w600),
        ),
        Text(
          ' - ${GeneralUtils.capitalizeFirstLetter(user.mainRole?.description)}',
          style: GoogleFonts.roboto(fontSize: fontSize, color: Colors.black54),
        )
      ],
    );
  }
}
