import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ver1/color.dart';

class Analysis extends StatelessWidget {
  final double emotion;
  List<double> emotions = [9, 6];
  
  double? pieChartRadius = 80;
  double today = DateTime.now().weekday.toDouble();

  Color getEmotionColor (double emotion) {
    if (emotion <= -8) return emotion1;
    if (emotion <= -3) return emotion2;
    if (emotion <= 2) return emotion3;
    if (emotion <= 7) return emotion4;
    if (emotion <= 10) return emotion5;
    return emotion3; // 회색
  }

  // Line 섹션 만들기
  List<Map<String, dynamic>> emotionRecords = [];

  void addEmotion(double emotion) {
    emotionRecords.add({
      'date': DateTime.now(),
      'emotion': emotion,
    });
  }

  List<FlSpot> getEmotionSpots() {
    return emotionRecords.map((record) {
      DateTime date = record['date'];
      double emotion = record['emotion'].toDouble();
      int weekday = date.weekday; // 1~7
      return FlSpot(weekday.toDouble(), emotion);
    }).toList();
  }

  // Pie 섹션 만들기
  List<PieChartSectionData> buildPieSections() {
    // emotions.add(emotion);

    Map<Color, int> emotionCounts = {
      emotion1: 0,
      emotion2: 0,
      emotion3: 0,
      emotion4: 0,
      emotion5: 0,
    };

    for (double e in emotions) {
      Color key = getEmotionColor(e);
      if (emotionCounts.containsKey(key)) {
        emotionCounts[key] = emotionCounts[key]! + 1;
      }
    }

    int total = emotions.length;

    return  emotionCounts.entries
        .where((entry) => entry.value > 0)
        .map((entry) {
          double percentage = entry.value / total * 100;
          return PieChartSectionData(
            value: percentage,
            color: entry.key,
            title: '${percentage.toStringAsFixed(1)}%',
            radius: pieChartRadius!,
            titleStyle: _pieTitleStyle,
          );
        }).toList();
  }

  Analysis({super.key, required this.emotion, this.pieChartRadius = 80}) {
    addEmotion(emotion);
    emotions.add(emotion);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Row(
              children: [
                SizedBox(width: 20,),
                Text('감정 변화', style: _explanationStyle,),
              ],
            ),
            // line chart 선그래프 
            SizedBox(
              width: 330, height: 270,
              child: Stack(
                children: [
                  Card(
                    color: Colors.white,
                    child: SizedBox(
                      child: Padding(
                        padding: EdgeInsets.only(left: 35, right: 25, top: 25, bottom: 37),
                        child: LineChart(
                          LineChartData(
                            minX: 1,
                            maxX: 7,
                            minY: -10,
                            maxY: 10,
                            lineBarsData: [
                              LineChartBarData(
                                spots: getEmotionSpots(),
                                // [
                                //   FlSpot(1, emotions[0]),
                                //   FlSpot(2, emotions[1]),
                                //   FlSpot(today, emotion),
                                // ],
                                // isCurved: true,
                                // curveSmoothness: 0.2,
                                color: Color(0xff9BCFFF),
                                barWidth: 2,
                                // gradient: LinearGradient(colors: [Colors.red, Colors.amber, Colors.blue]),
                                dotData: FlDotData(
                                  
                                )
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
                                  // getTitlesWidget: (value, meta) => ,
                                )
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                  reservedSize: 30,
                                  // getTitlesWidget: (value, meta) {
                                  //   return SideTitleWidget(
                                  //     meta: TitleMeta(min: min, max: max, parentAxisSize: parentAxisSize, axisPosition: axisPosition, appliedInterval: appliedInterval, sideTitles: sideTitles, formattedValue: formattedValue, axisSide: axisSide, rotationQuarterTurns: rotationQuarterTurns),
                                  //     child: Image.asset('assets/images/emotions/emotion1.png'),
                                  //   )
                                  // },
                                )
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false
                                )
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)
                              )
                            ),
                            gridData: FlGridData(show: true),
                            borderData: FlBorderData(
                              show: true,
                              border: Border.all(
                                color: Color(0xffDDDDDD)
                              )
                            ),
                          ),
                          duration: const Duration(milliseconds: 150),
                          curve: Curves.linear,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          SizedBox(height: 20,),
                          Image.asset(
                            'assets/images/emotions/emotion5.png',
                            width: 23.27, height: 19.2,
                          ),
                          SizedBox(height: 30,),
                          Image.asset(
                            'assets/images/emotions/emotion4.png',
                            width: 23.27, height: 19.2,
                          ),
                          SizedBox(height: 30,),
                          Image.asset(
                            'assets/images/emotions/emotion3.png',
                            width: 23.27, height: 19.2,
                          ),
                          SizedBox(height: 30,),
                          Image.asset(
                            'assets/images/emotions/emotion2.png',
                            width: 23.27, height: 19.2,
                          ),
                          SizedBox(height: 30,),
                          Image.asset(
                            'assets/images/emotions/emotion1.png',
                            width: 23.27, height: 19.2,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 230,),
                      Row(
                        children: [
                          SizedBox(width: 34,),
                          Text('월', style: _dateStsyle,),
                          SizedBox(width: 33,),
                          Text('화', style: _dateStsyle,),
                          SizedBox(width: 33,),
                          Text('수', style: _dateStsyle,),
                          SizedBox(width: 33,),
                          Text('목', style: _dateStsyle,),
                          SizedBox(width: 33,),
                          Text('금', style: _dateStsyle,),
                          SizedBox(width: 33,),
                          Text('토', style: _dateStsyle,),
                          SizedBox(width: 33,),
                          Text('일', style: _dateStsyle,),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 59,),
            Row(
              children: [
                SizedBox(width: 20,),
                Text('감정 분석', style: _explanationStyle,),
              ],
            ),
            // pie chart 원그래프 
            SizedBox(
              width: 330, height: 430,
              child: Card(
                color: Colors.white,
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.0,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: PieChart(
                          PieChartData(
                            sections: buildPieSections(),
                            centerSpaceRadius: 50,
                            sectionsSpace: 0,
                            
                          )
                        ),
                      ),
                    ),
                    Text('긍정 감정 비율: ', style: _analysisStyle,),
                    Text('중립 감정 비율: ', style: _analysisStyle,),
                    Text('부정 감정 비율: ', style: _analysisStyle,),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

TextStyle _explanationStyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 22,
  letterSpacing: 0.6,
  color: Color(0xff000000),
);



TextStyle _dateStsyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.w300,
  fontSize: 13,
  letterSpacing: 0,
  color: Color(0xff000000),
);

TextStyle _pieTitleStyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 16,
  letterSpacing: 0,
  color: Color(0xff767676),
);

TextStyle _analysisStyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.w300,
  fontSize: 22,
  letterSpacing: 0.6,
  color: Color(0xff000000),
);

