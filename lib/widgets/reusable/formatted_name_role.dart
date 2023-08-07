import 'package:app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormattedNameRole extends StatelessWidget {
  final User user;
  final double fontSize;

  FormattedNameRole({required this.user, this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${user.person?.name} ${user.person?.lastName}',
          style: GoogleFonts.roboto(
              fontSize: fontSize, fontWeight: FontWeight.w600),
        ),
        Text(
          ' - ${user.mainRole}',
          style: GoogleFonts.roboto(fontSize: fontSize, color: Colors.black54),
        )
      ],
    );
  }
}
