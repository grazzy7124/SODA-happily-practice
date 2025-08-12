import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ver1/mainPage/myDiary/mydiaryFirstType.dart';

class FirstDiaryPage extends StatefulWidget {
  const FirstDiaryPage({
    super.key,
   required this.emotion,
  });

 final double emotion;

  @override
  State<FirstDiaryPage> createState() => _FirstDiaryPageState();
}

class _FirstDiaryPageState extends State<FirstDiaryPage> {
  bool isReleased = false;
  final String formattedDate = DateFormat(
    'yyyy년 MM월 dd일',
  ).format(DateTime.now());
  int _selectedIndex = 0;

  final titleController = TextEditingController();
  final firstTextController = TextEditingController();
  final secondTextController = TextEditingController();
  final thirdTextController = TextEditingController();

  int getSelectedIndex(double currentEmotion) {
    if (currentEmotion <= -8) return 0;
    if (currentEmotion <= -3) return 1;
    if (currentEmotion <= 2) return 2;
    if (currentEmotion <= 7) return 3;
    if (currentEmotion <= 10) return 4;
    return 0;
  }

  @override
  void initState() {
    super.initState();
  _selectedIndex = getSelectedIndex(
      widget.emotion
      );
  }

  @override
  void dispose() {
    titleController.dispose();
    firstTextController.dispose();
    secondTextController.dispose();
    thirdTextController.dispose();
    super.dispose();
  }

  Future<void> _saveAndOpenDetail() async {
  final feedsRef = FirebaseFirestore.instance.collection('feeds');
  final docRef = await feedsRef.add({
    'title': titleController.text.trim(),
    'text1': firstTextController.text.trim(),
    'text2': secondTextController.text.trim(),
    'text3': thirdTextController.text.trim(),
    'date': formattedDate,
    'emotionIndex': _selectedIndex,
    'isReleased': isReleased,
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),});


    if (!mounted) return;
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => MydiaryFirstType(docId: docRef.id)),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCFAF5),
      body: Column(
        children: [
          const SizedBox(height: 30),
          SizedBox(
            height: 43,
            child: Stack(
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
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
                      side: WidgetStateBorderSide.resolveWith(
                        (states) =>
                            const BorderSide(color: Colors.black, width: 2),
                      ),
                      value: isReleased,
                      onChanged: (bool? value) {
                        setState(() => isReleased = value ?? false);
                      },
                    ),
                    Text('공개', style: _dateStyle),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _saveAndOpenDetail,
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
                    color: const Color(0xffD9ECFA),
                    child: Row(
                      children: [
                        const SizedBox(width: 21),
                        Text(formattedDate, style: _dateStyle),
                        const SizedBox(width: 70),
                        DropdownButton<int>(
                          value: _selectedIndex,
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() => _selectedIndex = value);
                          },
                          items: List.generate(5, (i) {
                            return DropdownMenuItem(
                              value: i,
                              child: Image.asset(
                                'assets/images/emotions/emotion${i + 1}.png',
                                width: 28,
                                height: 23,
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
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
                    color: const Color(0xffD9ECFA),
                    child: Row(
                      children: [
                        const SizedBox(width: 30),
                        Text('제목: ', style: _titleStyle),
                        Expanded(
                          child: TextFormField(
                            controller: titleController,
                            style: _titleStyle,
                            decoration: const InputDecoration(
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
                      TextFormField(
                        controller: firstTextController,
                        style: _textStyle,
                        decoration: InputDecoration(
                          hintText: '오늘은 어떤 일이 있었나요?',
                          hintStyle: _hintStyle,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffEAEAEA),
                              width: 2,
                            ),
                          ),
                        ),
                        maxLines: 5,
                      ),
                      TextFormField(
                        controller: secondTextController,
                        style: _textStyle,
                        decoration: InputDecoration(
                          hintText: '어떤 생각이 들었나요?',
                          hintStyle: _hintStyle,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffEAEAEA),
                              width: 2,
                            ),
                          ),
                        ),
                        maxLines: 5,
                      ),
                      TextFormField(
                        controller: thirdTextController,
                        style: _textStyle,
                        decoration: InputDecoration(
                          hintText: '어떤 감정을 느꼈나요?',
                          hintStyle: _hintStyle,
                          enabledBorder: const UnderlineInputBorder(
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

TextStyle _hintStyle = const TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.w300,
  fontSize: 16,
  letterSpacing: 0.6,
  color: Color(0xffC3C3C3),
);

TextStyle _textStyle = const TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.w300,
  fontSize: 16,
  letterSpacing: 0.6,
  color: Color(0xff000000),
);

TextStyle _titleStyle = const TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 16,
  letterSpacing: 0.6,
  color: Color(0xff000000),
);

TextStyle _dateStyle = const TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 18,
  letterSpacing: 0.6,
  color: Color(0xff000000),
);

TextStyle _cancleStyle = const TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 20,
  letterSpacing: 0.6,
  color: Color(0xffD70004),
);

TextStyle _uploadStyle = const TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 20,
  letterSpacing: 0.6,
  color: Color(0xff80C2FF),
);
