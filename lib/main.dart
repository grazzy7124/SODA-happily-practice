import 'package:flutter/material.dart';
import 'package:ver1/profileedit1.dart';
import 'package:ver1/write.dart';

void main() => runApp(const MaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: ProfileMain(), backgroundColor: Color(0xffFCFAF5)),
    );
  }
}

class ProfileMain extends StatelessWidget {
  const ProfileMain({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: ProfileMy(
            main: 'assets/profile1.png',
            name: '고먐미',
            friend: '11',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Edit()),
              );
            },
          ),
        ),
        SizedBox(height: 10),
        Divider(),
        Padding(
          padding: EdgeInsets.only(left: 30),
          child: Text('내가 쓴 일기', style: TextStyle(fontSize: 16)),
        ),
        Divider(),
        ProfileList(
          photo: 'assets/list/1.png',
          title: '이별한지 23일',
          text: '너가 없으니 내 행복도 사라졌다',
          text2: '잘지내길...ㅜ',
          date: '2025.7.30 비공개',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Write()),
            );
          },
        ),
        Divider(),
        ProfileList(
          photo: 'assets/list/2.png',
          title: '기말고사 후기',
          text: '재수강 각 떴다',
          text2: '하.......',
          date: '2025.7.18 비공개',
        ),
        Divider(),
        ProfileList(
          photo: 'assets/list/3.png',
          title: '선풍기 당근',
          text: '선풍기를 샀다!!',
          text2: '원래 27,900원인데 9,000원에 get~~~...',
          date: '2025.7.13 비공개',
        ),
        Divider(),
        ProfileList(
          photo: 'assets/list/4.png',
          title: '오늘 먹은 거',
          text: '오늘 점심에 명성 떡볶이를 먹었따',
          text2: '완전 맛있었다. 행복한 하루~~~...',
          date: '2025.7.9 비공개',
        ),
        Divider(),
        ProfileList(
          photo: 'assets/list/5.png',
          title: '감사 / 행복',
          text: '오늘 감사했던 일 3가지는?',
          text2: '일어남에 감사, 걸음에 감사, 숨쉴 수...',
          date: '2025.7.4 비공개',
        ),
        Divider(),
        ProfileList(
          photo: 'assets/list/6.png',
          title: '등산은 배움의 장터!',
          text: '여자친구와 등산 데이트다잉...~^^',
          text2: '맑은 공기.. 맑은 구름.. 힐링 스팟이다잉',
          date: '2025.7.1 비공개',
        ),
        Divider(),
        ProfileList(
          photo: 'assets/list/7.png',
          title: '사건 / 생각 / 감정',
          text: '집사러 갔다가 소다 학회 늦었음;;ㅎ 완전',
          text2: '완전 망했다고 생각..;; 진땀이 뻘뻘나더...',
          date: '2025.6.22 비공개',
        ),
      ],
    );
  }
}

class ProfileMy extends StatelessWidget {
  const ProfileMy({
    super.key,
    required this.main,
    required this.name,
    required this.friend,
    required this.onTap,
  });

  final String main;
  final String name;
  final String friend;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Image.asset(main, width: 48, height: 48),
      title: Text(name, style: TextStyle(fontSize: 17)),
      subtitle: Text('$friend명의 친구', style: TextStyle(fontSize: 10)),
    );
  }
}

class ProfileList extends StatelessWidget {
  const ProfileList({
    super.key,
    required this.photo,
    required this.title,
    required this.text,
    required this.text2,
    required this.date,
    this.onTap,
  });

  final String photo;
  final String title;
  final String text;
  final String text2;
  final String date;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.only(left: 18.45, top: 16, bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 90,
              height: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(photo, fit: BoxFit.fill),
              ),
            ),
            SizedBox(width: 36),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 17)),
                Text(text, style: TextStyle(fontSize: 11)),
                Text(text2, style: TextStyle(fontSize: 11)),
                SizedBox(height: 5),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 10,
                    color: Color.fromARGB(181, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
