import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Analysis extends StatelessWidget {
  const Analysis({super.key});

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
                                  FlSpot(1, 3),
                                  FlSpot(2, 7),
                                  FlSpot(3, 4),
                                  FlSpot(4, 5),
                                ],
                                isCurved: true,
                                color: Colors.blue,
                                barWidth: 3,
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
          ],
        ),
      ],
    );
  }
}
