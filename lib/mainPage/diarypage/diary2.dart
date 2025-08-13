import 'package:flutter/material.dart';
import 'package:ver1/mainPage/diarypage/diary2_page.dart';

class SecondDiary extends StatelessWidget {
  final double currentEmotion;
  final String userID;

  const SecondDiary({super.key, required this.currentEmotion, required this.userID});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return SecondDiaryPage(emotion: currentEmotion, userID: userID);
              },
            ),
          );
        },
        child: Image.asset('assets/images/diary/diary2.png', height: 341),
      ),
    );
  }
}
