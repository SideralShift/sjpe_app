import 'package:flutter/material.dart';

class DayWidget extends StatelessWidget {
  final String dayNumber;
  final String dayAbbreviation;

  DayWidget({required this.dayNumber, required this.dayAbbreviation});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          dayNumber,
          style: TextStyle(
            fontSize: 32, // Adjust the font size as needed
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          dayAbbreviation,
          style: TextStyle(
            fontSize: 16, // Adjust the font size as needed
          ),
        ),
      ],
    );
  }
}