import 'package:app/utils/months_utils.dart';
import 'package:flutter/material.dart';

class CalendarPicker extends StatefulWidget {
  final ValueNotifier<int> controller;

  CalendarPicker({Key? key, required this.controller}) : super(key: key);

  @override
  _CalendarPickerState createState() => _CalendarPickerState();
}

class _CalendarPickerState extends State<CalendarPicker> {
  int currentMonth = DateTime.now().month;

  @override
  void initState() {
    super.initState();
    // Si quieres que el widget escuche los cambios del controlador
    widget.controller.addListener(_updateMonthFromController);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateMonthFromController);
    super.dispose();
  }

  void _updateMonthFromController() {
    if (widget.controller.value != currentMonth) {
      setState(() {
        currentMonth = widget.controller.value;
      });
    }
  }

  void _nextMonth() {
    if (currentMonth < 12) {
      widget.controller.value++;
    } else {
      widget.controller.value = 1; // Vuelve a Enero después de Diciembre
    }
  }

  void _previousMonth() {
    if (currentMonth > 1) {
      widget.controller.value--;
    } else {
      widget.controller.value = 12; // Vuelve a Diciembre después de Enero
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentMonth = widget.controller.value;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: _previousMonth,
        ),
        SizedBox(
          width: 120,
          child: Text(
            NumberToMonths.getMonthName(currentMonth) ?? 'Mes Desconocido',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: _nextMonth,
        ),
      ],
    );
  }
}
