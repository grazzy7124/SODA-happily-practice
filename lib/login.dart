import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff94C6FF)),
      ),
      home: const MyHomePage(title: 'Happily'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _textEditingController1 = TextEditingController(); // 아이디
  final _textEditingController2 = TextEditingController(); // 비밀번호  
  late bool focused = false;

  final FocusNode _focusNode1 = FocusNode();
  Color fillColor = Color(0xffDBECFF);

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {
        fillColor = _focusNode1.hasFocus ? Color(0xffDBECFF) : Colors.white;
      });
    });
  }

  @override 
  void dispose() {
    _focusNode1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 133,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center ,
            children: [
              Image.asset(
                'assets/images/icon.png',
                width: 148.72, height: 122.6,
              ),
            ],
          ),
          SizedBox(height: 16.4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center ,
            children: [
              Image.asset(
                'assets/images/HAPPI-LY.png',
                width: 116, height: 39,
              ),
            ],
          ),
          SizedBox(height: 51,),
          SizedBox(
            width: 273,
            child: TextFormField(
              controller: _textEditingController1,
              decoration: InputDecoration(
                fillColor: fillColor,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Colors.black
                  )
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Color(0xff999999)
                  )
                ),
                hint: Text('아이디', style: TextStyle(color: Color(0xff999999)),),
              ),
            ),
          ),
          SizedBox(height: 12,),
          SizedBox(
            width: 273,
            child: TextFormField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Colors.black
                  )
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(

                    color: Color(0xff999999)
                  )
                ),
                hint: Text('비밀번호', style: TextStyle(color: Color(0xff999999)),),
              ),
            ),
            
          ),
          SizedBox(height: 22,),
          TextButton(
            style: ButtonStyle(
              fixedSize: WidgetStatePropertyAll(Size(273, 54)),
              backgroundColor: WidgetStateProperty.all(Color(0xff444444)),
              shape: WidgetStatePropertyAll(
                RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(5))
              )
            ),
            onPressed: (){}, 
            child: Text('로그인', style: TextStyle(color: Colors.white),)
          ),
          SizedBox(height: 40,),
          SizedBox(
            height: 40, width: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(Color.fromARGB(9, 0, 0, 0)),
                      fixedSize: WidgetStatePropertyAll(Size(80, 18)),
                      backgroundColor: WidgetStateProperty.all(Colors.transparent),
                      shape: WidgetStatePropertyAll(
                        RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(5))
                      )
                    ),
                    onPressed: (){}, 
                    child: Text('ID/PW 찾기', style: TextStyle(color: Color(0xffADADAD), fontSize: 16),)
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
                    overlayColor: WidgetStatePropertyAll(Color.fromARGB(9, 0, 0, 0)),
                    // fixedSize: WidgetStatePropertyAll(Size(80, 18)),
                    backgroundColor: WidgetStateProperty.all(Colors.transparent),
                    shape: WidgetStatePropertyAll(
                      RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(5))
                    )
                  ),
                  onPressed: (){}, 
                  child: Text('회원가입', style: TextStyle(color: Color(0xffADADAD), fontSize: 16),)
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
