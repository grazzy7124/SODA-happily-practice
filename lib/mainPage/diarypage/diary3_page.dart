import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ver1/mainPage/myDiary/mydiaryThirdType.dart';

class ThirdDiaryPage extends StatefulWidget {
  final double emotion;
  final String userID;

  const ThirdDiaryPage({super.key, required this.emotion, required this.userID});

  @override
  State<ThirdDiaryPage> createState() => _ThirdDiaryPageState();
}

class _ThirdDiaryPageState extends State<ThirdDiaryPage> {
  bool isReleased = false;
  final String formattedDate = DateFormat(
    'yyyy년 MM월 dd일',
  ).format(DateTime.now());
  int _selectedIndex = 0;
  late bool showImage;

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
    _selectedIndex = getSelectedIndex(widget.emotion);
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
      'diaryID' : 'diary.free',
      'userID' : widget.userID,
      'title': titleController.text.trim(),
      'text1': firstTextController.text.trim(),
      'text2': secondTextController.text.trim(),
      'text3': thirdTextController.text.trim(),
      'date': formattedDate,
      'emotionIndex': _selectedIndex,
      'isReleased': isReleased,
      'createdAt': FieldValue.serverTimestamp(),
    });

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MydiaryThirdType(docId: docRef.id)),
    );
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
                      side: MaterialStateBorderSide.resolveWith(
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
                    color: const Color(0xffF9EEF3),
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
                    color: Color(0xffF9EEF3),
                    child: Row(
                      children: [
                        SizedBox(width: 30),
                        Text('제목: ', style: _titleStyle),
                        Expanded(
                          child: TextField(
                            controller: titleController,
                            style: _titleStyle,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: firstTextController,
                      style: _textStyle,
                      decoration: InputDecoration(
                        hint: Text('자유롭게 하루 일기를 남겨 주세요.', style: _hintStyle),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffEAEAEA),
                            width: 2,
                          ),
                        ),
                      ),
                      maxLines: 15,
                    ),
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
