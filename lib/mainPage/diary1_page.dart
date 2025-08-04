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
      body: Column(
        children: [
          SizedBox(height: 30,),
          Container(
            height: 43,
            decoration: BoxDecoration(
              border: Border.all(
                width: 3
              )
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: (){}, 
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
          )
        ],
      )
    );
  }
}