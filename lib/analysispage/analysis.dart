import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ver1/color.dart';
import 'package:ver1/services/emotion_service.dart'; // FeedService/FeedEntry

class Analysis extends StatefulWidget {
  final String userID;
  final double emotion; // 오늘 값 (있다면)
  final bool hasEmotion; // 오늘 슬라이더 조작 여부
  double pieChartRadius;

  Analysis({
    super.key,
    required this.userID,
    required this.emotion,
    required this.hasEmotion,
    this.pieChartRadius = 80,
  });

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  final ValueNotifier<bool> _bubbleVisible = ValueNotifier<bool>(false);

  Color getEmotionColor(double emotion) {
    if (emotion <= -8) return emotion1;
    if (emotion <= -3) return emotion2;
    if (emotion <= 2) return emotion3;
    if (emotion <= 7) return emotion4;
    if (emotion <= 10) return emotion5;
    return emotion3;
  }

  // ✅ entries → LineChart spots (요일 축: 1~7)
  List<FlSpot> _spotsFromEntries(List<EmotionEntry> entries) {
    return entries.map((e) {
      final dt = e.createdAt.toDate().toLocal(); // Timestamp -> DateTime(로컬)
      return FlSpot(dt.weekday.toDouble(), e.emotion);
    }).toList();
  }

  // ✅ entries → Pie 섹션
  List<PieChartSectionData> _pieSectionsFrom(List<EmotionEntry> entries) {
    final counts = <Color, int>{
      emotion1: 0,
      emotion2: 0,
      emotion3: 0,
      emotion4: 0,
      emotion5: 0,
    };

    for (final e in entries) {
      counts[getEmotionColor(e.emotion)] =
          (counts[getEmotionColor(e.emotion)] ?? 0) + 1;
    }

    final total = entries.length;
    if (total == 0) return [];

    return counts.entries.where((kv) => kv.value > 0).map((kv) {
      final pct = kv.value / total * 100;
      return PieChartSectionData(
        value: pct,
        color: kv.key,
        title: '${pct.toStringAsFixed(1)}%',
        radius: widget.pieChartRadius,
        titleStyle: _pieTitleStyle,
      );
    }).toList();
  }

  // ✅ entries → 비율(긍/중/부)
  Map<String, double> _ratiosFrom(List<EmotionEntry> entries) {
    final total = entries.length;
    if (total == 0) return {'positive': 0, 'neutral': 0, 'negative': 0};

    int positive = 0, neutral = 0, negative = 0;
    for (final e in entries) {
      final c = getEmotionColor(e.emotion);
      if (c == emotion1 || c == emotion2)
        negative++;
      else if (c == emotion3)
        neutral++;
      else if (c == emotion4 || c == emotion5)
        positive++;
    }
    return {
      'positive': positive / total * 100,
      'neutral': neutral / total * 100,
      'negative': negative / total * 100,
    };
  }

  @override
  Widget build(BuildContext context) {
    final userID = widget.userID;

    return StreamBuilder<List<EmotionEntry>>(
      stream: EmotionService().streamRecent7(userID: userID), // 🔴 최근 7일
      builder: (context, snap) {
        if (snap.hasError) {
          // 🔴 인덱스 부족 / 퍼미션 에러면 여기로 옴. 메시지에 콘솔 링크가 뜨는 경우가 많음.
          return Center(
            child: Text('오류: ${snap.error}', textAlign: TextAlign.center),
          );
        }
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final entries = snap.data!;
        if (entries.isEmpty) {
          // 🔸 오늘 슬라이더 안 움직였더라도, 과거 데이터가 있으면 그려짐.
          //     여기까지 왔다는 건 과거 데이터도 없음.
          return Center(
            child: Text(
              '아직 감정이 기록되지 않았어요.\n메인 탭에서 슬라이더를 움직여 기록해보세요.',
              textAlign: TextAlign.center,
            ),
          );
        }

        // 🔹 차트/파이 계산을 전부 entries 기준으로
        final spots = _spotsFromEntries(entries);
        final ratios = _ratiosFrom(entries);
        final sections = _pieSectionsFrom(entries);

        // 🔹 여기서 ratios 비교
        String message;
        if (ratios['positive']! > ratios['neutral']! &&
            ratios['positive']! > ratios['negative']!) {
          message = '이번 주는 긍정적인 한 주였네요!\n다음 주도 매일 행복하시길 바라요:)';
        } else if (ratios['negative']! > ratios['positive']! &&
            ratios['negative']! > ratios['neutral']!) {
          message = '이번 주는 조금 힘들었네요.\n잘 버텨주셨어요!';
        } else {
          message = '이번 주는 차분한 한 주였네요.\n다음 주도 화이팅이에요:)';
        }

        return Stack(
          children: [
            ListView(
              children: [
                Column(
                  children: [
                    Row(
                      children: const [
                        SizedBox(width: 20),
                        Text('감정 변화', style: _explanationStyle),
                      ],
                    ),

                    // ── Line Chart ─────────────────────────────
                    SizedBox(
                      width: 330,
                      height: 270,
                      child: Stack(
                        children: [
                          Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 35,
                                right: 25,
                                top: 25,
                                bottom: 37,
                              ),
                              child: LineChart(
                                LineChartData(
                                  minX: 1,
                                  maxX: 7,
                                  minY: -10,
                                  maxY: 10,
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: spots, // ✅ Firestore 기반
                                      isCurved: false,
                                      color: const Color(0xff9BCFFF),
                                      barWidth: 2,
                                      dotData: FlDotData(),
                                    ),
                                  ],
                                  clipData: FlClipData.all(),
                                  titlesData: FlTitlesData(
                                    show: true,
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: false,
                                        reservedSize: 40,
                                        interval: 1,
                                      ),
                                    ),
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: false,
                                        reservedSize: 30,
                                      ),
                                    ),
                                    topTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    rightTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                  ),
                                  gridData: FlGridData(show: true),
                                  borderData: FlBorderData(
                                    show: true,
                                    border: Border.all(
                                      color: const Color(0xffDDDDDD),
                                    ),
                                  ),
                                ),
                                duration: const Duration(milliseconds: 150),
                                curve: Curves.linear,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Image.asset(
                                    'assets/images/emotions/emotion5.png',
                                    width: 23.27,
                                    height: 19.2,
                                  ),
                                  const SizedBox(height: 30),
                                  Image.asset(
                                    'assets/images/emotions/emotion4.png',
                                    width: 23.27,
                                    height: 19.2,
                                  ),
                                  const SizedBox(height: 30),
                                  Image.asset(
                                    'assets/images/emotions/emotion3.png',
                                    width: 23.27,
                                    height: 19.2,
                                  ),
                                  const SizedBox(height: 30),
                                  Image.asset(
                                    'assets/images/emotions/emotion2.png',
                                    width: 23.27,
                                    height: 19.2,
                                  ),
                                  const SizedBox(height: 30),
                                  Image.asset(
                                    'assets/images/emotions/emotion1.png',
                                    width: 23.27,
                                    height: 19.2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: const [
                              SizedBox(height: 230),
                              Row(
                                children: [
                                  SizedBox(width: 34),
                                  Text('월', style: _dateStsyle),
                                  SizedBox(width: 33),
                                  Text('화', style: _dateStsyle),
                                  SizedBox(width: 33),
                                  Text('수', style: _dateStsyle),
                                  SizedBox(width: 33),
                                  Text('목', style: _dateStsyle),
                                  SizedBox(width: 33),
                                  Text('금', style: _dateStsyle),
                                  SizedBox(width: 33),
                                  Text('토', style: _dateStsyle),
                                  SizedBox(width: 33),
                                  Text('일', style: _dateStsyle),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 59),

                    Row(
                      children: const [
                        SizedBox(width: 20),
                        Text('감정 분석', style: _explanationStyle),
                      ],
                    ),

                    // ── Pie Chart ──────────────────────────────
                    SizedBox(
                      width: 330,
                      height: 430,
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 1.0,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: PieChart(
                                  PieChartData(
                                    sections: sections, // ✅ Firestore 기반
                                    centerSpaceRadius: 50,
                                    sectionsSpace: 0,
                                  ),
                                ),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: '긍정 감정 비율: ',
                                    style: _analysisStyle,
                                  ),
                                  TextSpan(
                                    text:
                                        '${ratios['positive']!.toStringAsFixed(1)}%',
                                    style: _analysisStyle,
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: '중립 감정 비율: ',
                                    style: _analysisStyle,
                                  ),
                                  TextSpan(
                                    text:
                                        '${ratios['neutral']!.toStringAsFixed(1)}%',
                                    style: _analysisStyle,
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: '부정 감정 비율: ',
                                    style: _analysisStyle,
                                  ),
                                  TextSpan(
                                    text:
                                        '${ratios['negative']!.toStringAsFixed(1)}%',
                                    style: _analysisStyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ],
            ),

            // 말풍선/아이콘
            Positioned(
              bottom: 27.6,
              left: 32,
              child: ValueListenableBuilder<bool>(
                valueListenable: _bubbleVisible,
                builder: (_, visible, __) {
                  if (!visible) return const SizedBox.shrink();
                  return Stack(
                    children: [
                      Image.asset(
                        'assets/images/bubble.png',
                        width: 256,
                        height: 83.4,
                      ),
                      Positioned(
                        left: 40,
                        top: 12,
                        child: Text(message, style: _bubbleStyle),
                      ),
                    ],
                  );
                },
              ),
            ),
            Positioned(
              bottom: 13.22,
              left: 24,
              child: GestureDetector(
                onTap: () => _bubbleVisible.value =
                    !_bubbleVisible.value, // ← setState 제거
                child: Image.asset(
                  'assets/images/analysisIcon.png',
                  width: 30,
                  height: 25,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ===== Styles =====
const TextStyle _explanationStyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 22,
  letterSpacing: 0.6,
  color: Color(0xff000000),
);

const TextStyle _dateStsyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.w300,
  fontSize: 13,
  letterSpacing: 0,
  color: Color(0xff000000),
);

const TextStyle _pieTitleStyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 16,
  letterSpacing: 0,
  color: Color(0xff767676),
);

const TextStyle _analysisStyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.w300,
  fontSize: 22,
  letterSpacing: 0.6,
  color: Color(0xff000000),
);

const TextStyle _bubbleStyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.w300,
  fontSize: 14,
  letterSpacing: 0.6,
  color: Color(0xff000000),
);
