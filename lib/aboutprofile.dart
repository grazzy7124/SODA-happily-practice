import 'package:flutter/material.dart';

class ProfileMy extends StatelessWidget {
  const ProfileMy({
    super.key,
    required this.main,
    required this.name,
    required this.friend,
    required this.onTap,
  });

  final String main;
  final String name;
  final String friend;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Padding(
        padding: EdgeInsets.only(left: 5, top: 6.94),
        child: Image.asset(main, width: 48, height: 48),
      ),
      title: Padding(
        padding: EdgeInsets.only(top: 7),
        child: Text(
          name,
          style: TextStyle(fontSize: 17, fontFamily: 'gangwon'),
        ),
      ),
      subtitle: Text(
        '$friend명의 친구',
        style: const TextStyle(fontSize: 10, fontFamily: 'gangwon'),
      ),
    );
  }
}

class ProfileList extends StatelessWidget {
  const ProfileList({
    super.key,
    required this.happliy,
    required this.title,
    required this.photo,
    required this.text,
    required this.text2,
    required this.date,
    required this.public,
    required this.diaryID,
    this.onTap,
  });

  final String happliy;
  final String title;
  final String photo;
  final String text;
  final String text2;
  final String date;
  final String public;
  final String diaryID;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(top: 5.5, left: 15, right: 15),
        child: Card(
          color: _colorForDiary(diaryID),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 15),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 15, fontFamily: 'gangwon'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 13),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    width: double.infinity,
                    height: 160,
                    photo,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 13, left: 17),
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 15, fontFamily: 'gangwon'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 17),
                child: Text(
                  text2,
                  style: const TextStyle(fontSize: 15, fontFamily: 'gangwon'),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 13),
                child: Row(
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'gangwon',
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      public,
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'gangwon',
                      ),
                    ),
                    const Spacer(),
                    Image.asset(happliy, width: 28, height: 23),
                    const SizedBox(width: 17),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Color _colorForDiary(String diaryID) {
  switch (diaryID) {
    case 'diary.emotion':
      return const Color(0xFFD9ECFA);
    case 'diary.happy':
      return const Color(0xFFFBFFD7);
    case 'diary.free':
      return const Color(0xFFF9EEF3);
    default:
      return Colors.white;
  }
}
