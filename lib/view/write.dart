import 'package:flutter/material.dart';
import 'package:ver1/view/comment.dart';
import 'package:ver1/view/read.dart';

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
          ReadMain(
            wholeyear: '2025',
            wholemonth: '7',
            wholeday: '23',
            wholedate: '토',
            wholephoto: 'assets/list/1.png',
            wholetitle: '이별한 지 23일',
            wholetext:
                '너가 없으니 내 행복도 사라졌ㄷr.. 잘 지내길...ㅜ 사진처럼 우리가 우리의 시간 안에서 최선을 다 한 거길..... 이제 보내주자...',
          ),
        ],
      ),
      backgroundColor: Color(0xffFCFAF5),
    );
  }
}

class ReadMain extends StatelessWidget {
  const ReadMain({
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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Card(
                      color: Color(0xffFFF2FA),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Text(
                              '제목 : $wholetitle',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'gangwon',
                              ),
                            ),
                            Spacer(),
                            Text(
                              '$wholeyear.',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'gangwon',
                                color: Color(0xff7F7F7F),
                              ),
                            ),
                            Text(
                              '$wholemonth.',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'gangwon',
                                color: Color(0xff7F7F7F),
                              ),
                            ),
                            Text(
                              wholeday,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'gangwon',
                                color: Color(0xff7F7F7F),
                              ),
                            ),
                            Text(
                              '  ($wholedate)',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'gangwon',
                                color: Color(0xff7F7F7F),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 228,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(wholephoto, fit: BoxFit.fill),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: Text(
                    wholetext,
                    style: TextStyle(fontSize: 17, fontFamily: 'gangwon'),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 170,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
          ),
        ],
      ),
    );
  }
}
