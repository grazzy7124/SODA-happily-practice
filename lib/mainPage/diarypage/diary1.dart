import 'package:flutter/material.dart';
import 'package:ver1/mainPage/diarypage/diary1_page.dart';

class FirstDiary extends StatelessWidget {
  const FirstDiary({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) {
                return FirstDiaryPage();
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