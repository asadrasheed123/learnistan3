import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hexcolor/hexcolor.dart';
class Inter extends StatefulWidget {
  const Inter({Key? key}) : super(key: key);

  @override
  State<Inter> createState() => _InterState();
}

class _InterState extends State<Inter> {
  final List<Map<String, dynamic>> items =
  [    {"name": "Books", "icon": Icons.book_sharp},
    {"name": "GuessPaper", "icon": Icons.phone_android},
    {"name": "Mcqs", "icon": Icons.question_answer_outlined},
    {"name": "Online Test", "icon": Icons.quiz},  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 30),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          physics: NeverScrollableScrollPhysics(),
          childAspectRatio: 1.2,
          crossAxisCount: 2,
          children: List.generate(items.length, (index) {
            Gradient gradient;
            switch (index) {
              case 0:
                gradient = LinearGradient(
                  colors: [Colors.lightGreenAccent,Colors.lightGreen],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                );
                break;
              case 1:
                gradient = LinearGradient(
                  colors: [Colors.purpleAccent,Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                );
                break;
              case 2:
                gradient = LinearGradient(
                  colors: [Colors.orangeAccent,Colors.deepOrange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                );
                break;
              case 3:
                gradient = LinearGradient(
                  colors: [Colors.cyanAccent,Colors.cyan],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                );
                break;
              default:
                gradient = LinearGradient(
                  colors: [Colors.purpleAccent,Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                );
            }

            return Container(
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    items[index]["icon"],
                    size: 50,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    items[index]["name"],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}