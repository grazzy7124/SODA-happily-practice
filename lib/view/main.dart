import 'package:flutter/material.dart';
import 'package:ver1/provider/emotion_provider.dart';
import 'package:ver1/view/analysispage/analysispage.dart';
import 'package:ver1/view/main2.dart';
import 'package:ver1/view/main3.dart';
import 'package:ver1/view/mainPage/mainpage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ver1/view/notificationpage/notification.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return EmotionProvider();
          }
        )
      ],
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [Locale('ko', 'KR')],
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _currentPageIndex = 0;
  late TabController _tabController;

  double emotion = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCFAF5),
      body: TabBarView(
        controller: _tabController,
        children: [
          Mainpage(
            emotion: emotion,
            onEmotionChanged: (value) {
              setState(() {
                emotion = value;
              });
            },
          ),
          Analysispage(emotion: emotion,),
          MyApp2(),
          NotificationPage(),
          ProfileMain(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffFCFAF5),
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
            _tabController.index = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _currentPageIndex == 0
                ? Image.asset(
                    'assets/images/navigationBarItems/home_filled.png',
                    width: 21,
                  )
                : Image.asset(
                    'assets/images/navigationBarItems/home.png',
                    width: 21,
                  ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: _currentPageIndex == 1
                ? Image.asset(
                    'assets/images/navigationBarItems/analysis_filled.png',
                    width: 21,
                  )
                : Image.asset(
                    'assets/images/navigationBarItems/analysis.png',
                    width: 21,
                  ),
            label: '분석',
          ),
          BottomNavigationBarItem(
            icon: _currentPageIndex == 2
                ? Image.asset(
                    'assets/images/navigationBarItems/feed_filled.png',
                    width: 21,
                  )
                : Image.asset(
                    'assets/images/navigationBarItems/feed.png',
                    width: 21,
                  ),
            label: '피드',
          ),
          BottomNavigationBarItem(
            icon: _currentPageIndex == 3
                ? Image.asset(
                    'assets/images/navigationBarItems/notification_filled.png',
                    width: 21,
                  )
                : Image.asset(
                    'assets/images/navigationBarItems/notification.png',
                    width: 21,
                  ),
            label: '알림',
          ),
          BottomNavigationBarItem(
            icon: _currentPageIndex == 4
                ? Image.asset(
                    'assets/images/navigationBarItems/feed_filled.png',
                    width: 21,
                  )
                : Image.asset(
                    'assets/images/navigationBarItems/feed.png',
                    width: 21,
                  ),
            label: '마이페이지',
          ),
        ],
      ),
    );
  }
}
