import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ver1/color.dart';

class MydiaryThirdType extends StatelessWidget {
  final String docId;

  const MydiaryThirdType({super.key, required this.docId});

  @override
  Widget build(BuildContext context) {
    final docRef = FirebaseFirestore.instance.collection('feeds').doc(docId);

    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: docRef.get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Scaffold(
            backgroundColor: Color(0xffFCFAF5),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final data = snapshot.data!.data()!;
        final String date = data['date'] ?? '';
        final int selectedIndex = (data['emotionIndex'] ?? 0) as int;
        final bool isReleased = (data['isReleased'] ?? false) as bool;
        final String title = data['title'] ?? '';
        final String text1 = data['text1'] ?? '';
        final String text2 = data['text2'] ?? '';
        final String text3 = data['text3'] ?? '';

        return Scaffold(
          backgroundColor: const Color(0xffFCFAF5),
          appBar: AppBar(
            backgroundColor: const Color(0xffFCFAF5),
            leading: Row(
              children: [
                const SizedBox(width: 22),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Image.asset('assets/Vector.png', width: 9),
                ),
              ],
            ),
            title: Text(isReleased ? '공개글' : '비공개글', style: _titleStyle),
            centerTitle: true,
            actions: [
              Row(
                children: [
                  Image.asset('assets/images/action.png', height: 16),
                  const SizedBox(width: 25),
                ],
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 45,
                    child: Card(
                      color: thirdDiaryColor,
                      child: Row(
                        children: [
                          const SizedBox(width: 21),
                          Text(date, style: _dateStyle),
                          const Spacer(),
                          DropdownButton<int>(
                            value: selectedIndex,
                            onChanged: null, // 읽기 전용
                            items: List.generate(5, (i) {
                              return DropdownMenuItem(
                                value: i,
                                child: Image.asset(
                                  'assets/images/emotions/emotion${i + 1}.png',
                                  width: 28,
                                  height: 23,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 180,
                        child: Image.asset(
                          'assets/images/diary/photo.png',
                          width: 171,
                          height: 143,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 45,
                    child: Card(
                      color: thirdDiaryColor,
                      child: Row(
                        children: [
                          const SizedBox(width: 30),
                          Text('제목: ', style: _titleStyle),
                          const SizedBox(width: 6),
                          Flexible(child: Text(title, style: _titleStyle)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(text1, style: _textStyle),
                            Text(text2, style: _textStyle),
                            Text(text3, style: _textStyle),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

TextStyle _textStyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.w300,
  fontSize: 16,
  letterSpacing: 0.6,
  color: Color(0xff000000),
);

TextStyle _titleStyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 16,
  letterSpacing: 0.6,
  color: Color(0xff000000),
);

TextStyle _dateStyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 18,
  letterSpacing: 0.6,
  color: Color(0xff000000),
);