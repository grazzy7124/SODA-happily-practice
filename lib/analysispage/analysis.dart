import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Analysis extends StatelessWidget {
  double? pidChartRadius;


  Analysis({super.key, this.pidChartRadius = 80});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
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
                            minX: 0,
                            maxX: 6,
                            minY: -10,
                            maxY: 10,
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  FlSpot(0, 0),
                                  FlSpot(1, -2),
                                  FlSpot(2, 7),
                                  FlSpot(3, 4),
                                  FlSpot(4, 5),
                                  FlSpot(6, -1)
                                ],
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
                  )
                ],
              ),
            ),
            SizedBox(height: 59,),
            SizedBox(
              width: 330, height: 415,
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
                            sections: [
                              PieChartSectionData(
                                value: 14.3,
                                color: Color(0xffA6F2DD),
                                radius: pidChartRadius
                              ),
                              PieChartSectionData(
                                value: 28.6,
                                color: Color(0xffFFBB8B),
                                radius: pidChartRadius
                              ),
                              PieChartSectionData(
                                value: 28.5,
                                color: Color(0xffE3E3E3),
                                radius: pidChartRadius
                              ),
                              PieChartSectionData(
                                value: 14.3,
                                color: Color(0xffFF8789),
                                radius: pidChartRadius
                              ),
                              PieChartSectionData(
                                color: Color(0xffAFD4FF),
                                radius: pidChartRadius
                              )
                            ],
                            centerSpaceRadius: 50,
                            sectionsSpace: 0,
                            
                          )
                        ),
                      ),
                    ),
                    Text('긍정 감정 비율'),
                    Text('긍정 감정 비율'),
                    Text('긍정 감정 비율'),
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
