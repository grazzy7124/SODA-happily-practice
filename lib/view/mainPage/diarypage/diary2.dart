import 'package:flutter/material.dart';
import 'package:ver1/view/mainPage/diarypage/diary2_page.dart';

class SecondDiary extends StatelessWidget {
  final double currentEmotion;

  const SecondDiary({super.key, required this.currentEmotion});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) {
                return SecondDiaryPage(emotion: currentEmotion,);
              }
            ),            
          );
        },
        child: Image.asset(
          'assets/images/diary/diary2.png',
          height: 341,
        ),
      ),
    );
  }
}