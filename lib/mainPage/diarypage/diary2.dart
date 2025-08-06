import 'package:flutter/material.dart';
import 'package:ver1/mainPage/diarypage/diary2_page.dart';

class SecondDiary extends StatelessWidget {
  const SecondDiary({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) {
                return SecondDiaryPage();
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