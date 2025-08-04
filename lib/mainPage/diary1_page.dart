import 'package:flutter/material.dart';

class FirstDiaryPage extends StatefulWidget {
  const FirstDiaryPage({super.key});

  @override
  State<FirstDiaryPage> createState() => _FirstDiaryPageState();
}

class _FirstDiaryPageState extends State<FirstDiaryPage> {
  bool isChecked = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCFAF5),
      body: Column(
        children: [
          SizedBox(height: 30,),
          Container(
            height: 43,
            child: Stack(
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      child: Text('취소')
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked, 
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Text('공개'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: (){}, 
                      child: Text('등록')
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 1, width: double.infinity,
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                SizedBox(
                  height: 45,
                  child: Card(
                    color: Color(0xffD9ECFA),
                    child: Row(
                      children: [
                        Text('data')
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 180,
                ),
                SizedBox(
                  height: 45,
                  child: Card(
                    color: Color(0xffD9ECFA),
                    child: Row(
                      children: [
                        Text('data')
                      ],
                    ),
                  ),
                ),
                TextField(
                  
                ),
                TextField(
                  
                ),
                TextField(
                  
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}