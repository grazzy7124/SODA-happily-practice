import 'package:flutter/material.dart';

class Edit extends StatelessWidget {
  const Edit({super.key});

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
            SizedBox(width: 165),
            Text('프로필 편집', style: TextStyle(fontSize: 21)),
          ],
        ),
        backgroundColor: Color(0xffFCFAF5),
      ),
      body: EditMyProfile(main: 'assets/profile1.png', name: '고먐미'),
      backgroundColor: Color(0xffFCFAF5),
    );
  }
}

class EditMyProfile extends StatelessWidget {
  const EditMyProfile({super.key, required this.main, required this.name});

  final String main;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        SizedBox(
          width: 100,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(90),
            child: Image.asset(main, fit: BoxFit.cover),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Color(0xffFF5757),
              overlayColor: Colors.transparent,
            ),
            onPressed: () {},
            child: Text('프로필 사진 변경', style: TextStyle(fontSize: 17)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff797979)),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '사용자 이름',
                      style: TextStyle(color: Color(0xff797979), fontSize: 17),
                    ),
                    SizedBox(height: 5),
                    TextField(
                      controller: TextEditingController(text: name),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                      ),
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
