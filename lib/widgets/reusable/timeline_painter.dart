import 'package:flutter/material.dart';

class TimelinePainter extends CustomPainter {
  double? dotHeight;

  TimelinePainter({this.dotHeight});
  @override
  void paint(Canvas canvas, Size size) {
    dotHeight = dotHeight ?? size.height / 2;

    final paintLine = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2;

    // Draw the line
    canvas.drawLine(Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height), paintLine);

    // Draw the circle
    final paintCircle = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 2, dotHeight! / 2), 4,
        paintCircle); // Radius of circle
    
    // Draw the circle
    final paintOutterCircle = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(Offset(size.width / 2, dotHeight! / 2), 6,
        paintOutterCircle); // Radius of circle
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}