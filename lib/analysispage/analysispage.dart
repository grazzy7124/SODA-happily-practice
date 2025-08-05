import 'package:flutter/material.dart';
import 'package:ver1/analysispage/analysis.dart';
import 'package:ver1/analysispage/calendar.dart';

class Analysispage extends StatefulWidget {
  const Analysispage({super.key});

  @override
  State<Analysispage> createState() => _AnalysispageState();
}

class _AnalysispageState extends State<Analysispage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 70,),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            // color: Color(0xffF2F3F5),
          ),
          
          width: 320, height: 55,
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.transparent,
            tabs: [
              Tab(
                icon: Container(
                  width: 160, height: 44,
                  // decoration: BoxDecoration(
                  //   color: Color(0xffFFFFFF),
                  //   borderRadius: BorderRadius.circular(11.9)
                  // ),
                  child: Center(child: Text('분석', style: _selectedIndex == 0 ? _selectedTabStyle : _unselectedTabStyle,)),
                )
              ),
              Tab(
                icon: Container(
                  width: 160, height: 44,
                  // decoration: BoxDecoration(
                  //   color: Color(0xffFFFFFF),
                  //   borderRadius: BorderRadius.circular(11.9)
                  // ),
                  child: Center(child: Text('달력', style:  _selectedIndex == 1 ? _selectedTabStyle : _unselectedTabStyle,)),
                )
              )
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              Align(
                alignment: AlignmentGeometry.directional(0, -1),
                child: Analysis()
              ),
              Align(
                child: Calendar()
              )
            ]
          ),
        )
      ],
    );
  }
}

TextStyle _selectedTabStyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 19,
  letterSpacing: 0.6,
  color: Color(0xff000000),
);

TextStyle _unselectedTabStyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 19,
  letterSpacing: 0.6,
  color: Color(0xff878787),
);