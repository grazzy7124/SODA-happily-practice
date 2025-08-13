import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ver1/profileedit1.dart';
import 'package:ver1/aboutprofile.dart';
import 'package:ver1/write.dart';

class ProfileMain extends StatelessWidget {
  const ProfileMain({super.key, required this.userID});

  final String userID;

  @override
  Widget build(BuildContext context) {
    final feedsQuery = FirebaseFirestore.instance
        .collection('feeds')
        .where('userID', isEqualTo: userID)
        .orderBy('createdAt', descending: true);

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: feedsQuery.snapshots(),
      builder: (context, snap) {
        final docs = snap.data?.docs ?? [];

        final items = <Widget>[];

        items.add(
          ProfileMy(
            main: 'assets/profile1.png',
            name: '고먐미',
            friend: '11',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Edit()),
              );
            },
          ),
        );

        items.add(
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: Color(0xffD4D4D4)),
              SizedBox(height: 7),
              Padding(
                padding: EdgeInsets.only(left: 22),
                child: Text(
                  '내가 쓴 일기',
                  style: TextStyle(fontSize: 16, fontFamily: 'gangwon'),
                ),
              ),
            ],
          ),
        );
                     
        for (final doc in docs) {
          final data = doc.data();

          final String title = (data['title'] ?? '') as String;
          final String text1 = (data['text1'] ?? '') as String;
          final String text2 = (data['text2'] ?? '') as String;
          final String text3 = (data['text3'] ?? '') as String;
          final String date = (data['date'] ?? '') as String;
          final bool isReleased = (data['isReleased'] ?? false) as bool;
          final int emotionIndex = (data['emotionIndex'] ?? 2) as int;

          final String happilyAsset = _emotionIndexToAsset(emotionIndex);
          const String photoAsset = 'assets/list/1.png';

          items.add(
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              switchInCurve: Curves.easeOut,
              child: ProfileList(
                key: ValueKey(doc.id),
                happliy: happilyAsset,
                photo: photoAsset,
                title: title.isEmpty ? '(제목 없음)' : title,
                text: text1,
                text2: text2,
                date: date,
                public: isReleased ? '공개' : '비공개',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Write(
                        diarytitle: title,
                        diarytext: text1,
                        diarytext2: text2,
                        diarytext3: text3,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
        return ListView(children: items);
      },
    );
  }
}

String _emotionIndexToAsset(int idx) {
  final safe = idx.clamp(0, 4);
  const paths = [
    'assets/happily/1.png',
    'assets/happily/2.png',
    'assets/happily/3.png',
    'assets/happily/4.png',
    'assets/happily/5.png',
  ];
  return paths[safe];
}
