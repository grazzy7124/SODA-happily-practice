import 'package:flutter/material.dart';
import 'package:ver1/mainPage/diarypage/diary3_page.dart';

class ThirdDiary extends StatelessWidget {
  final double currentEmotion;
  final String userID;

  const ThirdDiary({super.key, required this.currentEmotion, required this.userID});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ThirdDiaryPage(emotion: currentEmotion, userID: userID);
              },
            ),
          );
        },
        child: Image.asset('assets/images/diary/diary3.png', height: 341),
      ),
    );
  }
}
