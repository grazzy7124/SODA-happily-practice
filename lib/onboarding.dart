import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCFAF5),
      body: Column(
        children: [
          SizedBox(height: 188.2,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/icon.png',
                width: 148,
              ),
            ],
          ),
          SizedBox(height: 50,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('해피리에 감정을 기록해 보세요', style: big,),
              SizedBox(height: 10,),
              Text('하루에 있었던 일과 감정을 기록하고,\n솔직한 나 자신과 마주하세요', style: small,)
            ],
          ),
          SizedBox(height: 80,),
          TextButton(
            style: ButtonStyle(
              fixedSize: WidgetStatePropertyAll(Size(325, 59)),
              backgroundColor: WidgetStateProperty.all(Color(0xff94C6FF)),
              shape: WidgetStatePropertyAll(
                RoundedSuperellipseBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            onPressed: () {}, 
            child: Text('계정이 없으신가요?', style: bluebutton,)
          ),
          SizedBox(height: 15,),
          TextButton(
            style: ButtonStyle(
              fixedSize: WidgetStatePropertyAll(Size(325, 59)),
              backgroundColor: WidgetStateProperty.all(Color(0xffFFFFFF)),
              shape: WidgetStatePropertyAll(
                RoundedSuperellipseBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: Colors.black,
                    width: 1
                  )
                ),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            }, 
            child: Text('계정이 이미 있어요', style: whitebutton,)
          ),
          
        ],
      ),
    );
  }
}

TextStyle big = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.w300,
  fontSize: 24,
  letterSpacing: 0,
  color: Color(0xff000000),
);

TextStyle small = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.w300,
  fontSize: 14,
  letterSpacing: 0,
  color: Color(0xff000000),
);

TextStyle bluebutton = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 17,
  letterSpacing: 0,
  color: Color(0xffFFFFFF),
);

TextStyle whitebutton = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 17,
  letterSpacing: 0,
  color: Color(0xff000000),
);

