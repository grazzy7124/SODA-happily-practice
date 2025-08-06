import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FirstDiaryPage extends StatefulWidget {
  const FirstDiaryPage({super.key});

  @override
  State<FirstDiaryPage> createState() => _FirstDiaryPageState();
}

class _FirstDiaryPageState extends State<FirstDiaryPage> {
  bool isChecked = false;
  DateTime todayDate = DateTime.now();
  String formattedDate = DateFormat(' yyyy년  MM월  dd일 ').format(DateTime.now());
  int _selectedIndex = 0; // dropdownbuttonItem

  // 제목 받아오는 컨트롤러
  final titleController = TextEditingController();
  // 첫 번째 본문 컨트롤러
  final firstTextController = TextEditingController();
  // 두 번쨰 본문 컨트롤러
  final secondTextController = TextEditingController();
  // 세 번째 본문 컨트롤러 
  final thirdTextController = TextEditingController();

  // String title = titleController.text;

  @override
  void dispose () {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCFAF5),
      body: Column(
        children: [
          SizedBox(height: 30),
          Container(
            height: 43,
            child: Stack(
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('취소', style: _cancleStyle),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      checkColor: Colors.black,
                      activeColor: Colors.transparent,
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Text('공개', style: _dateStyle),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        print(titleController.text); // 제목 출력
                      },
                      child: Text('등록', style: _uploadStyle),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(height: 1, width: double.infinity, color: Colors.black),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                SizedBox(
                  height: 45,
                  child: Card(
                    color: Color(0xffD9ECFA),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(formattedDate, style: _dateStyle),
                        SizedBox(width: 30),
                        DropdownButton(
                          value: _selectedIndex,
                          items: [
                            DropdownMenuItem(
                              value: 0,
                              child: Image.asset(
                                'assets/images/emotions/emotion1.png',
                                width: 28,
                                height: 23,
                              ),
                            ),
                            DropdownMenuItem(
                              value: 1,
                              child: Image.asset(
                                'assets/images/emotions/emotion2.png',
                                width: 28,
                                height: 23,
                              ),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Image.asset(
                                'assets/images/emotions/emotion3.png',
                                width: 28,
                                height: 23,
                              ),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Image.asset(
                                'assets/images/emotions/emotion4.png',
                                width: 28,
                                height: 23,
                              ),
                            ),
                            DropdownMenuItem(
                              value: 4,
                              child: Image.asset(
                                'assets/images/emotions/emotion5.png',
                                width: 28,
                                height: 23,
                              ),
                            ),
                          ],
                          onChanged: (int? value) {
                            setState(() {
                              if (value != null) {
                                _selectedIndex = value;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 180,
                  child: GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/images/diary/photo.png',
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                  child: Card(
                    color: Color(0xffD9ECFA),
                    child: Row(
                      children: [
                        SizedBox(width: 30),
                        Text('제목: ', style: _titleStyle),
                        Expanded(
                          child: TextField(
                            controller: titleController,
                            style: _titleStyle,
                            // cursorHeight: 20,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: firstTextController,
                        style: _textStyle,
                        decoration: InputDecoration(
                          hint: Text('오늘은 어떤 일이 있었나요?', style: _hintStyle),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffEAEAEA),
                              width: 2,
                            ),
                          ),
                        ),
                        maxLines: 5,
                      ),
                      TextField(
                        controller: secondTextController,
                        style: _textStyle,
                        decoration: InputDecoration(
                          hint: Text('어떤 생각이 들었나요?', style: _hintStyle),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffEAEAEA),
                              width: 2,
                            ),
                          ),
                        ),
                        maxLines: 5,
                      ),
                      TextField(
                        controller: thirdTextController,
                        style: _textStyle,
                        decoration: InputDecoration(
                          hint: Text('어떤 감정을 느꼈나요?', style: _hintStyle),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffEAEAEA),
                              width: 2,
                            ),
                          ),
                        ),
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

TextStyle _hintStyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.w300,
  fontSize: 16,
  letterSpacing: 0.6,
  color: Color(0xffC3C3C3),
);

TextStyle _textStyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.w300,
  fontSize: 16,
  letterSpacing: 0.6,
  color: Color(0xff000000),
);

TextStyle _titleStyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 16,
  letterSpacing: 0.6,
  color: Color(0xff000000),
);

TextStyle _dateStyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 18,
  letterSpacing: 0.6,
  color: Color(0xff000000),
);

TextStyle _cancleStyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 20,
  letterSpacing: 0.6,
  color: Color(0xffD70004),
);

TextStyle _uploadStyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 20,
  letterSpacing: 0.6,
  color: Color(0xff80C2FF),
);
