import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:ver1/color.dart';
import 'package:ver1/mainPage/myDiary/mydiaryFirstType.dart';

class Calendar extends StatefulWidget {
  final double emotion;
  const Calendar({super.key, required this.emotion});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  late double emotion;
  String emotionLocation = '';

  void getEmotionLocation(double emotion) {
    if (emotion <= -8) {
      emotionLocation = 'assets/images/emotions/emotion1.png';
    } else if (emotion <= -3) {
      emotionLocation = 'assets/images/emotions/emotion2.png';
    } else if (emotion <= 2) {
      emotionLocation = 'assets/images/emotions/emotion3.png';
    } else if (emotion <= 7) {
      emotionLocation = 'assets/images/emotions/emotion4.png';
    } else {
      emotionLocation = 'assets/images/emotions/emotion5.png';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emotion = widget.emotion;
    getEmotionLocation(emotion);
  }

  @override
  void didUpdateWidget(covariant Calendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    getEmotionLocation(emotion);
    print(
      'didUpdateWidget 호출: old=${oldWidget.emotion}, new=${widget.emotion}',
    ); // 로그 추가
    if (oldWidget.emotion != widget.emotion) {
      setState(() {
        emotion = widget.emotion;
      });
    }
  }

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
            isTodayHighlighted: true,
            tableBorder: TableBorder(),
          ),

          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay; // update `_focusedDay` here as well

              // Navigator push 해야 됨!!!!!!!!!!!!!!!!!
              // Navigator.push(
              //   context, 
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return MydiaryFirstType(
              //         date: date, 
              //         selectedIndex: selectedIndex, 
              //         secondText: secondText, 
              //         thirdText: thirdText, 
              //         isReleased: 
              //       )
              //     },
              //   )
              // )
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          calendarBuilders: CalendarBuilders(
            selectedBuilder: (context, day, focusedDay) {
              final isToday = isSameDay(day, DateTime.now());
              if (isToday) {
                // 오늘 날짜이면서 선택됨: todayBuilder처럼 표시
                return Container(
                  // color: Colors.amber,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.9),
                      Align(
                        alignment: AlignmentGeometry.xy(-0.62, -1),
                        child: Text(
                          '${day.day}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Image.asset(emotionLocation, width: 30),
                    ],
                  ),
                );
              } else {
                // 일반 선택된 날짜
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${day.day}',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
            },

            // ✅ 오늘 날짜이지만 선택되지 않은 경우
            todayBuilder: (context, day, focusedDay) {
              return Container(
                // color: Colors.amber,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 5.9),
                    Align(
                      alignment: AlignmentGeometry.xy(-0.62, -1),
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Image.asset(emotionLocation, width: 30),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
