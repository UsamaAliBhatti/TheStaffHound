import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalenderHelper extends StatefulWidget {
  TableCalenderHelper({Key? key, required this.getRangeDates})
      : super(key: key);
  Function(DateTime, DateTime) getRangeDates;

  @override
  State<TableCalenderHelper> createState() => _TableCalenderHelperState();
}

class _TableCalenderHelperState extends State<TableCalenderHelper> {
  DateTime? selectedDay = DateTime.now();
  DateTime? focusedDay = DateTime.now();
  DateTime? rangeStart = DateTime.now();
  DateTime? rangeEnd = DateTime.now();
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOn;
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        rangeStartDay: rangeStart!,
        rangeEndDay: rangeEnd!,
        rangeSelectionMode: rangeSelectionMode,
        startingDayOfWeek: StartingDayOfWeek.monday,
        headerStyle:
            const HeaderStyle(titleCentered: true, formatButtonVisible: false),
        focusedDay: focusedDay!,
        firstDay: DateTime.now(),
        selectedDayPredicate: (day) {
          return isSameDay(focusedDay, day);
        },
        onDaySelected: ((selectedDay, focusedDay) {
          if (!isSameDay(selectedDay, selectedDay)) {
            setState(() {
              selectedDay = selectedDay;
              focusedDay = focusedDay;
              rangeStart = null; // Important to clean those
              rangeEnd = null;
              rangeSelectionMode = RangeSelectionMode.toggledOff;
            });
          }
        }),
        onRangeSelected: ((start, end, focusedDay) {
          if (start != null && end != null) {
            setState(() {
              selectedDay = null;
              focusedDay = focusedDay;
              rangeStart = start;
              rangeEnd = end;

              rangeSelectionMode = RangeSelectionMode.toggledOn;
            });

            widget.getRangeDates(start, end);
          }
        }),
        onPageChanged: (focusedDay) {
          // dashboardController.focusedDay.value = focusedDay;
        },
        lastDay: DateTime.utc(2100, 3, 30));
  }
}
