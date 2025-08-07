import 'package:flutter/material.dart';
import 'package:ver1/analysispage/analysis.dart';
import 'package:ver1/analysispage/calendar.dart';

class Analysispage extends StatefulWidget {
  final double emotion;

  const Analysispage({super.key, required this.emotion});

  @override
  State<Analysispage> createState() => _AnalysispageState();
}

class _AnalysispageState extends State<Analysispage> with SingleTickerProviderStateMixin {
  late double emotion;
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emotion = widget.emotion;
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
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            // color: Color(0xffF2F3F5),
          ),

          width: 320,
          height: 55,
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.black,
            indicatorWeight: 2,
            indicatorPadding: EdgeInsetsGeometry.only(left: 40, right: 40),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                icon: Center(
                  child: Text(
                    '분석',
                    style: _selectedIndex == 0
                        ? _selectedTabStyle
                        : _unselectedTabStyle,
                  ),
                ),
              ),
              Tab(
                icon: Center(
                  child: Text(
                    '달력',
                    style: _selectedIndex == 1
                        ? _selectedTabStyle
                        : _unselectedTabStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              Align(
                alignment: AlignmentGeometry.directional(0, -1),
                child: Analysis(emotion: widget.emotion,),
              ),
              Align(child: Calendar()),
            ],
          ),
        ),
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