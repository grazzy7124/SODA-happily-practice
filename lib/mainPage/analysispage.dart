import 'package:flutter/material.dart';
import 'package:ver1/mainPage/analysis.dart';
import 'package:ver1/mainPage/calendar.dart';

class Analysispage extends StatefulWidget {
  const Analysispage({super.key});

  @override
  State<Analysispage> createState() => _AnalysispageState();
}

class _AnalysispageState extends State<Analysispage> {
  int _selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2, 
      child: Column(
        children: [
          SizedBox(height: 70,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              // color: Color(0xffF2F3F5),
            ),
            
            width: 320, height: 55,
            child: TabBar(
              // indicatorColor: Colors.transparent,
              tabs: [
                Tab(
                  icon: Container(
                    width: 160, height: 44,
                    // decoration: BoxDecoration(
                    //   color: Color(0xffFFFFFF),
                    //   borderRadius: BorderRadius.circular(11.9)
                    // ),
                    child: Center(child: Text('분석')),
                  )
                ),
                Tab(
                  icon: Container(
                    width: 160, height: 44,
                    // decoration: BoxDecoration(
                    //   color: Color(0xffFFFFFF),
                    //   borderRadius: BorderRadius.circular(11.9)
                    // ),
                    child: Center(child: Text('달력')),
                  )
                )
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                Align(
                  alignment: AlignmentGeometry.directional(0, -1),
                  child: Analysis()
                ),
                Calendar()
              ]
            ),
          )
        ],
      )
    );
  }
}