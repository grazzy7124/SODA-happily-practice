import 'package:flutter/material.dart';
import 'package:ver1/mainPage/diarypage/diary1_page.dart';
import 'package:ver1/mainPage/diarypage/diary1.dart';

class FirstDiary extends StatelessWidget {
  final double currentEmotion;

  const FirstDiary({super.key, required this.currentEmotion});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) {
                return FirstDiaryPage(emotion: currentEmotion,);
              }
            ),            
          );
        },
        child: Image.asset(
          'assets/images/diary/diary1.png',
          height: 341,
        ),
      ),
    );
  }
}