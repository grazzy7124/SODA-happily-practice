import 'package:flutter/material.dart';

class Write extends StatelessWidget {
  const Write({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset('assets/Vector.png', width: 9, height: 17),
            ),
          ],
        ),
        backgroundColor: Color(0xffFCFAF5),
      ),
      body: ListView(
        children: [
          Divider(),
          WriteMyProfile(
            main: 'assets/profile1.png',
            name: '고먐미',
            year: '2025',
            month: '7',
            day: '23',
            date: '토',
            photo: 'assets/list/1.png',
            title: '이별한 지 23일',
            text: '너가 없으니 내 행복도 사라졌ㄷr...',
          ),
        ],
      ),
      backgroundColor: Color(0xffFCFAF5),
    );
  }
}

class WriteMyProfile extends StatelessWidget {
  const WriteMyProfile({
    super.key,
    required this.main,
    required this.name,
    required this.year,
    required this.month,
    required this.day,
    required this.date,
    required this.photo,
    required this.title,
    required this.text,
  });

  final String main;
  final String name;
  final String year;
  final String month;
  final String day;
  final String date;
  final String photo;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: ListTile(
            leading: Image.asset(main, width: 45, height: 45),
            title: Text(name, style: TextStyle(fontSize: 21)),
          ),
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('$year년', style: TextStyle(fontSize: 16)),
            Text('$month월', style: TextStyle(fontSize: 16)),
            Text('$day일', style: TextStyle(fontSize: 16)),
            Text('$date요일', style: TextStyle(fontSize: 16)),
            Divider(),
            Text('날씨:', style: TextStyle(fontSize: 16)),
          ],
        ),
        Divider(),
        Image.asset(photo, width: double.infinity, fit: BoxFit.fitWidth),
        Divider(),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text('제목: ', style: TextStyle(fontSize: 16)),
            ),
            Text(title, style: TextStyle(fontSize: 16)),
          ],
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.only(top: 15, left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text, style: TextStyle(fontSize: 15)),
              Text('잘 지내길..ㅜ', style: TextStyle(fontSize: 15)),
              Text('사진처럼 우리가 우리의 시간 안에서', style: TextStyle(fontSize: 15)),
              Text('최선을 다 한 거길.....', style: TextStyle(fontSize: 15)),
              Text('이제 보내주자... 노은아...', style: TextStyle(fontSize: 15)),
              SizedBox(height: 70),
            ],
          ),
        ),
      ],
    );
  }
}
