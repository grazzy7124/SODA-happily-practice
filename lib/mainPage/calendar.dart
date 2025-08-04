import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:ver1/main.dart';


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
    return 
    TableCalendar(
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
        formatButtonVisible: false
      ),
      calendarFormat: CalendarFormat.month,
      // 테두리
      calendarStyle: CalendarStyle(
        cellAlignment: AlignmentGeometry.xy(-1, -1),
        selectedTextStyle: TextStyle(color: Colors.red),
        selectedDecoration: BoxDecoration(
          color: Colors.transparent
        ),
        isTodayHighlighted: false,
        tableBorder: TableBorder(
          horizontalInside: BorderSide(
            color: Colors.black
          ),
          verticalInside: BorderSide(
            color: Colors.black
          ),
          bottom: BorderSide(
            color: Colors.black
          ),
          borderRadius: BorderRadius.circular(5)
        ),
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
    );
  }
}