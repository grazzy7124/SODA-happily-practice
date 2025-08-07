import 'package:flutter/material.dart';
import 'package:ver1/main.dart';
import 'package:ver1/write.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key, required this.diaryTitle1});

  final String diaryTitle1;

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            SizedBox(height: 30),
            Row(
              children: [
                SizedBox(width: 19.5),
                Text('알림', style: _notificationStyle),
              ],
            ),
            CardItem('라이딩 러버', true, diaryTitle1: widget.diaryTitle1),
            CardItem('예은', true, diaryTitle1: widget.diaryTitle1),
            CardItem('차은우', false, diaryTitle1: widget.diaryTitle1),
          ],
        ),
      ],
    );
  }
}

class CardItem extends StatefulWidget {
  late String name = '';
  final String diaryTitle1;
  late bool isEmotion = false;
  final String profilePicture;

  // true=>표정을 남겼습니다, false=>댓글을 남겼습니다

  // String getName() {
  //   return name;
  // }

  // String getDiaryTitle () {
  //   return diaryTitle;
  // }

  // bool getIsEmotion () {
  //   return isEmotion;
  // }

  // String getProfilePicture () {
  //   return profilePicture;
  // }

  CardItem(
    this.name,
    this.isEmotion, {
    super.key,
    this.profilePicture = 'assets/images/smileface.png',
    required this.diaryTitle1,
  });

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  late bool _isVisible = true;
  late var titleController = TextEditingController();

  void initState() {
    super.initState();
    titleController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    return SizedBox(
      height: 57,
      child: Card(
        color: Color(0xffFFFFF6),
        child: Row(
          children: [
            SizedBox(width: 20),
            Image.asset(widget.profilePicture, width: 25),
            SizedBox(width: 17),
            GestureDetector(
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => Write(diaryTitle1: diaryTitle1, diaryTitle2: diaryTitle2)),
              //   );
              // },
              child: Flexible(
                child: widget.isEmotion
                    ? RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: widget.diaryTitle1,
                              style: _cardItemStyle,
                            ),
                            TextSpan(text: '님이 ', style: _cardItemStyle),
                            TextSpan(
                              text: widget.diaryTitle1,
                              style: _boldCardItemStyle,
                            ),
                            TextSpan(
                              text: ' 글에 표정을 남겼습니다.',
                              style: _cardItemStyle,
                            ),
                          ],
                        ),
                      )
                    : RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: widget.diaryTitle1,
                              style: _cardItemStyle,
                            ),
                            TextSpan(text: '님이 ', style: _cardItemStyle),
                            TextSpan(
                              text: widget.diaryTitle1,
                              style: _boldCardItemStyle,
                            ),
                            TextSpan(
                              text: ' 글에 댓글을 남겼습니다.',
                              style: _cardItemStyle,
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isVisible = false;
                });
              },
              child: Image.asset('assets/images/X.png', width: 13),
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}

TextStyle _notificationStyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 23,
  letterSpacing: 0.6,
);

TextStyle _cardItemStyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.w300,
  fontSize: 15,
  letterSpacing: 0.6,
  color: Color(0xff000000),
);

TextStyle _boldCardItemStyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 15,
  letterSpacing: 0.6,
  color: Color(0xff000000),
);
