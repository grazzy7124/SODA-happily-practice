import 'package:flutter/material.dart';
import 'package:ver1/comment.dart';

class Write extends StatelessWidget {
  const Write({
    super.key,
    required this.diarytitle,
    required this.diarytext,
    required this.diarytext2,
    required this.diarytext3,
    required this.date,
  });

  final String diarytitle;
  final String diarytext;
  final String diarytext2;
  final String diarytext3;
  final String date;

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
      body: Stack(
        children: [
          Container(color: Color(0xffFCFAF5)),
          ListView(
            children: [
              Divider(),
              ReadMain(
                color: 0xffD9ECFA,
                date: date,
                wholephoto: 'assets/list/1.png',
                wholetitle: diarytitle,
                wholetext: diarytext,
                wholetext2: diarytext2,
                wholetext3: diarytext3,
              ),
            ],
          ),
          Positioned(
            bottom: 80,
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

class Write2 extends StatelessWidget {
  const Write2({
    super.key,
    required this.diarytitle,
    required this.diarytext,
    required this.diarytext2,
    required this.diarytext3,
    required this.date,
  });

  final String diarytitle;
  final String diarytext;
  final String diarytext2;
  final String diarytext3;
  final String date;

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
      body: Stack(
        children: [
          Container(color: Color(0xffFCFAF5)),
          ListView(
            children: [
              Divider(),
              ReadMain(
                color: 0xffFBFFD7,
                date: date,
                wholephoto: 'assets/list/1.png',
                wholetitle: diarytitle,
                wholetext: diarytext,
                wholetext2: diarytext2,
                wholetext3: diarytext3,
              ),
            ],
          ),
          Positioned(
            bottom: 80,
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

class Write3 extends StatelessWidget {
  const Write3({
    super.key,
    required this.diarytitle,
    required this.diarytext,
    required this.diarytext2,
    required this.diarytext3,
    required this.date,
  });

  final String diarytitle;
  final String diarytext;
  final String diarytext2;
  final String diarytext3;
  final String date;

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
      body: Stack(
        children: [
          Container(color: Color(0xffFCFAF5)),
          ListView(
            children: [
              Divider(),
              ReadMain(
                color: 0xFFF9EEF3,
                date: date,
                wholephoto: 'assets/list/1.png',
                wholetitle: diarytitle,
                wholetext: diarytext,
                wholetext2: diarytext2,
                wholetext3: diarytext3,
              ),
            ],
          ),
          Positioned(
            bottom: 80,
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

class ReadMain extends StatelessWidget {
  const ReadMain({
    super.key,
    required this.wholephoto,
    required this.wholetitle,
    required this.wholetext,
    required this.wholetext2,
    required this.wholetext3,
    required this.date,
    required this.color,
  });

  final String wholephoto;
  final String wholetitle;
  final String wholetext;
  final String wholetext2;
  final String wholetext3;
  final String date;
  final int color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Card(
                      color: Color(color),
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
                              date,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                      child: Text(
                        wholetext,
                        style: TextStyle(fontSize: 17, fontFamily: 'gangwon'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                      child: Text(
                        wholetext2,
                        style: TextStyle(fontSize: 17, fontFamily: 'gangwon'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                      child: Text(
                        wholetext3,
                        style: TextStyle(fontSize: 17, fontFamily: 'gangwon'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
