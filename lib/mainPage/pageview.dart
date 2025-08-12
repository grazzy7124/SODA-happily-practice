import 'package:flutter/material.dart';
import 'package:ver1/mainPage/diarypage/diary1.dart';
import 'package:ver1/mainPage/diarypage/diary2.dart';
import 'package:ver1/mainPage/diarypage/diary3.dart';

class DiaryPageView extends StatefulWidget {
  final double currentEmotion;

  const DiaryPageView({
    super.key,
    required this.currentEmotion,
  });

  @override
  State<DiaryPageView> createState() => _DiaryPageViewState();
}

class _DiaryPageViewState extends State<DiaryPageView>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  late double emotion;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 3, vsync: this);
    emotion = widget.currentEmotion;
  }

  // 위젯
  @override
  void didUpdateWidget(covariant DiaryPageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentEmotion != oldWidget.currentEmotion) {
      setState(() {
        emotion = widget.currentEmotion;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        PageView(
          controller: _pageViewController,
          onPageChanged: _handlePageViewChanged,
          children: <Widget>[
            FirstDiary(currentEmotion: emotion),
            SecondDiary(currentEmotion: emotion),
            ThirdDiary(currentEmotion: emotion),
          ],
        ),
        PageIndicator(
          tabController: _tabController,
          currentPageIndex: _currentPageIndex,
          onUpdateCurrentPageIndex: _updateCurrentPageIndex,
        ),
      ],
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
  });

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Row(
                    children: [
                      IconButton(
                        splashRadius: 16.0,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          if (currentPageIndex == 0) {
                            return;
                          }
                          onUpdateCurrentPageIndex(currentPageIndex - 1);
                        },
                        icon: Image.asset(
                          'assets/main/pageindicator_left.png',
                          width: 10.51,
                          height: 20.01,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        splashRadius: 16.0,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          if (currentPageIndex == 2) {
                            return;
                          }
                          onUpdateCurrentPageIndex(currentPageIndex + 1);
                        },
                        icon: Image.asset(
                          'assets/main/pageindicator_right.png',
                          width: 10.51,
                          height: 20.01,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TabPageSelector(
                    controller: tabController,
                    color: Color.fromRGBO(216, 216, 216, 1),
                    selectedColor: Color.fromRGBO(24, 41, 73, 1),
                    borderStyle: BorderStyle.none,
                    indicatorSize: 8,
                  ),
                ],
              ),
              SizedBox(height: 30.5),
            ],
          ),
        ],
      ),
    );
  }
}
