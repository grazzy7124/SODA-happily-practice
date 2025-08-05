import 'package:flutter/material.dart';
import 'package:ver1/mainPage/diarypage/diary3_page.dart';

class ThirdDiary extends StatelessWidget {
  const ThirdDiary({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) {
                return ThirdDiaryPage();
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