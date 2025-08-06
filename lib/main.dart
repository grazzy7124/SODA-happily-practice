import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ver1/analysispage/analysispage.dart';
import 'package:ver1/mainPage/mainpage.dart';
import 'package:ver1/mainPage/pageview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ver1/notificationpage/notification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [
        Locale('ko', 'KR')
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: 'HAPPI-LY', 
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff94C6FF)),
      ),
      home: const MyHomePage(title: 'Happily'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _currentPageIndex = 0;
  late TabController _tabController;

  @override 
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  Color? _thumbColor = Color.fromRGBO(217, 217, 217, 1);
  double _currentDiscreteSliderValue = 0;

  Color? getThumbColor (double value) {
    if (value == -10) {
      return Color.fromRGBO(255, 95, 98, 1);
    }
    else if (value < -5) {
      double t = (value + 10) / 5;
      return Color.lerp(Color.fromRGBO(255, 95, 98, 1), Color.fromRGBO(255, 165, 100, 1), t);
    }
    else if (value == -5) {
      return Color.fromRGBO(255, 165, 100, 1);
    }
    else if (value < 0) {
      double t = (value + 5) / 5;
      return Color.lerp(Color.fromRGBO(255, 165, 100, 1), Color.fromRGBO(217, 217, 217, 1), t);
    }
    else if (value == 0) {
      return Color.fromRGBO(217, 217, 217, 1);
    }
    else if (value < 5) {
      double t = (value) / 5;
      return Color.lerp(Color.fromRGBO(217, 217, 217, 1), Color.fromRGBO(136, 238, 209, 1), t);
    }
    else if (value == 5) {
      return Color.fromRGBO(136, 238, 209, 1);
    }
    else if (value < 10) {
      double t = (value-5) / 5;
      return Color.lerp(Color.fromRGBO(136, 238, 209, 1), Color.fromRGBO(148, 198, 255, 1), t);
    }
    else if (value == 10) {
      return Color.fromRGBO(148, 198, 255, 1);
    }
    return _thumbColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCFAF5),
      body: TabBarView(
        controller: _tabController,
        children: [
          Mainpage(),
          Analysispage(),
          Center(),
          NotificationPage(),
          Center(),
        ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffFCFAF5),
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _currentPageIndex == 0 ? Colors.black : Colors.grey,
            ), 
            label: '홈'
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.analytics,
              color: _currentPageIndex == 1 ? Colors.black : Colors.grey,
            ), 
            label: '분석'
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.feed,
              color: _currentPageIndex == 2 ? Colors.black : Colors.grey,
            ), 
            label: '피드'
          ),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: '알림'
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
        ],
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
            _tabController.index = index;
          });
        },
      ),
    );
  }
}

TextStyle _textStyle = TextStyle(
  fontFamily: 'gangwon',
  fontSize: 15,
);

TextStyle _emotion = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 11,
  letterSpacing: 0
);
