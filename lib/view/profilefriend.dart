import 'package:flutter/material.dart';
import 'package:ver1/view/request.dart';

class WholeProfile extends StatelessWidget {
  const WholeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Whole(), backgroundColor: Color(0xffFCFAF5));
  }
}

class Whole extends StatelessWidget {
  const Whole({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        WholeProfileMain(
          wholemain: 'assets/main/1.png',
          wholename: '보들이발닦개',
          wholefriend: '23',
        ),
        Divider(),
        WholeProfileList(
          wholetitle: '보드리랑 산책',
          wholephoto: 'assets/mainlist/1.png',
          wholetext: '오늘은 하루종일 뒹굴대다가 저녁에 보들이랑 산책을 했다.',
          wholetext2: '산책하는데 보들이가 똥을 3번이나 쌌다. 치우기 힘들었다...',
        ),
        WholeProfileList(
          wholetitle: '그림 그리기 우승',
          wholephoto: 'assets/123.jpg',
          wholetext: '흐흐 그림 그리기 대회 우승했당~~',
          wholetext2: '친구들한테 자랑하깅~~><',
        ),
        SizedBox(height: 40),
      ],
    );
  }
}

class WholeProfileMain extends StatefulWidget {
  const WholeProfileMain({
    super.key,
    required this.wholemain,
    required this.wholename,
    required this.wholefriend,
  });

  final String wholemain;
  final String wholename;
  final String wholefriend;

  @override
  State<WholeProfileMain> createState() => _WholeProfileMainState();
}

class _WholeProfileMainState extends State<WholeProfileMain> {
  bool isFriendAdded = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            SizedBox(width: 10,),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Image.asset(
                'assets/Vector.png',
                width: 13, height: 20,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 25, top: 20, bottom: 10),
          child: Image.asset(widget.wholemain, width: 39, height: 39),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.wholename, style: TextStyle(fontSize: 16)),
              Text(
                '${widget.wholefriend}명의 친구',
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, left: 80, bottom: 10),
          child: SizedBox(
            height: 30,
            child: TextButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FriendRequest()),
                );
                if (result == true) {
                  setState(() {
                    isFriendAdded = true;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScreenA(
                        wholemain: widget.wholemain,
                        wholename: widget.wholename,
                      ),
                    ),
                  );
                }
              },
              style: TextButton.styleFrom(
                fixedSize: Size(71, 31),
                foregroundColor: Colors.black,
                side: BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                isFriendAdded ? '친구' : '+친구 신청',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class WholeProfileList extends StatelessWidget {
  const WholeProfileList({
    super.key,
    required this.wholetitle,
    required this.wholephoto,
    required this.wholetext,
    required this.wholetext2,
  });

  final String wholetitle;
  final String wholephoto;
  final String wholetext;
  final String wholetext2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
      child: Card(
        color: Color(0xffFFFFF6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 22, top: 25),
              child: Row(
                children: [
                  SizedBox(width: 7),
                  Text(wholetitle, style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(22),
              child: SizedBox(
                width: double.infinity,
                height: 230,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(wholephoto, fit: BoxFit.fill),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 22),
              child: Text(wholetext, style: TextStyle(fontSize: 15)),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(left: 22),
              child: Text(wholetext2, style: TextStyle(fontSize: 15)),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
