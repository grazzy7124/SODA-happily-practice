import 'package:flutter/material.dart';

class FriendRequest extends StatefulWidget {
  const FriendRequest({super.key});

  @override
  State<FriendRequest> createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  bool checked = false;

 Future<void> onConfirm() async {
  Navigator.pop(context, checked);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFCFAF5),
        automaticallyImplyLeading: false,
        title: FriendRequestAppbar(Confirm: onConfirm),
      ),
      body: FriendRequestMain(
        wholemain: 'assets/main/1.png',
        wholename: '보들이발닦개',
        isChecked: checked,
        onCheckChanged: (val) => setState(() => checked = val),
      ),
      backgroundColor: Color(0xffFCFAF5),
    );
  }
}

class FriendRequestAppbar extends StatelessWidget {
  const FriendRequestAppbar({super.key, required this.Confirm});

  final VoidCallback Confirm;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text('취소', style: TextStyle(fontSize: 19)),
        ),
        Text('친구추가'),
        GestureDetector(
          onTap: Confirm,
          child: Text('확인', style: TextStyle(fontSize: 19)),
        ),
      ],
    );
  }
}

class FriendRequestMain extends StatefulWidget {
  const FriendRequestMain({
    super.key,
    required this.wholemain,
    required this.wholename,
    required this.isChecked,
    required this.onCheckChanged,
  });

  final String wholemain;
  final String wholename;
  final bool isChecked;
  final ValueChanged<bool> onCheckChanged;

  @override
  State<FriendRequestMain> createState() => _FriendRequestMainState();
}

class _FriendRequestMainState extends State<FriendRequestMain> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 225, top: 25),
          child: SizedBox(
            width: 49,
            height: 49,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(widget.wholemain, fit: BoxFit.fill),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 200, top: 25),
          child: Text(widget.wholename, style: TextStyle(fontSize: 18)),
        ),
        Padding(
          padding: EdgeInsets.only(left: 62, top: 50),
          child: Container(
            width: 353,
            height: 100,
            decoration: BoxDecoration(
              color: Color(0xffFFEBEB),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 100),
              child: Row(
                children: [
                  const Text('친구로 추가합니다. ', style: TextStyle(fontSize: 19)),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      widget.onCheckChanged(!widget.isChecked);
                    },
                    child: Container(
                      width: 17,
                      height: 17,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.isChecked
                            ? Color(0xffFFA1A1)
                            : Color(0xffFFEBEB),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          size: 13,
                          color: widget.isChecked
                              ? Colors.black
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ScreenA extends StatelessWidget {
  const ScreenA({
    super.key,
    required this.wholemain,
    required this.wholename,
    this.onTap,
  });

  final String wholemain;
  final String wholename;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 225, top: 25),
            child: SizedBox(
              width: 49,
              height: 49,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(wholemain, fit: BoxFit.fill),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 200, top: 25),
            child: Text(wholename, style: TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: EdgeInsets.only(left: 180, top: 25),
            child: Text('친구 추가했습니다.', style: TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: EdgeInsets.only(left: 62, top: 50),
            child: Container(
              width: 353,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xffFFEBEB),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 70),
                child: Row(
                  children: [
                    Text('보들이발닦개님 홈가기', style: TextStyle(fontSize: 19)),
                    SizedBox(width: 55),
                    GestureDetector(
                      onTap:
                          onTap ??
                          () {
                            Navigator.pop(context, true);
                          },
                      child: Icon(Icons.chevron_right, size: 28),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}