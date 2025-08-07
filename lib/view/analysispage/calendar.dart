import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      height: 600,
      child: Card(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(20),
        child: TableCalendar(
          locale: 'ko_KR',
          focusedDay: _focusedDay,
          firstDay: DateTime(2020),
          lastDay: DateTime(2030),
          daysOfWeekHeight: 50,
          rowHeight: 70,
          headerStyle: HeaderStyle(
            titleCentered: true,
            titleTextFormatter: (date, locale) {
              return DateFormat('yyyy년 M월', locale).format(date);
            },
            formatButtonVisible: false,
          ),
          calendarFormat: CalendarFormat.month,
          calendarStyle: CalendarStyle(
            tablePadding: EdgeInsets.only(left: 20, right: 20),
            cellAlignment: AlignmentGeometry.xy(-1, -1),
            selectedTextStyle: TextStyle(color: Colors.blueAccent),
            selectedDecoration: BoxDecoration(color: Colors.transparent),
            isTodayHighlighted: false,
            tableBorder: TableBorder(),
          ),

          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay; // update `_focusedDay` here as well
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
      ),
    );
  }
}
