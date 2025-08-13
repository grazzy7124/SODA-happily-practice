import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FeedEntry {
  final String id;
  final String userID;
  final String date; // "YYYY년 MM월 DD일"
  final double emotion;
  final bool isReleased;
  final String title;
  final String text1;
  final String text2;
  final String text3;
  final Timestamp createdAt;

  FeedEntry({
    required this.id,
    required this.userID,
    required this.date,
    required this.emotion,
    required this.isReleased,
    required this.title,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.createdAt,
  });

  factory FeedEntry.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data()!;
    return FeedEntry(
      id: doc.id,
      userID: d['userID'] as String,
      date: d['date'] as String,
      emotion: (d['emotion'] as num?)?.toDouble()
          ?? (d['emotionIndex'] as num?)?.toDouble()  // ← 과거 호환
          ?? 0.0,
      isReleased: (d['isReleased'] as bool?) ?? false,
      title: (d['title'] as String?) ?? '',
      text1: (d['text1'] as String?) ?? '',
      text2: (d['text2'] as String?) ?? '',
      text3: (d['text3'] as String?) ?? '',
      createdAt: (d['createdAt'] as Timestamp?) ?? Timestamp(0, 0),
    );
  }
}

class FeedService {
  final _feeds = FirebaseFirestore.instance.collection('feeds');

// 유틸: 오늘(KST) 날짜 문자열
  String _todayKstStr() {
    final nowUtc = DateTime.now().toUtc();
    final nowKst = nowUtc.add(const Duration(hours: 9)); // KST = UTC+9
    return DateFormat('yyyy년 MM월 dd일', 'ko_KR').format(nowKst);
  }

  // 오늘의 감정값 업서트 (있으면 update, 없으면 add)
  Future<void> upsertTodayEmotion({
    required String userID,
    required double emotion,
  }) async {
    // KST 오늘 날짜 문자열
    final nowUtc = DateTime.now().toUtc();
    final nowKst = nowUtc.add(const Duration(hours: 9)); // KST = UTC+9
    final dateStr = DateFormat('yyyy년 MM월 dd일', 'ko_KR').format(nowKst);

    // 연/월/일 숫자 필드도 같이 저장 (월별/일별 쿼리용)
    final y = nowKst.year;
    final m = nowKst.month;
    final d = nowKst.day;

    final qs = await _feeds
        .where('userID', isEqualTo: userID)
        .where('date', isEqualTo: dateStr)
        .limit(1)
        .get();

    if (qs.docs.isNotEmpty) {
      // 이미 오늘 문서가 있으면 감정만 덮어쓰기
      await _feeds.doc(qs.docs.first.id).update({
        'emotion': emotion,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } else {
      // 없으면 새 문서 생성
      await _feeds.add({
        'userID': userID,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'date': dateStr, // "YYYY년 MM월 dd일" (표시용)
        'year': y, // 쿼리용
        'month': m, // 쿼리용
        'day': d, // 쿼리용
        'emotion': emotion,
        'isReleased': false,
        'title': '',
        'text1': '',
        'text2': '',
        'text3': '',
      });
    }
  }

// 오늘(KST)의 감정값 가져오기 (없으면 null)
  Future<double?> getTodayEmotion({required String userID}) async {
    final dateStr = _todayKstStr();

    final qs = await _feeds
        .where('userID', isEqualTo: userID)
        .where('date', isEqualTo: dateStr)
        .orderBy('updatedAt', descending: true) // 최신 우선
        .limit(1)
        .get();

    if (qs.docs.isEmpty) return null;

    final data = qs.docs.first.data();
    // emotion 우선, 없으면 emotionIndex 사용
    final emo = (data['emotion'] as num?) ?? (data['emotionIndex'] as num?);
    return emo?.toDouble();
  }

  /// 해당 날짜(표시 문자열)로 일기 내용 업서트 (감정은 유지)
  Future<void> upsertDiaryForDate({
    required String userID,
    required String dateStr, // "YYYY년 MM월 DD일"
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
        'emotionIndex': emotionIndex, // ✅ 여기만 갱신
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } else {
      // 아직 감정 저장 전이라 문서가 없다면 새로 만든다 (emotionIndex는 일단 0.0)
      final dt = DateFormat('yyyy년 MM월 dd일', 'ko_KR').parse(dateStr);
      final y = dt.year, m = dt.month, d = dt.day;
      await _feeds.add({
        'userID': userID,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'date': dateStr,
        'year': y,
        'month': m,
        'day': d,
        'emotionIndex': emotionIndex,
        'isReleased': isReleased,
        'title': title,
        'text1': text1,
        'text2': text2,
        'text3': text3,
      });
    }
  }

  /// 최근 7일(UTC 기준 7일) 스트림 – 분석 탭 그래프에 사용
  Stream<List<FeedEntry>> streamRecent7({required String userID}) {
    final sevenDaysAgoUtc = DateTime.now().toUtc().subtract(
      const Duration(days: 7),
    );
    return _feeds
        .where('userID', isEqualTo: userID)
        .where(
          'createdAt',
          isGreaterThanOrEqualTo: Timestamp.fromDate(sevenDaysAgoUtc),
        )
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map(
          (snap) => snap.docs
              .where((d) => d.data().containsKey('emotion')) // ✅ 감정 있는 문서만
              .map((d) => FeedEntry.fromDoc(d))
              .toList(),
        );
  }

  /// 달력용: 특정 연/월의 감정 맵 가져오기 (date 문자열 -> emotionIndex)
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
      final data = doc.data();
      final ds = data['date'] as String?;
      final val = (data['emotion'] as num?)?.toDouble();
      if (ds != null && val != null) map[ds] = val;
    }
    return map;
  }
}
