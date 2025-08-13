// lib/services/emotion_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class EmotionEntry {
  final String id;           // 문서 ID (권장: userID_yyyyMMdd)
  final String userID;
  final String date;         // "yyyy년 MM월 dd일" (표시용)
  final double emotion;      // 감정값 (-10 ~ 10)
  final int year;
  final int month;
  final int day;
  final Timestamp createdAt;
  final Timestamp? updatedAt;

  EmotionEntry({
    required this.id,
    required this.userID,
    required this.date,
    required this.emotion,
    required this.year,
    required this.month,
    required this.day,
    required this.createdAt,
    this.updatedAt,
  });

  factory EmotionEntry.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data()!;
    final emo = (d['emotion'] as num?)?.toDouble()
        ?? (d['emotionIndex'] as num?)?.toDouble()  // 과거 호환
        ?? 0.0;
    return EmotionEntry(
      id: doc.id,
      userID: d['userID'] as String,
      date: d['date'] as String,
      emotion: emo,
      year: (d['year'] as num).toInt(),
      month: (d['month'] as num).toInt(),
      day: (d['day'] as num).toInt(),
      createdAt: (d['createdAt'] as Timestamp?) ?? Timestamp(0, 0),
      updatedAt: d['updatedAt'] as Timestamp?,
    );
  }
}

class EmotionService {
  final _col = FirebaseFirestore.instance.collection('emotions');

  // yyyyMMdd로 고정 DocID 만들어 하루 1문서 보장 (중복 방지)
  String _docIdFor(String userID, DateTime kst) {
    final y = kst.year;
    final m = kst.month.toString().padLeft(2, '0');
    final d = kst.day.toString().padLeft(2, '0');
    return '$userID${y}$m$d';
  }

  DateTime _nowKst() => DateTime.now().toUtc().add(const Duration(hours: 9));
  String _dateStr(DateTime d) =>
      DateFormat('yyyy년 MM월 dd일', 'ko_KR').format(DateTime(d.year, d.month, d.day));

  /// 오늘 감정 upsert (있으면 덮어쓰기, 없으면 생성)
  Future<void> upsertTodayEmotion({
    required String userID,
    required double emotion,
  }) async {
    final nowKst = _nowKst();
    final docId = _docIdFor(userID, nowKst);

    await _col.doc(docId).set({
      'userID': userID,
      'emotion': emotion,
      'date': _dateStr(nowKst),
      'year': nowKst.year,
      'month': nowKst.month,
      'day': nowKst.day,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true)); // merge로 안전하게 upsert
  }

  /// 오늘(KST) 감정값 가져오기
  Future<double?> getTodayEmotion({required String userID}) async {
    final nowKst = _nowKst();
    final docId = _docIdFor(userID, nowKst);
    final doc = await _col.doc(docId).get();
    if (!doc.exists) return null;
    final d = doc.data() as Map<String, dynamic>;
    final emo = (d['emotion'] as num?) ?? (d['emotionIndex'] as num?);
    return emo?.toDouble();
  }

  /// 최근 7일 감정 스트림 (분석 차트용)
  Stream<List<EmotionEntry>> streamRecent7({required String userID}) {
    final sevenDaysAgoUtc = DateTime.now().toUtc().subtract(const Duration(days: 7));
    return _col
        .where('userID', isEqualTo: userID)
        .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(sevenDaysAgoUtc))
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snap) => snap.docs.map((d) => EmotionEntry.fromDoc(d)).toList());
  }

  /// 달력용: 특정 연/월의 감정 맵 (date 문자열 -> emotion)
  Future<Map<String, double>> loadMonthEmotions({
    required String userID,
    required int year,
    required int month,
  }) async {
    final qs = await _col
        .where('userID', isEqualTo: userID)
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .get();

    final map = <String, double>{};
    for (final doc in qs.docs) {
      final data = doc.data();
      final ds = data['date'] as String?;
      final emo = (data['emotion'] as num?)?.toDouble()
          ?? (data['emotionIndex'] as num?)?.toDouble();
      if (ds != null && emo != null) map[ds] = emo;
    }
    return map;
  }
}
