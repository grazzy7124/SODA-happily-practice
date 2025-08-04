import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: MyApp2()));

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color(0xffFCFAF5),
          body: Column(
            children: [
              Container(
                color: Color(0xffFCFAF5),
                child: const TabBar(
                  tabs: [
                    Tab(text: '전체 일기'),
                    Tab(text: '친구 일기'),
                  ],
                  labelColor: Colors.black,
                  unselectedLabelColor: Color(0xff878787),
                  indicatorColor: Colors.black,
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(child: Text('전체 일기 내용')),
                    Center(child: Text('친구 일기 내용')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageList extends StatelessWidget {
  const PageList({super.key, required this.happliy, required this.title, required this.photo, required this.text, required this.date, required this.public});

  final String happliy;
  final String title;
  final String photo;
  final String text;
  final String date;
  final String public;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(children: [Image.asset(happliy), Text(title)]),
          Image.asset(photo),
          Text(text),
          Row(
            children: [
              Text(date),
              Text(public)
            ],
          ),
        ],
      ),
    );
  }
}
