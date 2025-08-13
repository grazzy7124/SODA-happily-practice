import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ver1/color.dart';

class Calendar extends StatefulWidget {
  final String userID;
  const Calendar({super.key, required this.userID});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  /// 날짜별 감정 아이콘 경로 저장
  Map<DateTime, String> _emotionsMap = {};

  @override
  void initState() {
    super.initState();
    _loadMonthEmotions(_focusedDay);
  }

  /// emotion 값에 따라 이미지 경로 반환
  String _getEmotionAsset(double emotion) {
    if (emotion <= -8) {
      return 'assets/images/emotions/emotion1.png';
    } else if (emotion <= -3) {
      return 'assets/images/emotions/emotion2.png';
    } else if (emotion <= 2) {
      return 'assets/images/emotions/emotion3.png';
    } else if (emotion <= 7) {
      return 'assets/images/emotions/emotion4.png';
    } else {
      return 'assets/images/emotions/emotion5.png';
    }
  }

  /// 해당 달의 emotions 데이터 불러오기
  Future<void> _loadMonthEmotions(DateTime month) async {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0, 23, 59, 59);

    final snap = await FirebaseFirestore.instance
        .collection('emotions')
        .where('userID', isEqualTo: widget.userID)
        .where(
          'createdAt',
          isGreaterThanOrEqualTo: Timestamp.fromDate(firstDayOfMonth),
        )
        .where(
          'createdAt',
          isLessThanOrEqualTo: Timestamp.fromDate(lastDayOfMonth),
        )
        .get();

    final map = <DateTime, String>{};
    for (final doc in snap.docs) {
      final data = doc.data();
      final emotionValue = (data['emotion'] as num).toDouble();
      final createdAt = (data['createdAt'] as Timestamp).toDate();
      final dateKey = DateTime(createdAt.year, createdAt.month, createdAt.day);

      map[dateKey] = _getEmotionAsset(emotionValue);
    }

    setState(() {
      _emotionsMap = map;
    });
  }

  Widget _buildDayCell(DateTime day) {
    final asset = _emotionsMap[DateTime(day.year, day.month, day.day)];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5.9),
        const SizedBox(width: 4),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            '${day.day}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
        if (asset != null) ...[
          const SizedBox(height: 4),
          Image.asset(asset, width: 30),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      height: 600,
      child: Card(
        color: Colors.white,
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
          calendarStyle: const CalendarStyle(
            tablePadding: EdgeInsets.only(left: 20, right: 20),
            cellAlignment: Alignment.topLeft,
            // 선택했을 때 시각적 변화 없애기
            selectedDecoration: BoxDecoration(color: Colors.transparent),
            selectedTextStyle: TextStyle(color: Colors.black), // 기본과 동일
            isTodayHighlighted:
                false, // today도 별도 하이라이트 끔(원하면 true로 두고 todayBuilder에서 동일 UI)
            tableBorder: TableBorder(),
          ),
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
            _loadMonthEmotions(focusedDay);
          },
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, _) => _buildDayCell(day),

            todayBuilder: (context, day, _) => _buildDayCell(day),

            // 선택된 날도 "완전히 동일"하게 그림 → 탭해도 아무 변화 없음
            selectedBuilder: (context, day, _) => _buildDayCell(day),

            // (선택) outsideBuilder도 동일하게 그리면, 이전/다음 달 날짜에도 이모지가 있으면 보이게 할 수 있음
            outsideBuilder: (context, day, _) => Opacity(
              opacity: 0.5, // 달 바깥 날짜는 반투명으로만
              child: _buildDayCell(day),
            ),
          ),
        ),
      ),
    );
  }
}
