import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ver1/mainPage/diarypage/diary1.dart';
import 'package:ver1/mainPage/diarypage/diary1_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _idController = TextEditingController(); // 아이디
  final _pwController = TextEditingController(); // 비밀번호
  bool isEnabled = true;

  late bool focused = false;

  Color fillColor = Color(0xffDBECFF);

  @override
  void initState() {
    super.initState();
    _idController.addListener(_onTextChanged);
    _pwController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _idController.removeListener(_onTextChanged);
    _pwController.removeListener(_onTextChanged);
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    String id = _idController.text.trim();
    String pw = _pwController.text.trim();

    if (id.isNotEmpty && pw.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('아이디와 비밀번호를 입력하세요.')));
      return;
    }

    await FirebaseFirestore.instance.collection('users').doc(id).set({
      'userID': id,
      'nickname': '고먐미',
    }, SetOptions(merge: true));

      Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: id, // ← 이 값이 MyHomePage에서 받게 될 userID
      );
    }

  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => FirstDiary(
  //         emotion: 0.0,
  //         userID: _idController.text.trim(), 
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 133),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/icon.png',
                width: 148.72,
                height: 122.6,
              ),
            ],
          ),
          SizedBox(height: 16.4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/HAPPI-LY.png', width: 116, height: 39),
            ],
          ),
          SizedBox(height: 51),
          SizedBox(
            width: 273,
            child: TextFormField(
              controller: _idController,
              enabled: isEnabled,
              decoration: InputDecoration(
                fillColor: fillColor,
                filled: _idController.text.isNotEmpty && isEnabled,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.black),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Color(0xff999999)),
                ),
                hint: Text('아이디', style: TextStyle(color: Color(0xff999999))),
              ),
            ),
          ),
          SizedBox(height: 12),
          SizedBox(
            width: 273,
            child: TextFormField(
              controller: _pwController,
              enabled: isEnabled,
              decoration: InputDecoration(
                fillColor: fillColor,
                filled: _pwController.text.isNotEmpty && isEnabled,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.black),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Color(0xff999999)),
                ),
                hint: Text('비밀번호', style: TextStyle(color: Color(0xff999999))),
              ),
            ),
          ),
          SizedBox(height: 22),
          TextButton(
            style: ButtonStyle(
              fixedSize: WidgetStatePropertyAll(Size(273, 54)),
              backgroundColor: WidgetStateProperty.all(Color(0xff444444)),
              shape: WidgetStatePropertyAll(
                RoundedSuperellipseBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            onPressed: () {
              _login();
            },
            child: Text('로그인', style: TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 40),
          SizedBox(
            height: 40,
            width: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(
                        Color.fromARGB(9, 0, 0, 0),
                      ),
                      fixedSize: WidgetStatePropertyAll(Size(80, 18)),
                      backgroundColor: WidgetStateProperty.all(
                        Colors.transparent,
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedSuperellipseBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'ID/PW 찾기',
                      style: TextStyle(color: Color(0xffADADAD), fontSize: 16),
                    ),
                  ),
                ),
                VerticalDivider(
                  color: Color(0xffADADAD),
                  thickness: 1,
                  width: 1,
                  endIndent: 7,
                  indent: 7,
                ),
                TextButton(
                  style: ButtonStyle(
                    overlayColor: WidgetStatePropertyAll(
                      Color.fromARGB(9, 0, 0, 0),
                    ),
                    // fixedSize: WidgetStatePropertyAll(Size(80, 18)),
                    backgroundColor: WidgetStateProperty.all(
                      Colors.transparent,
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedSuperellipseBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    '회원가입',
                    style: TextStyle(color: Color(0xffADADAD), fontSize: 16),
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
