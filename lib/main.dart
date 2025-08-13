import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ver1/analysispage/analysispage.dart';
import 'package:ver1/login.dart';
import 'package:ver1/main2.dart';
import 'package:ver1/main3.dart';
import 'package:ver1/mainPage/mainpage.dart';
import 'package:ver1/notificationpage/notification.dart';
import 'package:ver1/onboarding.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> globalCreate(
  String title,
  String text,
  String text2,
  String text3,
) async {
  await FirebaseFirestore.instance.collection('users').add({
    'title': title,
    'text': text,
    'text2': text2,
    'text3': text3,
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String title = '';
  String text = '';
  String text2 = '';
  String text3 = '';

  final createRef = FirebaseFirestore.instance.collection('happily');

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

      initialRoute: '/onboarding',
      routes: {
        '/onboarding': (_) => const Onboarding(),
        '/login': (_) => const LoginPage(),
        '/home':  (_) => const MyHomePage(), // 기존 홈 위젯
      },
    );
    
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _currentPageIndex = 0;
  late TabController _tabController;
  late String userID; // login page에서 받아올 id

  double emotion = 0;
  bool hasEmotion = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
    if (_tabController.indexIsChanging) return; // 애니메이션 중 이벤트 필터링(선택)
    setState(() => _currentPageIndex = _tabController.index);
  });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ✅ /home 라우트 진입 시 전달된 arguments에서 userID 읽기
    final args = ModalRoute.of(context)!.settings.arguments;
    userID = (args ?? '') as String;
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
            onEmotionChanged: (newEmotion) {
              setState(() {
                emotion = newEmotion;
                hasEmotion = true;
              });
            },
          ),
          Analysispage(userID: userID, emotion: emotion, hasEmotion: hasEmotion),
          MyApp2(),
          NotificationPage(title: 'string'),
          ProfileMain(
          //   diarytitle: TitleController.text,
          //   diarytext: FirstTextController.text,
          //   diarytext2: SecondTextController.text,
          //   diarytext3: ThirdTextController.text,
         ),
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
