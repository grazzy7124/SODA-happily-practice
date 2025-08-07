import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

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
            SizedBox(height: 30,),
            Row(
              children: [
                SizedBox(width: 19.5,),
                Text(
                  '알림',
                  style: _notificationStyle,
                ),
              ],
            ),
            CardItem('라이딩 러버', '이별한 지 23일', true,),
            CardItem('예은', '이별한 지 23일', true),
            CardItem('차은우', '이별한 지 23일', false),
          ],
        ),
      ],
    );
  }
}

class CardItem extends StatefulWidget {
  late String name = '';
  late String diaryTitle = '';
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

 CardItem(this.name, this.diaryTitle, this.isEmotion, {super.key, this.profilePicture = 'assets/images/smileface.png'});

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool _isVisible = true;  

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    return SizedBox(
      height: 57,
      child: Card(
        color: Color(0xffFFFFF6),
        child: Row(
          children: [
            SizedBox(width: 20,),
            Image.asset(
              widget.profilePicture,
              width: 25,
            ),
            SizedBox(width: 17,),
            Flexible(
              child: widget.isEmotion 
              ? RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.name,
                      style: _cardItemStyle,
                    ),
                    TextSpan(
                      text: '님이 ',
                      style: _cardItemStyle,
                    ),
                    TextSpan(
                      text: widget.diaryTitle,
                      style: _boldCardItemStyle,
                    ),
                    TextSpan(
                      text: ' 글에 표정을 남겼습니다.',
                      style: _cardItemStyle,
                    ),
                  ]
                )
              )
              : RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.name,
                      style: _cardItemStyle,
                    ),
                    TextSpan(
                      text: '님이 ',
                      style: _cardItemStyle,
                    ),
                    TextSpan(
                      text: widget.diaryTitle,
                      style: _boldCardItemStyle,
                    ),
                    TextSpan(
                      text: ' 글에 댓글을 남겼습니다.',
                      style: _cardItemStyle,
                    ),
                  ]
                )
              )
            ),
            SizedBox(width: 17,),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isVisible = false;
                });
              },
              child: Image.asset(
                'assets/images/X.png',
                width: 13,
              ),
            ),
            SizedBox(width: 20,)
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
  color: Color(0xff000000)
);

TextStyle _boldCardItemStyle = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 15,
  letterSpacing: 0.6,
  color: Color(0xff000000)
);

