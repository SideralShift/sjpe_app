import 'package:app/models/group_schedule.dart';
import 'package:app/models/role.dart';
import 'package:app/models/work_period.dart';
import 'package:app/services/group_schedule_service.dart';
import 'package:app/utils/app_colors.dart';
import 'package:app/utils/months_utils.dart';
import 'package:app/utils/roles_utils.dart';
import 'package:app/widgets/tool_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class CompleteRolScreen extends StatelessWidget {
  List<GroupSchedule> groupSchedules;

  CompleteRolScreen({required this.groupSchedules});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RolTable(
        groupSchedules: groupSchedules,
        workPeriod: WorkPeriod(
            startDate: DateTime(2023, 4), endDate: DateTime(2024, 3)),
      ),
      appBar: AppBar(
          elevation: 3,
          backgroundColor: AppStyles.mainBackgroundColor,
          foregroundColor: Colors.black,
          title: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Text('Rol de trabajo anual',
                style: GoogleFonts.openSans(
                    color:
                        Colors.black, // Change this color to your desired color
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
          )),
    );
  }
}

/// The class containing the TableView for the sample application.
class RolTable extends StatefulWidget {
  final WorkPeriod workPeriod;
  final List<GroupSchedule> groupSchedules;

  /// Creates a screen that demonstrates the TableView widget.
  const RolTable(
      {super.key, required this.workPeriod, required this.groupSchedules});

  @override
  State<RolTable> createState() => _RolTableState();
}

class _RolTableState extends State<RolTable> {
  late final ScrollController _verticalController = ScrollController();
  late final List<int> months;
  int _rowCount = 13;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    months = _getMonthsFromWorkPeriod();
  }

  @override
  Widget build(BuildContext context) {
    return TableView.builder(
      pinnedRowCount: 1,
      pinnedColumnCount: 1,
      verticalDetails:
          ScrollableDetails.vertical(controller: _verticalController),
      cellBuilder: _buildCell,
      columnCount: 7,
      columnBuilder: _buildColumnSpan,
      rowCount: _rowCount,
      rowBuilder: _buildRowSpan,
    );
  }

  GroupSchedule? findGroupScheduleByRoleAndMonth(Role role, int month) {
    // Assuming you have a list of group schedules
    for (GroupSchedule schedule in widget.groupSchedules) {
      if (schedule.role.id == role.id && schedule.month == month) {
        return schedule;
      }
    }
    return null;
  }

  List<int> _getMonthsFromWorkPeriod() {
    DateTime startDate = widget.workPeriod.startDate;
    DateTime endDate = widget.workPeriod.endDate;
    if (endDate.isBefore(startDate)) {
      throw ArgumentError('End date must be after start date');
    }

    List<int> months = [];
    DateTime currentMonth = DateTime(startDate.year, startDate.month);

    while (currentMonth.isBefore(endDate) ||
        currentMonth.isAtSameMomentAs(endDate)) {
      months.add(currentMonth.month);
      // If it's December, the next month is January of the next year
      if (currentMonth.month == 12) {
        currentMonth = DateTime(currentMonth.year + 1, 1);
      } else {
        currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
      }
    }

    return months;
  }

  Widget _buildCell(BuildContext context, TableVicinity vicinity) {
    Widget innerWidget = Container();

    if (vicinity.column == 0 && vicinity.row > 0) {
      innerWidget = Text(
        NumberToMonths.getMonthName(months[vicinity.row - 1]) ?? '',
        style: const TextStyle(fontWeight: FontWeight.w600),
      );
    } else if (vicinity.column > 0 && vicinity.row == 0) {
      innerWidget = Text(
        RolesUtil.getCommissionByIndex(vicinity.column - 1)?.description ?? '',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
      );
    } else if (vicinity.column > 0 && vicinity.row > 0) {
      Role? columnRole = RolesUtil.getCommissionByIndex(vicinity.column - 1);
      int rowMonth = months[vicinity.row - 1];

      GroupSchedule? groupSchedule = findGroupScheduleByRoleAndMonth(columnRole!, rowMonth);

      innerWidget = Text((groupSchedule?.group.id.toString())!);
    }

    return Container(
      decoration: BoxDecoration(
          color: vicinity.row == 0 || vicinity.column == 0 ? Colors.blue[400] : null,
          border: const Border(
              bottom: BorderSide(color: Colors.black),
              right: BorderSide(color: Colors.black))),
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Center(
          child: innerWidget,
        ),
      ),
    );
  }

  TableSpan _buildColumnSpan(int index) {
    return TableSpan(
      extent: index == 0
          ? const FixedTableSpanExtent(100)
          : const FixedTableSpanExtent(110),
      onEnter: (_) => print('Entered column $index'),
      recognizerFactories: <Type, GestureRecognizerFactory>{
        TapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
          () => TapGestureRecognizer(),
          (TapGestureRecognizer t) =>
              t.onTap = () => print('Tap column $index'),
        ),
      },
    );
  }

  TableSpan _buildRowSpan(int index) {
    return TableSpan(
      extent: const FixedTableSpanExtent(60),
      recognizerFactories: <Type, GestureRecognizerFactory>{
        TapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
          () => TapGestureRecognizer(),
          (TapGestureRecognizer t) => t.onTap = () => print('Tap row $index'),
        ),
      },
    );
  }
}
