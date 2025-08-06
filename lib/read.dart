import 'package:flutter/material.dart';
import 'package:ver1/comment.dart';

class Read extends StatelessWidget {
  const Read({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCFAF5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffFCFAF5),
        title: ReadAppbar(wholemain: 'assets/main/1.png', wholename: '보들이발닦개'),
      ),
      body: ReadMainMy(
        wholeyear: '2025',
        wholemonth: '7',
        wholeday: '30',
        wholedate: '수',
        wholephoto: 'assets/mainlist/1.png',
        wholetitle: '이번 주 한 일',
        wholetext:
            '오늘은 하루종일 뒹굴대다가 저녁에 보들이랑 산책을 했다.산책하는데 보들이가 똥을 3번이나 쌌다. 치우기 힘들었다. 그래도 보드리가 건강만 하다면 ㅎㅎ ',
      ),
    );
  }
}

class ReadAppbar extends StatelessWidget {
  const ReadAppbar({
    super.key,
    required this.wholemain,
    required this.wholename,
  });

  final String wholemain;
  final String wholename;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          behavior: HitTestBehavior.opaque,
          child: Image.asset('assets/Vector.png', width: 9, height: 17),
        ),
        SizedBox(width: 15),
        SizedBox(
          width: 35,
          height: 35,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(90),
            child: Image.asset(wholemain, fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: 15),
        Text(wholename, style: TextStyle(fontSize: 17)),
      ],
    );
  }
}

class ReadMainMy extends StatelessWidget {
  const ReadMainMy({
    super.key,
    required this.wholeyear,
    required this.wholemonth,
    required this.wholeday,
    required this.wholedate,
    required this.wholephoto,
    required this.wholetitle,
    required this.wholetext,
  });

  final String wholeyear;
  final String wholemonth;
  final String wholeday;
  final String wholedate;
  final String wholephoto;
  final String wholetitle;
  final String wholetext;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: Card(
              color: Color(0xffFFF2FA),
              child: Row(
                children: [
                  Text('$wholeyear년', style: TextStyle(fontSize: 18)),
                  Text('$wholemonth월', style: TextStyle(fontSize: 18)),
                  Text('$wholeday일', style: TextStyle(fontSize: 18)),
                  Text('$wholedate요일', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child: SizedBox(
            width: double.infinity,
            height: 210,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(wholephoto, fit: BoxFit.fill),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: Card(
              color: Color(0xffFFF2FA),
              child: Row(
                children: [
                  Text('제목 : $wholetitle', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child: Text(wholetext, style: TextStyle(fontSize: 17)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Image.asset('assets/c.png', width: 89, height: 34),
            SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Comment()),
                );
              },
              child: Image.asset('assets/cc.png', width: 30, height: 30),
            ),
            SizedBox(width: 17),
          ],
        ),
      ],
    );
  }
}
