// lib/services/feed_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FeedEntry {
  final String id;
  final String userID;
  final String date;       // "YYYY년 MM월 DD일"
  final double emotion;    // 슬라이더 값 (-10~10)
  final double emotionIndex; // 드롭다운 인덱스(일기)
  final bool isReleased;
  final String title, text1, text2, text3;
  final Timestamp createdAt, updatedAt;

  FeedEntry({
    required this.id,
    required this.userID,
    required this.date,
    required this.emotion,
    required this.emotionIndex,
    required this.isReleased,
    required this.title,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FeedEntry.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data()!;
    return FeedEntry(
      id: doc.id,
      userID: d['userID'] as String,
      date: d['date'] as String,
      emotion: (d['emotion'] as num?)?.toDouble() ?? 0.0,
      emotionIndex: (d['emotionIndex'] as num?)?.toDouble() ?? 0.0,
      isReleased: (d['isReleased'] as bool?) ?? false,
      title: (d['title'] as String?) ?? '',
      text1: (d['text1'] as String?) ?? '',
      text2: (d['text2'] as String?) ?? '',
      text3: (d['text3'] as String?) ?? '',
      createdAt: (d['createdAt'] as Timestamp?) ?? Timestamp(0, 0),
      updatedAt: (d['updatedAt'] as Timestamp?) ?? Timestamp(0, 0),
    );
  }
}

class FeedService {
  final _feeds = FirebaseFirestore.instance.collection('feeds');
  final _users = FirebaseFirestore.instance.collection('users');

  /// 오늘 감정값 업서트: users.emotion 갱신 + feeds(오늘 문서) 업서트
  Future<void> upsertTodayEmotion({
    required String userID,
    required double emotion,        // 슬라이더 값
  }) async {
    // 1) users 현재 상태 갱신
    await _users.doc(userID).set({
      'userID': userID,
      'emotion': emotion,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    // 2) feeds 오늘 문서 업서트
    final nowKst = DateTime.now().toUtc().add(const Duration(hours: 9));
    final dateStr = DateFormat('yyyy년 MM월 dd일', 'ko_KR').format(nowKst);
    final y = nowKst.year, m = nowKst.month, d = nowKst.day;

    final qs = await _feeds
        .where('userID', isEqualTo: userID)
        .where('date', isEqualTo: dateStr)
        .limit(1)
        .get();

    if (qs.docs.isNotEmpty) {
      await _feeds.doc(qs.docs.first.id).update({
        'emotion': emotion,                           // ✅ 비정규화 저장
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } else {
      await _feeds.add({
        'userID': userID,
        'date': dateStr,
        'year': y, 'month': m, 'day': d,
        'emotion': emotion,                           // ✅
        'emotionIndex': 0.0,                          // 일기에서 추후 업데이트
        'isReleased': false,
        'title': '', 'text1': '', 'text2': '', 'text3': '',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  /// 일기 저장(업서트) – 같은 날짜 문서에 제목/본문/공개 여부/드롭다운 인덱스 갱신
  Future<void> upsertDiaryForDate({
    required String userID,
    required String dateStr,    // "YYYY년 MM월 DD일"
    required String title,
    required String text1,
    required String text2,
    required String text3,
    required bool isReleased,
    required double emotionIndex,
  }) async {
    final qs = await _feeds
        .where('userID', isEqualTo: userID)
        .where('date', isEqualTo: dateStr)
        .limit(1)
        .get();

    if (qs.docs.isNotEmpty) {
      await _feeds.doc(qs.docs.first.id).update({
        'title': title,
        'text1': text1,
        'text2': text2,
        'text3': text3,
        'isReleased': isReleased,
        'emotionIndex': emotionIndex,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } else {
      final dt = DateFormat('yyyy년 MM월 dd일', 'ko_KR').parse(dateStr);
      await _feeds.add({
        'userID': userID,
        'date': dateStr,
        'year': dt.year, 'month': dt.month, 'day': dt.day,
        'emotion': 0.0,                // 나중에 메인에서 저장되면 갱신
        'emotionIndex': emotionIndex,
        'isReleased': isReleased,
        'title': title, 'text1': text1, 'text2': text2, 'text3': text3,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  /// 최근 7일 스트림 (분석 탭)
  Stream<List<FeedEntry>> streamRecent7({required String userID}) {
    final sevenAgo = DateTime.now().toUtc().subtract(const Duration(days: 7));
    return _feeds
        .where('userID', isEqualTo: userID)
        .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(sevenAgo))
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((s) => s.docs.map((d) => FeedEntry.fromDoc(d)).toList());
  }

  /// 달력: 해당 월 감정 맵
  Future<Map<String, double>> loadMonthEmotions({
    required String userID,
    required int year,
    required int month,
  }) async {
    final qs = await _feeds
        .where('userID', isEqualTo: userID)
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .get();

    final map = <String, double>{};
    for (final doc in qs.docs) {
      final d = doc.data();
      final ds = d['date'] as String?;
      final e = (d['emotion'] as num?)?.toDouble();
      if (ds != null && e != null) map[ds] = e;
    }
    return map;
  }
}
