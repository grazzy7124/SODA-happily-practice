import 'package:flutter/material.dart';
import 'package:ver1/view/mainPage/diarypage/diary3_page.dart';

class ThirdDiary extends StatelessWidget {
  final double currentEmotion;

  const ThirdDiary({super.key, required this.currentEmotion});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) {
                return ThirdDiaryPage(emotion: currentEmotion,);
              }
            ),            
          );
        },
        child: Image.asset(
          'assets/images/diary/diary3.png',
          height: 341,
        ),
      ),
    );
  }
}