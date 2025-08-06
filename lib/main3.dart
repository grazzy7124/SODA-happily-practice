import 'package:flutter/material.dart';
import 'package:ver1/profileedit1.dart';
import 'package:ver1/write.dart';
 
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
        SizedBox(height: 5),
        Divider(),
        SizedBox(height: 15),
        Padding(
          padding: EdgeInsets.only(left: 30),
          child: Text('내가 쓴 일기', style: TextStyle(fontSize: 16)),
        ),
        ProfileList(
          happliy: 'assets/happily/4.png',

          photo: 'assets/list/1.png',
          title: '이별한지 23일',
          text: '너가 없으니 내 행복도 사라졌다',
          text2: '잘지내길...ㅜ',
          date: '2025.7.30',
          public: '공개',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Write()),
            );
          },
        ),
        ProfileList(
          happliy: 'assets/happily/4.png',
          photo: 'assets/list/2.png',
          title: '기말고사 후기',
          text: '재수강 각 떴다',
          text2: '하.......',
          date: '2025.7.18',
          public: '공개',
        ),
        ProfileList(
          happliy: 'assets/happily/4.png',
          photo: 'assets/list/3.png',
          title: '선풍기 당근',
          text: '선풍기를 샀다!!',
          text2: '원래 27,900원인데 9,000원에 get~~~...',
          date: '2025.7.13',
          public: '공개',
        ),
        ProfileList(
          happliy: 'assets/happily/4.png',
          photo: 'assets/list/4.png',
          title: '오늘 먹은 거',
          text: '오늘 점심에 명성 떡볶이를 먹었따',
          text2: '완전 맛있었다. 행복한 하루~~~...',
          date: '2025.7.9',
          public: '공개',
        ),
        ProfileList(
          happliy: 'assets/happily/4.png',
          photo: 'assets/list/5.png',
          title: '감사 / 행복',
          text: '오늘 감사했던 일 3가지는?',
          text2: '일어남에 감사, 걸음에 감사, 숨쉴 수...',
          date: '2025.7.4',
          public: '공개',
        ),
        ProfileList(
          happliy: 'assets/happily/4.png',
          photo: 'assets/list/6.png',
          title: '등산은 배움의 장터!',
          text: '여자친구와 등산 데이트다잉...~^^',
          text2: '맑은 공기.. 맑은 구름.. 힐링 스팟이다잉',
          date: '2025.7.1',
          public: '공개',
        ),
        ProfileList(
          happliy: 'assets/happily/4.png',
          photo: 'assets/list/7.png',
          title: '사건 / 생각 / 감정',
          text: '집사러 갔다가 소다 학회 늦었음;;ㅎ 완전',
          text2: '완전 망했다고 생각..;; 진땀이 뻘뻘나더...',
          date: '2025.6.22',
          public: '공개',
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
    required this.happliy,
    required this.title,
    required this.photo,
    required this.text,
    required this.text2,
    required this.date,
    required this.public,
    this.onTap,
  });

  final String happliy;
  final String title;
  final String photo;
  final String text;
  final String text2;
  final String date;
  final String public;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          color: Color(0xffFFFFF6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  children: [
                    Image.asset(happliy, width: 28, height: 23),
                    SizedBox(width: 10),
                    Text(title),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 17, right: 17, top: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    photo,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 190,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 17),
                child: Text(text),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, left: 17),
                child: Text(text2),
              ),
              SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.only(left: 16, bottom: 10),
                child: Row(
                  children: [Text(date), SizedBox(width: 10), Text(public)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
