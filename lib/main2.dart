import 'package:flutter/material.dart';
import 'package:ver1/2profilefriend.dart';

void main() => runApp(const MaterialApp(home: MyApp2()));

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color(0xffFCFAF5),
          body: Column(
            children: [
              Container(
                color: Color(0xffFCFAF5),
                child: const TabBar(
                  tabs: [
                    Tab(text: '전체 일기'),
                    Tab(text: '친구 일기'),
                  ],
                  labelColor: Colors.black,
                  unselectedLabelColor: Color(0xff878787),
                  indicatorColor: Colors.black,
                ),
              ),
              Expanded(
                child: TabBarView(children: [WholePage(), FriendPage()]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WholePage extends StatelessWidget {
  const WholePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PageList(
          wholemain: 'assets/main/1.png',
          wholename: '보들이발닦개',
          wholeyear: '2025',
          wholemonth: '7',
          wholeday: '29',
          wholephoto: 'assets/mainlist/1.png',
          wholetitle: '보드리랑 산책',
          wholetext: '오늘은 하루종일 뒹굴대다가 저녁에 보들이랑 산책을 했다.',
          wholetext2: '산책하는데 보들이가 똥을 3번이나 쌌다. 치우기 힘들었다.',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WholeProfile()),
            );
          },
        ),
        Divider(),
        PageList(
          wholemain: 'assets/main/2.png',
          wholename: '예은',
          wholeyear: '2025',
          wholemonth: '7',
          wholeday: '29',
          wholephoto: 'assets/mainlist/2.png',
          wholetitle: '친구가 집에 놀러 온 날',
          wholetext: '오늘은 은지가 집에 놀러 왔다. 날이 더워서 함께 팥빙수를',
          wholetext2: '만들어 먹었다. 수박도 먹었다. 진짜 맛있었다. 앞으로 설빙 ...',
        ),
        Divider(),
        PageList(
          wholemain: 'assets/main/3.png',
          wholename: '방구뽕',
          wholeyear: '2025',
          wholemonth: '7',
          wholeday: '29',
          wholephoto: 'assets/mainlist/3.png',
          wholetitle: '포은흥해도서관',
          wholetext: '포항에 새로 생긴 도서관에 갔다',
          wholetext2: '새로 생긴 데라 그런지 삐까뻔쩍하고 아주 좋았다...',
        ),
      ],
    );
  }
}

class FriendPage extends StatelessWidget {
  const FriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PageList(
          wholemain: 'assets/main/4.png',
          wholename: '김철수',
          wholeyear: '2025',
          wholemonth: '7',
          wholeday: '24',
          wholephoto: 'assets/mainlist/4.png',
          wholetitle: '쇼미더머니 오디션 후기',
          wholetext: '오늘 목걸이 받았다 ㅋㅋ',
          wholetext2: '담에 다 죽었다 ㅋㅋ 연습 드간다 ㅋㅋ',
        ),
        Divider(),
        PageList(
          wholemain: 'assets/main/5.png',
          wholename: '박지수',
          wholeyear: '2025',
          wholemonth: '7',
          wholeday: '24',
          wholephoto: 'assets/mainlist/5.png',
          wholetitle: '폰케 바꿈',
          wholetext: '오랜만에 폰케이스 바꿨다!!',
          wholetext2: '아싸가오리~ ~ ~',
        ),
      ],
    );
  }
}

class PageList extends StatelessWidget {
  const PageList({
    super.key,
    required this.wholemain,
    required this.wholename,
    required this.wholeyear,
    required this.wholemonth,
    required this.wholeday,
    required this.wholephoto,
    required this.wholetitle,
    required this.wholetext,
    required this.wholetext2,
    this.onTap,
  });

  final String wholemain;
  final String wholename;
  final String wholeyear;
  final String wholemonth;
  final String wholeday;
  final String wholephoto;
  final String wholetitle;
  final String wholetext;
  final String wholetext2;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 25, top: 30),
          child: GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    wholemain,
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 1),
                      child: Text(wholename, style: TextStyle(fontSize: 14)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Text(
                            '$wholeyear.',
                            style: TextStyle(
                              color: Color(0xff818181),
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            '$wholemonth.',
                            style: TextStyle(
                              color: Color(0xff818181),
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            wholeday,
                            style: TextStyle(
                              color: Color(0xff818181),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(25),
          child: SizedBox(
            width: double.infinity,
            height: 230,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(wholephoto, fit: BoxFit.fill),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 25, bottom: 7),
          child: Text(wholetitle, style: TextStyle(fontSize: 18)),
        ),
        Padding(
          padding: EdgeInsets.only(left: 25, bottom: 3),
          child: Text(wholetext, style: TextStyle(fontSize: 14)),
        ),
        Padding(
          padding: EdgeInsets.only(left: 25, bottom: 3),
          child: Text(wholetext2, style: TextStyle(fontSize: 14)),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
