import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  const Comment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffFCFAF5),
        title: CommentAppbar(),
      ),
      body: CommentMain(),
      backgroundColor: Color(0xffFCFAF5),
    );
  }
}

class CommentAppbar extends StatelessWidget { 
  const CommentAppbar({super.key});

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
        Text('말 한마디', style: TextStyle(fontSize: 18)),
      ],
    );
  }
}

class CommentMain extends StatelessWidget {
  const CommentMain({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CommentList(
          othermain: 'assets/main/4.png',
          othername: '힙합러버',
          commenttext: '와. 산책이라니. 믓.찝니다...^^~',
          commentyear: '2025',
          commentmonth: '7',
          commentday: '29',
        ),
        Divider(),
        CommentList(
          othermain: 'assets/main/5.png',
          othername: '차은우',
          commenttext: '나 차은우인데 다음 번에는 나도 불러라 간다 ㅂㅇ',
          commentyear: '2025',
          commentmonth: '7',
          commentday: '29',
        ),
        CommentWrite(),
      ],
    );
  }
}

class CommentList extends StatelessWidget {
  const CommentList({
    super.key,
    required this.othermain,
    required this.othername,
    required this.commenttext,
    required this.commentyear,
    required this.commentmonth,
    required this.commentday,
  });

  final String othermain;
  final String othername;
  final String commenttext;
  final String commentyear;
  final String commentmonth;
  final String commentday;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15, top: 15),
          child: Row(
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: Image.asset(othermain, fit: BoxFit.cover),
                ),
              ),

              SizedBox(width: 10),
              Text(othername, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, top: 10),
          child: Text(commenttext, style: TextStyle(fontSize: 16)),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, top: 10, bottom: 15),
          child: Row(
            children: [
              Text('$commentyear.', style: TextStyle(fontSize: 12)),
              Text('$commentmonth.', style: TextStyle(fontSize: 12)),
              Text(commentday, style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}

class CommentWrite extends StatelessWidget {
  const CommentWrite({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffFCFAF5),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              height: 47,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
              ),
              alignment: Alignment.centerLeft,
              child: TextField(
                decoration: InputDecoration(
                  hintText: '댓글을 입력해주세요.',
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 47,
              width: 91,
              color: Colors.black,
              alignment: Alignment.center,
              child: Text(
                '등록',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
