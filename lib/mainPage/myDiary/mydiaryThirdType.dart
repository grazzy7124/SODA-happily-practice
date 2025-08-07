// 등록한 내 일기 페이지 - 행복일기

import 'package:flutter/material.dart';
import 'package:ver1/color.dart';

class MydiaryThirdType extends StatefulWidget {
  final int selectedIndex;
  final String date;
  final String title;
  final String text;
  final String image;
  final bool isReleased;

  const MydiaryThirdType({
        super.key, required this.date, required this.selectedIndex,
        required this.title, required this.text, 
        required this.isReleased,
        this.image = 'assets/images/defaultImage.png'
      }
    );

  @override
  State<MydiaryThirdType> createState() => _MydiaryThirdTypeState();
}

class _MydiaryThirdTypeState extends State<MydiaryThirdType> {
  late int _selectedIndex;
  late String date;
  late String title;
  late String text;
  late String image;
  late bool isReleased;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = widget.date;
    _selectedIndex = widget.selectedIndex;
    title = widget.title;
    text = widget.text;
    image = widget.image;
    isReleased = widget.isReleased;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCFAF5),
      appBar: AppBar(
        backgroundColor: Color(0xffFCFAF5),
        leading: Row(
          children: [
            SizedBox(width: 22,),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/Vector.png',
                width: 9,
              ),
            ),
          ],
        ),
        title: isReleased ? 
          Text('공개글', style: _titleStyle,) 
          : Text('비공개글', style: _titleStyle,),
        centerTitle: true,
        actions: [
          Row(
            children: [
              Image.asset(
                'assets/images/action.png',
                height: 16,
              ),
              SizedBox(width: 25,)
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 45,
                child: Card(
                  color: thirdDiaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 21,),
                      Text(date, style: _dateStyle),
                      SizedBox(width: 70,),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 180,
                    child: GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        image,
                        width: 171,
                        height: 143,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 45,
                child: Card(
                  color: thirdDiaryColor,
                  child: Row(
                    children: [
                      SizedBox(width: 30),
                      Text('제목: ', style: _titleStyle),
                      Text(title, style: _titleStyle,)
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 10,),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(text, style: _textStyle,),
                      ],
                    ),
                  ),
                ],
              )
              
            ],
          ),
        ),
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
