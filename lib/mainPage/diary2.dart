import 'package:flutter/material.dart';

class SecondDiary extends StatelessWidget {
  const SecondDiary({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/diary/diary2.png',
        height: 341,
      ),
    );
  }
}