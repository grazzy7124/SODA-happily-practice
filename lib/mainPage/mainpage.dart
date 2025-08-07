import 'package:flutter/material.dart';
import 'package:ver1/mainPage/pageview.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> with TickerProviderStateMixin {
  double emotion = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Color? _thumbColor = Color.fromRGBO(217, 217, 217, 1);
  double _currentDiscreteSliderValue = 0;

  Color? getThumbColor(double value) {
    if (value == -10) {
      return Color.fromRGBO(255, 95, 98, 1);
    } else if (value < -5) {
      double t = (value + 10) / 5;
      return Color.lerp(
        Color.fromRGBO(255, 95, 98, 1),
        Color.fromRGBO(255, 165, 100, 1),
        t,
      );
    } else if (value == -5) {
      return Color.fromRGBO(255, 165, 100, 1);
    } else if (value < 0) {
      double t = (value + 5) / 5;
      return Color.lerp(
        Color.fromRGBO(255, 165, 100, 1),
        Color.fromRGBO(217, 217, 217, 1),
        t,
      );
    } else if (value == 0) {
      return Color.fromRGBO(217, 217, 217, 1);
    } else if (value < 5) {
      double t = (value) / 5;
      return Color.lerp(
        Color.fromRGBO(217, 217, 217, 1),
        Color.fromRGBO(136, 238, 209, 1),
        t,
      );
    } else if (value == 5) {
      return Color.fromRGBO(136, 238, 209, 1);
    } else if (value < 10) {
      double t = (value - 5) / 5;
      return Color.lerp(
        Color.fromRGBO(136, 238, 209, 1),
        Color.fromRGBO(148, 198, 255, 1),
        t,
      );
    } else if (value == 10) {
      return Color.fromRGBO(148, 198, 255, 1);
    }
    return _thumbColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            SizedBox(height: 33),
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 316,
                    height: 162,
                    child: Card(
                      color: Colors.white,
                      elevation: 4,
                      shadowColor: const Color.fromARGB(82, 0, 0, 0),
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 15),
                    Text(
                      '오늘은 어떤 하루였나요?',
                      style: TextStyle(
                        fontFamily: 'gangwon',
                        fontWeight: FontWeight.w300,
                        fontSize: 22,
                        letterSpacing: 0,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 55),
                        Text('꽝', style: _emotion),
                        SizedBox(width: 46),
                        Text('별로', style: _emotion),
                        SizedBox(width: 43),
                        Text('보통', style: _emotion),
                        SizedBox(width: 41),
                        Text('좋음', style: _emotion),
                        SizedBox(width: 32),
                        Text('완전 좋음', style: _emotion),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.spaceEvenly,
                          spacing: 20,
                          children: [
                            Image.asset(
                              'assets/images/emotions/emotion1.png',
                              width: 40,
                            ),
                            Image.asset(
                              'assets/images/emotions/emotion2.png',
                              width: 40,
                            ),
                            Image.asset(
                              'assets/images/emotions/emotion3.png',
                              width: 40,
                            ),
                            Image.asset(
                              'assets/images/emotions/emotion4.png',
                              width: 40,
                            ),
                            Image.asset(
                              'assets/images/emotions/emotion5.png',
                              width: 40,
                            ),
                          ],
                        ),
                      ],
                    ),
                    TweenAnimationBuilder(
                      duration: Duration(milliseconds: 500),
                      tween: ColorTween(begin: _thumbColor, end: _thumbColor),
                      builder: (context, animatedColor, child) {
                        return Slider(
                          inactiveColor: Color(0xffC6C6C6),
                          padding: EdgeInsets.only(
                            left: 55,
                            right: 55,
                            top: 20,
                          ),
                          max: 10,
                          min: -10,
                          divisions: 20,
                          onChangeEnd: (value) {
                            emotion = _currentDiscreteSliderValue;

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                elevation: 5,
                                content: Text(
                                  '   분석 탭에 저장!',
                                  style: TextStyle(
                                    fontFamily: 'gangwon',
                                    fontSize: 17,
                                  ),
                                ),
                                action: SnackBarAction(
                                  label: '확인',
                                  onPressed: () {
                                    // Code to execute.
                                  },
                                ),
                                duration: const Duration(milliseconds: 1500),
                                width: 200.0, // Width of the SnackBar.
                                padding: const EdgeInsets.symmetric(
                                  horizontal:
                                      8.0, // Inner padding for SnackBar content.
                                ),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            );
                          },
                          thumbColor: animatedColor,
                          activeColor: animatedColor,
                          label: _currentDiscreteSliderValue.round().toString(),
                          value: _currentDiscreteSliderValue,
                          onChanged: (double value) {
                            setState(() {
                              _currentDiscreteSliderValue = value;
                              emotion = value;
                              _thumbColor = getThumbColor(value);
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        // SizedBox(height: 58,),
        Expanded(child: DiaryPageView(currentEmotion: emotion)),
        // SizedBox(height: 62,)
      ],
    );
  }
}

TextStyle _textStyle = TextStyle(fontFamily: 'gangwon', fontSize: 15);

TextStyle _emotion = TextStyle(
  fontFamily: 'gangwon',
  fontWeight: FontWeight.bold,
  fontSize: 11,
  letterSpacing: 0,
);
