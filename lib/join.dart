import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({super.key});

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  // 약관 체크 상태
  bool isChecked = false;
  bool _isChecked1 = false; // 필수
  bool _isChecked2 = false; // 필수
  bool _isChecked3 = false; // 필수
  bool _isChecked4 = false; // 선택

  // 전체 동의 → 개별도 모두 동일하게
  void _toggleAll(bool value) {
    setState(() {
      isChecked = value;
      _isChecked1 = value;
      _isChecked2 = value;
      _isChecked3 = value;
      _isChecked4 = value;
    });
  }

  // 개별 → 전체 동기화
  void _syncMaster() {
    final allOn = _isChecked1 && _isChecked2 && _isChecked3 && _isChecked4;
    setState(() {
      isChecked = allOn;
    });
  }

  // 입력 필드 컨트롤러
  final _nicknameCtrl = TextEditingController();
  final _userIDCtrl = TextEditingController(); // 화면에서 "아이디"
  final _emailCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();
  final _pw2Ctrl = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nicknameCtrl.dispose();
    _userIDCtrl.dispose();
    _emailCtrl.dispose();
    _pwCtrl.dispose();
    _pw2Ctrl.dispose();
    super.dispose();
  }

  // 회원가입 처리
  Future<void> _register() async {
    // ✅ 필수 약관 확인
    if (!_isChecked1 || !_isChecked2 || !_isChecked3) {
      _showSnackBar('필수 약관에 모두 동의해주세요.');
      return;
    }

    // ✅ 입력값 검증
    final nickname = _nicknameCtrl.text.trim();
    final userID = _userIDCtrl.text.trim().toLowerCase(); // 소문자 통일 권장
    final email = _emailCtrl.text.trim();
    final pw = _pwCtrl.text.trim();
    final pw2 = _pw2Ctrl.text.trim();

    if (nickname.isEmpty || userID.isEmpty || email.isEmpty || pw.isEmpty || pw2.isEmpty) {
      _showSnackBar('모든 필드를 입력해주세요.');
      return;
    }
    if (pw.length < 8) {
      _showSnackBar('비밀번호는 최소 8자리 이상이어야 합니다.');
      return;
    }
    if (pw != pw2) {
      _showSnackBar('비밀번호가 일치하지 않습니다.');
      return;
    }

    setState(() => _isLoading = true);
    FocusScope.of(context).unfocus();

    final db = FirebaseFirestore.instance;

    try {
      // 1) Firebase Auth 계정 생성
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pw,
      );

      // 2) 표시명 업데이트(선택)
      await cred.user!.updateDisplayName(nickname);

      // 3) (중요) userID 중복 체크 — users 컬렉션만 사용, userIDs 컬렉션 없음
      //    이미 같은 userID가 있으면 방금 만든 Auth 계정을 삭제하고 에러 처리
      final dup = await db
          .collection('users')
          .where('userID', isEqualTo: userID)
          .limit(1)
          .get();

      if (dup.docs.isNotEmpty) {
        try {
          await cred.user!.delete(); // 방금 만든 계정 정리
        } catch (_) {}
        throw Exception('이미 사용 중인 아이디입니다.');
      }

      // 4) users/{uid} 문서 저장 (원하는 "원래 컬렉션" 유지)
      final uid = cred.user!.uid;
      await db.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'nickname': nickname,
        'userID': userID,          // 아이디를 필드로만 저장
        'marketingAgreed': _isChecked4,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      _showSnackBar('회원가입이 완료되었습니다.');
      if (mounted) Navigator.pushReplacementNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
      _showSnackBar(_firebaseErrorMsg(e.code));
    } catch (e) {
      _showSnackBar(e.toString().contains('이미 사용 중인 아이디')
          ? '이미 사용 중인 아이디입니다.'
          : '오류 발생: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _firebaseErrorMsg(String code) {
    switch (code) {
      case 'invalid-email':
        return '이메일 형식이 올바르지 않습니다.';
      case 'email-already-in-use':
        return '이미 사용 중인 이메일입니다.';
      case 'weak-password':
        return '비밀번호가 너무 약합니다.';
      default:
        return '회원가입 중 오류가 발생했습니다. ($code)';
    }
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCFAF5),
      appBar: AppBar(
        backgroundColor: const Color(0xffFCFAF5),
        leading: Row(
          children: [
            const SizedBox(width: 24.5),
            GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, '/onboarding'),
              child: Image.asset('assets/Vector.png', width: 9, height: 17),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 28, right: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('회원 가입하기', style: _joinStyle),
              const SizedBox(height: 50),

              // 별명
              TextField(
                controller: _nicknameCtrl,
                decoration: InputDecoration(
                  hintText: '별명을 입력해주세요',
                  hintStyle: _hintStyle,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff515155), width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 70),

              // 아이디
              TextField(
                controller: _userIDCtrl,
                decoration: InputDecoration(
                  hintText: '아이디를 입력해주세요',
                  hintStyle: _hintStyle,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff515155), width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 70),

              // 이메일
              TextField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                decoration: InputDecoration(
                  hintText: '이메일을 입력해주세요',
                  hintStyle: _hintStyle,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff515155), width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 70),

              // 비밀번호
              TextField(
                controller: _pwCtrl,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: '비밀번호 설정(최소 8자리) 입력해주세요',
                  hintStyle: _hintStyle,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff515155), width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 70),

              // 비밀번호 확인
              TextField(
                controller: _pw2Ctrl,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: '비밀번호 재입력',
                  hintStyle: _hintStyle,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff515155), width: 1),
                  ),
                ),
              ),

              // 약관 체크박스
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.black,
                    activeColor: Colors.transparent,
                    side: MaterialStateBorderSide.resolveWith(
                      (states) => const BorderSide(color: Color(0xff505050), width: 1.5),
                    ),
                    value: isChecked,
                    onChanged: (value) => _toggleAll(value ?? false),
                    shape: const CircleBorder(),
                  ),
                  const Text('전체 동의하기'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.black,
                    activeColor: Colors.transparent,
                    side: MaterialStateBorderSide.resolveWith(
                      (states) => const BorderSide(color: Color(0xff505050), width: 1.5),
                    ),
                    value: _isChecked1,
                    onChanged: (value) {
                      setState(() {
                        _isChecked1 = value ?? false;
                      });
                      _syncMaster();
                    },
                    shape: const CircleBorder(),
                  ),
                  const Text('[필수] 서비스 이용약관'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.black,
                    activeColor: Colors.transparent,
                    side: MaterialStateBorderSide.resolveWith(
                      (states) => const BorderSide(color: Color(0xff505050), width: 1.5),
                    ),
                    value: _isChecked2,
                    onChanged: (value) {
                      setState(() {
                        _isChecked2 = value ?? false;
                      });
                      _syncMaster();
                    },
                    shape: const CircleBorder(),
                  ),
                  const Text('[필수] 개인정보수집 및 이용 동의'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.black,
                    activeColor: Colors.transparent,
                    side: MaterialStateBorderSide.resolveWith(
                      (states) => const BorderSide(color: Color(0xff505050), width: 1.5),
                    ),
                    value: _isChecked3,
                    onChanged: (value) {
                      setState(() {
                        _isChecked3 = value ?? false;
                      });
                      _syncMaster();
                    },
                    shape: const CircleBorder(),
                  ),
                  const Text('[필수] 연령(만 14세 이상) 확인'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.black,
                    activeColor: Colors.transparent,
                    side: MaterialStateBorderSide.resolveWith(
                      (states) => const BorderSide(color: Color(0xff505050), width: 1.5),
                    ),
                    value: _isChecked4,
                    onChanged: (value) {
                      setState(() {
                        _isChecked4 = value ?? false;
                      });
                      _syncMaster();
                    },
                    shape: const CircleBorder(),
                  ),
                  const Text('[선택] 앱 푸시 및 마케팅/이벤트 수신 동의'),
                ],
              ),

              // 가입 버튼
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff94C6FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: _isLoading ? null : _register,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                      : const Text('가입하기', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TextStyle _hintStyle = const TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 19,
  letterSpacing: 0.6,
  color: Color(0xff8E8E8E),
);

TextStyle _joinStyle = const TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 23,
  letterSpacing: 0,
  color: Color(0xff000000),
);
