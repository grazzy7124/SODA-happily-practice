// import 'package:flutter/material.dart';
// import 'package:ver1/profileedit1.dart';
// import 'package:ver1/write.dart';

// class ProfileMain extends StatelessWidget {
//   const ProfileMain({
//     super.key,
//     // required this.diarytitle,
//     // required this.diarytext,
//     // required this.diarytext2,
//     // required this.diarytext3,
//   });

//   // final String diarytitle;
//   // final String diarytext;
//   // final String diarytext2;
//   // final String diarytext3;

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         ProfileMy(
//           main: 'assets/profile1.png',
//           name: '고먐미',
//           friend: '11',
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Edit()),
//             );
//           },
//         ),
//         Divider(color: Color(0xffD4D4D4)),
//         SizedBox(height: 7),
//         Padding(
//           padding: EdgeInsets.only(left: 22),
//           child: Text(
//             '내가 쓴 일기',
//             style: TextStyle(fontSize: 16, fontFamily: 'gangwon'),
//           ),
//         ),
//         // ProfileListLast(
//         //   happliy: 'assets/happily/4.png',
//         //   photo: 'assets/list/1.png',
//         //   title: diarytitle,
//         //   text: diarytext,
//         //   text2: diarytext2,
//         //   text3: diarytext3,
//         //   date: '2025.7.30',
//         //   public: '공개',
//         //   onTap: () {
//         //     Navigator.push(
//         //       context,
//         //       MaterialPageRoute(
//         //         builder: (context) => Write(
//         //           diarytitle: diarytitle,
//         //           diarytext: diarytext,
//         //           diarytext2: diarytext2,
//         //           diarytext3: diarytext3,
//         //         ),
//         //       ),
//         //     );
//         //   },
//         // ),
//         // ProfileList(
//         //   happliy: 'assets/happily/4.png',
//         //   photo: 'assets/list/1.png',
//         //   title: '이별한지 23일',
//         //   text: '너가 없으니 내 행복도 사라졌다',
//         //   text2: '잘지내길...ㅜ',
//         //   date: '2025.7.30',
//         //   public: '공개',
//         //   onTap: () {
//         //     Navigator.push(
//         //       context,
//         //       MaterialPageRoute(builder: (context) => Write()),
//         //     );
//         //   },
//         // ),
//         ProfileList(
//           happliy: 'assets/happily/4.png',
//           photo: 'assets/list/2.png',
//           title: '기말고사 후기',
//           text: '재수강 각 떴다',
//           text2: '하.......',
//           date: '2025.7.18',
//           public: '공개',
//         ),
//         ProfileList(
//           happliy: 'assets/happily/4.png',
//           photo: 'assets/list/3.png',
//           title: '선풍기 당근',
//           text: '선풍기를 샀다!!',
//           text2: '원래 27,900원인데 9,000원에 get~~~...',
//           date: '2025.7.13',
//           public: '공개',
//         ),
//         ProfileList(
//           happliy: 'assets/happily/4.png',
//           photo: 'assets/list/4.png',
//           title: '오늘 먹은 거',
//           text: '오늘 점심에 명성 떡볶이를 먹었따',
//           text2: '완전 맛있었다. 행복한 하루~~~...',
//           date: '2025.7.9',
//           public: '공개',
//         ),
//         ProfileList(
//           happliy: 'assets/happily/4.png',
//           photo: 'assets/list/5.png',
//           title: '감사 / 행복',
//           text: '오늘 감사했던 일 3가지는?',
//           text2: '일어남에 감사, 걸음에 감사, 숨쉴 수...',
//           date: '2025.7.4',
//           public: '공개',
//         ),
//         ProfileList(
//           happliy: 'assets/happily/4.png',
//           photo: 'assets/list/6.png',
//           title: '등산은 배움의 장터!',
//           text: '여자친구와 등산 데이트다잉...~^^',
//           text2: '맑은 공기.. 맑은 구름.. 힐링 스팟이다잉',
//           date: '2025.7.1',
//           public: '공개',
//         ),
//         ProfileList(
//           happliy: 'assets/happily/4.png',
//           photo: 'assets/list/7.png',
//           title: '사건 / 생각 / 감정',
//           text: '집사러 갔다가 소다 학회 늦었음;;ㅎ 완전',
//           text2: '완전 망했다고 생각..;; 진땀이 뻘뻘나더...',
//           date: '2025.6.22',
//           public: '공개',
//         ),
//       ],
//     );
//   }
// }

// class ProfileMy extends StatelessWidget {
//   const ProfileMy({
//     super.key,
//     required this.main,
//     required this.name,
//     required this.friend,
//     required this.onTap,
//   });

//   final String main;
//   final String name;
//   final String friend;
//   final VoidCallback? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: onTap,
//       leading: Padding(
//         padding: EdgeInsets.only(left: 5, top: 6.94),
//         child: Image.asset(main, width: 48, height: 48),
//       ),
//       title: Padding(
//         padding: EdgeInsets.only(top: 7),
//         child: Text(
//           name,
//           style: TextStyle(fontSize: 17, fontFamily: 'gangwon'),
//         ),
//       ),
//       subtitle: Text(
//         '$friend명의 친구',
//         style: TextStyle(fontSize: 10, fontFamily: 'gangwon'),
//       ),
//     );
//   }
// }

// class ProfileList extends StatelessWidget {
//   const ProfileList({
//     super.key,
//     required this.happliy,
//     required this.title,
//     required this.photo,
//     required this.text,
//     required this.text2,
//     required this.date,
//     required this.public,
//     this.onTap,
//   });

//   final String happliy;
//   final String title;
//   final String photo;
//   final String text;
//   final String text2;
//   final String date;
//   final String public;
//   final VoidCallback? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       behavior: HitTestBehavior.opaque,
//       child: Padding(
//         padding: EdgeInsets.only(top: 5.5, left: 15, right: 15),
//         child: Card(
//           color: Color(0xffFFFFF6),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(left: 16, top: 15),
//                 child: Text(
//                   title,
//                   style: TextStyle(fontSize: 15, fontFamily: 'gangwon'),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 16, right: 16, top: 13),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.asset(
//                     width: double.infinity,
//                     height: 160,
//                     photo,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 13, left: 17),
//                 child: Text(
//                   text,
//                   style: TextStyle(fontSize: 15, fontFamily: 'gangwon'),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 5, left: 17),
//                 child: Text(
//                   text2,
//                   style: TextStyle(fontSize: 15, fontFamily: 'gangwon'),
//                 ),
//               ),
//               SizedBox(height: 25),
//               Padding(
//                 padding: EdgeInsets.only(left: 16, bottom: 13),
//                 child: Row(
//                   children: [
//                     Text(
//                       date,
//                       style: TextStyle(fontSize: 13, fontFamily: 'gangwon'),
//                     ),
//                     SizedBox(width: 6),
//                     Text(
//                       public,
//                       style: TextStyle(fontSize: 13, fontFamily: 'gangwon'),
//                     ),
//                     Spacer(),
//                     Image.asset(happliy, width: 28, height: 23),
//                     SizedBox(width: 17),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ProfileListLast extends StatelessWidget {
//   const ProfileListLast({
//     super.key,
//     required this.happliy,
//     required this.title,
//     required this.photo,
//     required this.text,
//     required this.text2,
//     required this.text3,
//     required this.date,
//     required this.public,
//     this.onTap,
//   });

//   final String happliy;
//   final String title;
//   final String photo;
//   final String text;
//   final String text2;
//   final String text3;
//   final String date;
//   final String public;
//   final VoidCallback? onTap;

//   bool hasMoreThanTwoLines(String text) {
//     return text.length > 60;
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isTextOverflowing = hasMoreThanTwoLines(text);

//     return GestureDetector(
//       onTap: onTap,
//       behavior: HitTestBehavior.opaque,
//       child: Padding(
//         padding: EdgeInsets.only(top: 5.5, left: 15, right: 15),
//         child: Card(
//           color: Color(0xffFFFFF6),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(left: 16, top: 15),
//                 child: Text(
//                   title,
//                   style: TextStyle(fontSize: 15, fontFamily: 'gangwon'),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 16, right: 16, top: 13),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.asset(
//                     width: double.infinity,
//                     height: 160,
//                     photo,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 13, left: 17),
//                 child: Text(
//                   text,
//                   style: TextStyle(fontSize: 15, fontFamily: 'gangwon'),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               // Padding(
//               //   padding: EdgeInsets.only(top: 13, left: 17),
//               //   child: Text(
//               //     text2,
//               //     style: TextStyle(fontSize: 15, fontFamily: 'gangwon'),
//               //     maxLines: 2,
//               //     overflow: TextOverflow.ellipsis,
//               //   ),
//               // ),
//               //   Padding(
//               //     padding: EdgeInsets.only(top: 13, left: 17),
//               //     child: Text(
//               //       text3,
//               //       style: TextStyle(fontSize: 15, fontFamily: 'gangwon'),
//               //       maxLines: 2,
//               //       overflow: TextOverflow.ellipsis,
//               //     ),
//               //   ),
//               SizedBox(height: 25),
//               Padding(
//                 padding: EdgeInsets.only(left: 16, bottom: 13),
//                 child: Row(
//                   children: [
//                     Text(
//                       date,
//                       style: TextStyle(fontSize: 13, fontFamily: 'gangwon'),
//                     ),
//                     SizedBox(width: 6),
//                     Text(
//                       public,
//                       style: TextStyle(fontSize: 13, fontFamily: 'gangwon'),
//                     ),
//                     Spacer(),
//                     Image.asset(happliy, width: 28, height: 23),
//                     SizedBox(width: 17),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// profile_main.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ver1/profileedit1.dart';

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

        return ListView.builder(
          itemCount: docs.isEmpty ? 2 : docs.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ProfileMy(
                main: 'assets/profile1.png',
                name: '고먐미',
                friend: '11',
                onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => Edit()));
                },
              );
            }
            if (index == 1) {
              return const Column(
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
              );
            }

            final doc = docs[index - 2];
            final data = doc.data();

            final String title = (data['title'] ?? '') as String;
            final String text1 = (data['text1'] ?? '') as String;
            final String text2 = (data['text2'] ?? '') as String;
            final String date = (data['date'] ?? '') as String;
            final bool isReleased = (data['isReleased'] ?? false) as bool;
            final int emotionIndex = (data['emotionIndex'] ?? 2) as int;

            final String happilyAsset = _emotionIndexToAsset(emotionIndex);

            final String photoAsset = 'assets/list/1.png';

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              switchInCurve: Curves.easeOut,
              child: ProfileList(
                key: ValueKey(doc.id),
                happliy: happilyAsset,
                photo: photoAsset,
                title: title,
                text: text1,
                text2: text2,
                date: date,
                public: isReleased ? '공개' : '비공개',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Write(docId: doc.id)),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

// 감정 인덱스(0~4) → 감정 아이콘 에셋 경로 매핑
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

// =============================
// 상단 프로필 요약
// =============================
class ProfileMy extends StatelessWidget {
  const ProfileMy({
    super.key,
    required this.main,
    required this.name,
    required this.friend,
    required this.onTap,
  });

  final String main;
  final String name;
  final String friend;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Padding(
        padding: const EdgeInsets.only(left: 5, top: 6.94),
        child: Image.asset(main, width: 48, height: 48),
      ),
      title: const Padding(
        padding: EdgeInsets.only(top: 7),
        child: Text(
          '고먐미',
          style: TextStyle(fontSize: 17, fontFamily: 'gangwon'),
        ),
      ),
      subtitle: Text(
        '$friend명의 친구',
        style: const TextStyle(fontSize: 10, fontFamily: 'gangwon'),
      ),
    );
  }
}

// =============================
// 카드 UI
// =============================
class ProfileList extends StatelessWidget {
  const ProfileList({
    super.key,
    required this.happliy,
    required this.title,
    required this.photo,
    required this.text,
    required this.text2,
    required this.date,
    required this.public,
    this.onTap,
  });

  final String happliy;
  final String title;
  final String photo;
  final String text;
  final String text2;
  final String date;
  final String public;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(top: 5.5, left: 15, right: 15),
        child: Card(
          color: const Color(0xffFFFFF6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 15),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 15, fontFamily: 'gangwon'),
                ),
              ),
              // 썸네일 이미지
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 13),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    width: double.infinity,
                    height: 160,
                    photo,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // 본문 미리보기 2줄
              Padding(
                padding: const EdgeInsets.only(top: 13, left: 17),
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 15, fontFamily: 'gangwon'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 17),
                child: Text(
                  text2,
                  style: const TextStyle(fontSize: 15, fontFamily: 'gangwon'),
                ),
              ),
              const SizedBox(height: 25),
              // 하단 메타
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 13),
                child: Row(
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'gangwon',
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      public,
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'gangwon',
                      ),
                    ),
                    const Spacer(),
                    Image.asset(happliy, width: 28, height: 23),
                    const SizedBox(width: 17),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================
// 상세 보기 (문서 id로 단건 조회)
// =============================
class Write extends StatelessWidget {
  const Write({super.key, required this.docId});
  final String docId;

  @override
  Widget build(BuildContext context) {
    final docRef = FirebaseFirestore.instance.collection('feeds').doc(docId);

    return Scaffold(
      appBar: AppBar(title: const Text('일기 보기')),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: docRef.get(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snap.data!.data();
          if (data == null) {
            return const Center(child: Text('데이터가 없습니다.'));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Text(
                  data['title'] ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'gangwon',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${data['date'] ?? ''}  ·  ${(data['isReleased'] ?? false) ? '공개' : '비공개'}',
                  style: const TextStyle(fontFamily: 'gangwon', fontSize: 13),
                ),
                const SizedBox(height: 16),
                Text(
                  data['text1'] ?? '',
                  style: const TextStyle(fontFamily: 'gangwon', fontSize: 15),
                ),
                const SizedBox(height: 8),
                Text(
                  data['text2'] ?? '',
                  style: const TextStyle(fontFamily: 'gangwon', fontSize: 15),
                ),
                const SizedBox(height: 8),
                Text(
                  data['text3'] ?? '',
                  style: const TextStyle(fontFamily: 'gangwon', fontSize: 15),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
