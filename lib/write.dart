import 'package:flutter/material.dart';
import 'package:ver1/comment.dart';
import 'package:ver1/read.dart';

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
            wholetext: '',
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
    return Column(
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
            height: 230,
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xffd9eaff),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('댓글 남기기', style: TextStyle(fontSize: 14)),
                ),
                SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Comment()),
                    );
                  },
                  backgroundColor: Color(0xFF4E4E4E),
                  mini: true,
                  child: Icon(Icons.remove),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
